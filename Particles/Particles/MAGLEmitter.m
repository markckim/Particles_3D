//
//  MAGLEmitter.m
//  ariel4
//
//  Created by Mark Kim on 5/31/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "MAGLEmitter.h"
#import "MAParticleConfig.h"
#import "MAGLEmitterShader.h"
#import "gl_functions.h"
#import "math_functions.h"

@interface MAGLEmitter ()

@property (nonatomic, strong) MAEmitterConfig   *config;
@property (nonatomic, strong) MAParticleConfig  *particleConfig;
@property (nonatomic, assign) GLuint            texture0;
@property (nonatomic, assign) NSTimeInterval    accumulatedTime;
@property (nonatomic, assign) GLfloat           emitterRotationX;
@property (nonatomic, assign) GLfloat           emitterRotationY;
@property (nonatomic, assign) GLfloat           emitterRotationZ;
@property (nonatomic, assign) GLfloat           maximumItemsToDraw;
@property (nonatomic, strong) UIImage           *image;

@end

@implementation MAGLEmitter

- (void)dealloc
{
    glDeleteTextures(1, &_texture0);
}

- (void)_updateMaximumItemsToDraw
{
    if (_emitter.inverseBirthRate > 0.0) {
        GLfloat maxParticles = (GLfloat)(2.0 * MIN(ceil((_emitter.eLifetime + ABS(_particleConfig.lifetimeRange)) / _emitter.inverseBirthRate), MA_NUM_PARTICLES));
        if (_emitter.maximumParticles > 0.0) {
            maxParticles = MIN(_emitter.maximumParticles, maxParticles);
        }
        _maximumItemsToDraw = maxParticles;
    } else {
        NSLog(@"_emitterConfig.inverseBirthRate not set");
    }
}

- (void)setEmitter:(MAEmitter)emitter
{
    _emitter = emitter;
    [self _updateMaximumItemsToDraw];
}

