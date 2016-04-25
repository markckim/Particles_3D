//
//  MAGLEmitter.h
//  ariel4
//
//  Created by Mark Kim on 5/31/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "MAGLRenderObject.h"
#import "MAEmitterConfig.h"

#define MA_NUM_PARTICLES 2000

typedef struct MAParticle
{
    // shader properties
    GLfloat             pStartTime;
    GLfloat             pLifetimeOffset;
    GLfloat             pSpeedOffset;
    GLfloat             pAngleOffset;
    GLfloat             pPhiOffset;
    GLfloat             pAlphaStartOffset;
    GLfloat             pScaleStartOffset;
    GLfloat             pRotationStartOffset;
    GLKVector3          pPositionOffset;
    GLKVector3          pAccelerationOffset;
    GLKVector3          pColorOffset;
}
MAParticle;

typedef struct MAEmitter
{
    // particles
    MAParticle          eParticles[MA_NUM_PARTICLES];
    
    // shader properties
    GLfloat             eLifetime;
    GLfloat             eTime;
    GLfloat             eSize;
    GLfloat             eSpeed;
    GLfloat             eAngle;
    GLfloat             ePhi;
    GLfloat             eAlphaStart;
    GLfloat             eAlphaSpeed;
    GLfloat             eAlphaCutoff;
    GLfloat             eScaleStart;
    GLfloat             eScaleSpeed;
    GLfloat             ePerspectiveMaxDistance;
    GLfloat             eRotationStart;
    GLfloat             eRotationSpeed;
    GLKVector3          eAcceleration;
    GLKVector3          eColorStart;
    GLKVector3          eColorEnd;
    
    // object properties
    GLfloat             birthRate;
    GLfloat             inverseBirthRate;
    GLfloat             maximumParticles;
    GLfloat             emitterLifetime;
    GLfloat             emitterRotationSpeedX;
    GLfloat             emitterRotationSpeedY;
    GLfloat             emitterRotationSpeedZ;
    GLKVector3          position;
}
MAEmitter;

@interface MAGLEmitter : MAGLRenderObject

@property (nonatomic, assign) MAEmitter emitter;
@property (nonatomic, assign) GLKMatrix4 modelMatrix;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;

- (instancetype)initWithConfig:(MAEmitterConfig *)config;
- (MAEmitterConfig *)config;

@end