- (void)setupWithProgram:(GLuint)program userInfo:(NSDictionary *)userInfo
{
    [super setupWithProgram:program userInfo:userInfo];
    
    // config
    MAEmitterConfig *config = [self config];
    
    // texture
    // _image is currently only used to determine "size" of the particle
    _image = [UIImage imageNamed:config.imageName];
    _texture0 = setupTextureWithImage(self.image);
    
    // emitter rotation
    _emitterRotationX = config.emitterRotationX;
    _emitterRotationY = config.emitterRotationY;
    _emitterRotationZ = config.emitterRotationZ;
    
    // particle config
    self.particleConfig = [[MAParticleConfig alloc] init];
    self.particleConfig.lifetimeRange = config.lifetimeRange;
    self.particleConfig.speedRange = config.speedRange;
    self.particleConfig.angleRange = GLKMathDegreesToRadians(config.angleRange);
    self.particleConfig.phiRange = GLKMathDegreesToRadians(config.phiRange);
    self.particleConfig.alphaStartRange = config.alphaRange;
    self.particleConfig.scaleStartRange = config.scaleRange;
    self.particleConfig.rotationStartRange = GLKMathDegreesToRadians(config.rotationRange);
    self.particleConfig.positionRange = GLKVector3Make(config.positionRangeX, config.positionRangeY, config.positionRangeZ);
    self.particleConfig.colorRange = GLKVector3Make(config.colorRangeR, config.colorRangeG, config.colorRangeB);
    self.particleConfig.positionRadius = config.positionRadius;
    self.particleConfig.positionRadiusRange = config.positionRadiusRange;
    self.particleConfig.positionTheta = GLKMathDegreesToRadians(config.positionTheta);
    self.particleConfig.positionThetaRange = GLKMathDegreesToRadians(config.positionThetaRange);
    self.particleConfig.positionPhi = GLKMathDegreesToRadians(config.positionPhi);
    self.particleConfig.positionPhiRange = GLKMathDegreesToRadians(config.positionPhiRange);
    self.particleConfig.forcePositionOffset = GLKVector3Make(config.forcePositionOffsetX, config.forcePositionOffsetY, config.forcePositionOffsetZ);
    self.particleConfig.forceValue = (GLfloat)config.forceValue;
    self.particleConfig.isPositionRectangular = (GLint)config.isPositionRectangular;
    self.particleConfig.isPositionRadial = (GLint)config.isPositionRadial;
    self.particleConfig.isForcePresent = (GLint)config.isForcePresent;
    
    // emitter config
    MAEmitter newEmitter = {0.0};
    newEmitter.eLifetime = config.lifetime;
    newEmitter.eTime = 0.0;
    newEmitter.eSpeed = config.speed;
    newEmitter.eAngle = GLKMathDegreesToRadians(config.angle);
    newEmitter.ePhi = GLKMathDegreesToRadians(config.phi);
    newEmitter.eAlphaStart = config.alpha;
    newEmitter.eAlphaSpeed = config.alphaSpeed;
    newEmitter.eAlphaCutoff = config.alphaCutoff;
    newEmitter.eScaleStart = config.scale;
    newEmitter.eScaleSpeed = config.scaleSpeed;
    newEmitter.ePerspectiveMaxDistance = config.perspectiveMaxDistance;
    newEmitter.eRotationStart = GLKMathDegreesToRadians(config.rotation);
    newEmitter.eRotationSpeed = GLKMathDegreesToRadians(config.rotationSpeed);
    newEmitter.eAcceleration = GLKVector3Make(config.accelerationX, config.accelerationY, config.accelerationZ);
    newEmitter.eColorStart = GLKVector3Make(config.colorR, config.colorG, config.colorB);
    newEmitter.eColorEnd = GLKVector3Make(config.colorEndR, config.colorEndG, config.colorEndB);
    newEmitter.birthRate = config.birthRate;
    newEmitter.inverseBirthRate = 1.0 / config.birthRate;
    newEmitter.maximumParticles = config.maximumParticles;
    newEmitter.emitterLifetime = config.emitterLifetime;
    newEmitter.emitterRotationSpeedX = config.emitterRotationSpeedX;
    newEmitter.emitterRotationSpeedY = config.emitterRotationSpeedY;
    newEmitter.emitterRotationSpeedZ = config.emitterRotationSpeedZ;
    newEmitter.eSize = _image.size.width;
    newEmitter.position = GLKVector3Make([userInfo[@"ePositionX"] floatValue], [userInfo[@"ePositionY"] floatValue], [userInfo[@"ePositionZ"] floatValue]);
    
    for (NSUInteger i=0; i<MA_NUM_PARTICLES; ++i) {
        MAParticle placeholderParticle = {0.0};
        // set pStartTime past lifetime (i.e., this is a dead particle)
        placeholderParticle.pStartTime = -1.0 * (newEmitter.eLifetime + 1.0);
        newEmitter.eParticles[i] = placeholderParticle;
    }
    self.emitter = newEmitter;
    
    // generate vertex buffer
    if (!glIsBuffer(self.buffer0)) {
        glGenBuffers(1, [self bufferRef0]);
        glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
        glBufferData(GL_ARRAY_BUFFER, sizeof(self.emitter.eParticles), self.emitter.eParticles, GL_DYNAMIC_DRAW);
    }
}

- (void)render
{
    [super render];
    glUseProgram(self.shader.program);
    glActiveTexture(GL_TEXTURE0);
    
    glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
    MAGLEmitterShader *shader = (MAGLEmitterShader *)self.shader;
    glUniformMatrix4fv(shader.u_ProjectionMatrix, 1, 0, _projectionMatrix.m);
    glUniformMatrix4fv(shader.u_ModelMatrix, 1, 0, _modelMatrix.m);
    glUniform1f(shader.u_eLifetime, _emitter.eLifetime);
    glUniform1f(shader.u_eTime, _emitter.eTime);
    glUniform1f(shader.u_eSize, _emitter.eSize);
    glUniform1f(shader.u_eSpeed, _emitter.eSpeed);
    glUniform1f(shader.u_eAngle, _emitter.eAngle);
    glUniform1f(shader.u_ePhi, _emitter.ePhi);
    glUniform1f(shader.u_eAlphaStart, _emitter.eAlphaStart);
    glUniform1f(shader.u_eAlphaSpeed, _emitter.eAlphaSpeed);
    glUniform1f(shader.u_eAlphaCutoff, _emitter.eAlphaCutoff);
    glUniform1f(shader.u_eScaleStart, _emitter.eScaleStart);
    glUniform1f(shader.u_eScaleSpeed, _emitter.eScaleSpeed);
    glUniform1f(shader.u_ePerspectiveMaxDistance, _emitter.ePerspectiveMaxDistance);
    glUniform1f(shader.u_eRotationStart, _emitter.eRotationStart);
    glUniform1f(shader.u_eRotationSpeed, _emitter.eRotationSpeed);
    glUniform3f(shader.u_eAcceleration, _emitter.eAcceleration.x, _emitter.eAcceleration.y, _emitter.eAcceleration.z);
    glUniform3f(shader.u_eColorStart, _emitter.eColorStart.r, _emitter.eColorStart.g, _emitter.eColorStart.b);
    glUniform3f(shader.u_eColorEnd, _emitter.eColorEnd.r, _emitter.eColorEnd.g, _emitter.eColorEnd.b);
    
    glBindTexture(GL_TEXTURE_2D, self.texture0);
    glUniform1i(shader.u_Texture, 0);
    
    glEnableVertexAttribArray(shader.a_pStartTime);
    glEnableVertexAttribArray(shader.a_pLifetimeOffset);
    glEnableVertexAttribArray(shader.a_pSpeedOffset);
    glEnableVertexAttribArray(shader.a_pAngleOffset);
    glEnableVertexAttribArray(shader.a_pPhiOffset);
    glEnableVertexAttribArray(shader.a_pAlphaStartOffset);
    glEnableVertexAttribArray(shader.a_pScaleStartOffset);
    glEnableVertexAttribArray(shader.a_pRotationStartOffset);
    glEnableVertexAttribArray(shader.a_pPositionOffset);
    glEnableVertexAttribArray(shader.a_pAccelerationOffset);
    glEnableVertexAttribArray(shader.a_pColorOffset);
    
    glVertexAttribPointer(shader.a_pStartTime, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pStartTime));
    glVertexAttribPointer(shader.a_pLifetimeOffset, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pLifetimeOffset));
    glVertexAttribPointer(shader.a_pSpeedOffset, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pSpeedOffset));
    glVertexAttribPointer(shader.a_pAngleOffset, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pAngleOffset));
    glVertexAttribPointer(shader.a_pPhiOffset, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pPhiOffset));
    glVertexAttribPointer(shader.a_pAlphaStartOffset, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pAlphaStartOffset));
    glVertexAttribPointer(shader.a_pScaleStartOffset, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pScaleStartOffset));
    glVertexAttribPointer(shader.a_pRotationStartOffset, 1, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pRotationStartOffset));
    glVertexAttribPointer(shader.a_pPositionOffset, 3, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pPositionOffset));
    glVertexAttribPointer(shader.a_pAccelerationOffset, 3, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pAccelerationOffset));
    glVertexAttribPointer(shader.a_pColorOffset, 3, GL_FLOAT, GL_FALSE, sizeof(MAParticle), (void *)offsetof(MAParticle, pColorOffset));
    
#ifdef DEBUG
    if (!_maximumItemsToDraw) {
        NSLog(@"_maximumItemsToDraw not set");
    }
#endif
    glDrawArrays(GL_POINTS, 0, _maximumItemsToDraw);
    
    glDisableVertexAttribArray(shader.a_pStartTime);
    glDisableVertexAttribArray(shader.a_pLifetimeOffset);
    glDisableVertexAttribArray(shader.a_pSpeedOffset);
    glDisableVertexAttribArray(shader.a_pAngleOffset);
    glDisableVertexAttribArray(shader.a_pPhiOffset);
    glDisableVertexAttribArray(shader.a_pAlphaStartOffset);
    glDisableVertexAttribArray(shader.a_pScaleStartOffset);
    glDisableVertexAttribArray(shader.a_pRotationStartOffset);
    glDisableVertexAttribArray(shader.a_pPositionOffset);
    glDisableVertexAttribArray(shader.a_pAccelerationOffset);
    glDisableVertexAttribArray(shader.a_pColorOffset);
}

- (MAParticle)_randomParticle
{
    MAParticle particle = {0.0};
    particle.pStartTime = _emitter.eTime;
    particle.pLifetimeOffset = (GLfloat)randomBetween(-_particleConfig.lifetimeRange, _particleConfig.lifetimeRange);
    particle.pSpeedOffset = (GLfloat)randomBetween(-_particleConfig.speedRange, _particleConfig.speedRange);
    particle.pAngleOffset = (GLfloat)randomBetween(-_particleConfig.angleRange, _particleConfig.angleRange);
    particle.pPhiOffset = (GLfloat)randomBetween(-_particleConfig.phiRange, _particleConfig.phiRange);
    particle.pAlphaStartOffset = (GLfloat)randomBetween(-_particleConfig.alphaStartRange, _particleConfig.alphaStartRange);
    particle.pScaleStartOffset = (GLfloat)randomBetween(-_particleConfig.scaleStartRange, _particleConfig.scaleStartRange);
    particle.pRotationStartOffset = (GLfloat)randomBetween(-_particleConfig.rotationStartRange, _particleConfig.rotationStartRange);
    GLKVector3 positionOffset = GLKVector3Make(0, 0, 0);
    // rectangular position
    if (_particleConfig.isPositionRectangular > 0) {
        GLKVector3 positionRectangular = GLKVector3Make((GLfloat)randomBetween(-_particleConfig.positionRange.x, _particleConfig.positionRange.x),
                                                        (GLfloat)randomBetween(-_particleConfig.positionRange.y, _particleConfig.positionRange.y),
                                                        (GLfloat)randomBetween(-_particleConfig.positionRange.z, _particleConfig.positionRange.z));
        positionOffset = GLKVector3Add(positionOffset, positionRectangular);
    }
    // radial position
    if (_particleConfig.isPositionRadial > 0) {
        GLfloat positionRadius = (GLfloat)_particleConfig.positionRadius + (GLfloat)randomBetween(-_particleConfig.positionRadiusRange, _particleConfig.positionRadiusRange);
        GLfloat positionTheta = (GLfloat)_particleConfig.positionTheta + (GLfloat)randomBetween(-_particleConfig.positionThetaRange, _particleConfig.positionThetaRange);
        GLfloat positionPhi = (GLfloat)_particleConfig.positionPhi + (GLfloat)randomBetween(-_particleConfig.positionPhiRange, _particleConfig.positionPhiRange);
        GLfloat rSinPhi = (GLfloat)(positionRadius * sin(positionPhi));
        GLKVector3 positionRadial = GLKVector3Make(rSinPhi * (GLfloat)cos(positionTheta),
                                                   rSinPhi * (GLfloat)sin(positionTheta),
                                                   (GLfloat)(positionRadius * cos(positionPhi)));
        positionOffset = GLKVector3Add(positionOffset, positionRadial);
    }
    particle.pPositionOffset = positionOffset;
    particle.pAccelerationOffset = GLKVector3Make(0.0, 0.0, 0.0);
    // acceleration offset
    if (_particleConfig.isForcePresent > 0) {
        // calculate difference vector between forcePositionOffset and positionOffset
        // normalize vector
        // multiply by forceValue
        GLKVector3 normalized_differenceVector = GLKVector3Normalize(GLKVector3Subtract(positionOffset, _particleConfig.forcePositionOffset));
        GLKVector3 forceVector = GLKVector3MultiplyScalar(normalized_differenceVector, _particleConfig.forceValue);
        particle.pAccelerationOffset = forceVector;
    }
    
    particle.pColorOffset = GLKVector3Make((GLfloat)randomBetween(-_particleConfig.colorRange.r, _particleConfig.colorRange.r),
                                           (GLfloat)randomBetween(-_particleConfig.colorRange.g, _particleConfig.colorRange.g),
                                           (GLfloat)randomBetween(-_particleConfig.colorRange.b, _particleConfig.colorRange.b));
    return particle;
}

- (void)_addParticlesWithAmount:(NSUInteger)amount
{
    NSUInteger particlesAdded = 0;
    for (NSUInteger i=0; i<MA_NUM_PARTICLES; ++i) {
        // look for a dead particle
        MAParticle particle = _emitter.eParticles[i];
        if ((_emitter.eTime - particle.pStartTime) > _emitter.eLifetime) {
            // this is a dead emitter; we can consider replacing it
            // consider time left until emitter will be dead
            GLfloat emitterTimeLeft = _emitter.emitterLifetime > 0 ? MAX(0.0, _emitter.emitterLifetime - _emitter.eTime) : 999999999;
            GLfloat maxParticleLifetime = _emitter.eLifetime + ABS(_particleConfig.lifetimeRange);
            if (emitterTimeLeft > maxParticleLifetime) {
                // particle lifetime will end before emitter lifetime
                _emitter.eParticles[i] = [self _randomParticle];
                particlesAdded += 1;
                if (particlesAdded >= amount) {
                    break;
                }
            } else {
                break;
            }
        }
    }
}

- (void)_updateRotationWithDeltaTime:(NSTimeInterval)deltaTime
{
    _emitterRotationX += _emitter.emitterRotationSpeedX * deltaTime;
    _emitterRotationY += _emitter.emitterRotationSpeedY * deltaTime;
    _emitterRotationZ += _emitter.emitterRotationSpeedZ * deltaTime;
    while (_emitterRotationX > 360.0) {
        _emitterRotationX -= 360.0;
    }
    while (_emitterRotationY > 360.0) {
        _emitterRotationY -= 360.0;
    }
    while (_emitterRotationZ > 360.0) {
        _emitterRotationZ -= 360.0;
    }
}

- (void)_updateModelMatrix
{
    _modelMatrix = GLKMatrix4Identity;
    _modelMatrix = GLKMatrix4TranslateWithVector3(_modelMatrix, GLKVector3Make(_emitter.position.x, _emitter.position.y, _emitter.position.z));
    _modelMatrix = GLKMatrix4RotateX(_modelMatrix, GLKMathDegreesToRadians(_emitterRotationX));
    _modelMatrix = GLKMatrix4RotateY(_modelMatrix, GLKMathDegreesToRadians(_emitterRotationY));
    _modelMatrix = GLKMatrix4RotateZ(_modelMatrix, GLKMathDegreesToRadians(_emitterRotationZ));
}

- (void)_updateEmitterWithDeltaTime:(NSTimeInterval)deltaTime
{
    _emitter.eTime += (GLfloat)deltaTime * 1.0;
}

- (void)_addParticlesWithDeltaTime:(NSTimeInterval)deltaTime
{
    _accumulatedTime += deltaTime;
    // load more particles, if needed (based on birthRate)
    if (_accumulatedTime > _emitter.inverseBirthRate) {
        NSUInteger numberOfParticlesToAdd = floor(_accumulatedTime / _emitter.inverseBirthRate);
        _accumulatedTime -= ((NSTimeInterval)numberOfParticlesToAdd) * _emitter.inverseBirthRate;
        [self _addParticlesWithAmount:numberOfParticlesToAdd];
    }
}

- (void)update:(NSTimeInterval)deltaTime
{
    [self _addParticlesWithDeltaTime:deltaTime];
    [self _updateEmitterWithDeltaTime:deltaTime];
    [self _updateRotationWithDeltaTime:deltaTime];
    [self _updateModelMatrix];
    glBindBuffer(GL_ARRAY_BUFFER, self.buffer0);
    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(self.emitter.eParticles), self.emitter.eParticles);
}

- (instancetype)initWithConfig:(MAEmitterConfig *)config
{
    if (self = [self init]) {
        _config = config;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        _accumulatedTime = 0.0;
        self.shader = [[MAGLEmitterShader alloc] init];
    }
    return self;
}

@end
