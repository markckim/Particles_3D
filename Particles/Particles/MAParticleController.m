//
//  MAParticleController.m
//  Particles
//
//  Created by Mark Kim on 4/25/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAParticleController.h"
#import "MAEmitterConfig.h"
#import "MAGLEmitter.h"
#import "MAGLShader.h"
#import "MAGLHelper.h"
#import "UIScreen+ScreenSize.h"
#import "UIAlertView+Blocks.h"
#import "gl_functions.h"
#import "math_functions.h"

#define FOVY_DEGREES 45.0
#define NEAR_Z 0.01
#define FAR_Z 100.0
#define POSITION_Z -6.0

@interface MAParticleController ()

@property (nonatomic, strong) MAEmitterConfig *selectedConfig;
@property (nonatomic, strong) NSMutableArray *configs;
@property (nonatomic, strong) NSMutableArray *resourceNames;
@property (nonatomic, strong) NSMutableArray *emitters;
@property (nonatomic, assign) GLuint emitterProgram;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;

@end

@implementation MAParticleController

- (void)dealloc
{
    glDeleteProgram(_emitterProgram);
}

- (void)_renderEmitter
{
    glBlendFunc(GL_ONE, GL_ONE);
    for (MAGLEmitter *emitter in _emitters) {
        if (glIsProgram(emitter.shader.program)) {
            [emitter render];
        } else {
            NSLog(@"something wrong with emitter's program");
        }
    }
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}

- (void)renderWithView:(GLKView *)view
{
    [self _renderEmitter];
}

- (void)update:(NSTimeInterval)deltaTime
{
    NSMutableArray *deadEmitters = [[NSMutableArray alloc] init];
    for (MAGLEmitter *emitter in _emitters) {
        [emitter update:deltaTime];
        if (emitter.emitter.emitterLifetime > 0 && emitter.emitter.eTime > emitter.emitter.emitterLifetime) {
            [deadEmitters addObject:emitter];
        }
    }
    for (MAGLEmitter *emitter in deadEmitters) {
        [_emitters removeObject:emitter];
    }
}

- (void)setupProjections
{
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(FOVY_DEGREES), [UIScreen aspectRatio], NEAR_Z, FAR_Z);
}

- (void)createParticleWithStartLocation:(CGPoint)startLocation
{
    if (_selectedConfig) {
        // startLocation is the screen touch point
        // calculate the position of the emitter in open gl space based on the screen touch point
        double distanceToScreenZ = originScreenZ([UIScreen screenSize], FOVY_DEGREES);
        GLKVector3 directionVector = directionVector3(startLocation, distanceToScreenZ);
        CGFloat factor = distanceToScreenZ / POSITION_Z;
        CGFloat glPositionX = directionVector.x / factor;
        CGFloat glPositionY = directionVector.y / factor;
        
        // create emitter and initialize with starting position in open gl space
        MAGLEmitter *emitter = [[MAGLEmitter alloc] initWithConfig:_selectedConfig];
        [emitter setupWithProgram:_emitterProgram userInfo:@{@"ePositionX": @(glPositionX), @"ePositionY": @(glPositionY), @"ePositionZ": @(POSITION_Z)}];
        emitter.projectionMatrix = _projectionMatrix;
        [_emitters addObject:emitter];
    } else {
        NSLog(@"missing selectedConfig; cannot create particle");
    }
}

- (void)showOptions
{
    if ([_resourceNames count] > 0) {
        [UIAlertView showWithTitle:@"Menu"
                           message:@"Choose"
                 cancelButtonTitle:@"Cancel"
                 otherButtonTitles:_resourceNames
                          tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                              for (int i=0; i<[_resourceNames count]; ++i) {
                                  NSString *resourceName = _resourceNames[i];
                                  if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:resourceName]) {
                                      MAEmitterConfig *config = _configs[i];
                                      if (config) {
                                          _selectedConfig = config;
                                      } else {
                                          NSLog(@"error: config unable to be selected with resourceName: %@", resourceName);
                                      }
                                      return;
                                  }
                              }
                          }];
    } else {
        NSLog(@"error: resourceNames is empty");
    }
}

- (instancetype)initWithResourceNames:(NSArray *)resourceNames
{
    if (self = [self init]) {
        for (NSString *resourceName in resourceNames) {
            NSString *type = @"json";
            NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:type];
            NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            MAEmitterConfig *config = [[MAEmitterConfig alloc] initWithString:content usingEncoding:NSUTF8StringEncoding error:nil];
            if (config) {
                config.name = resourceName;
                [_configs addObject:config];
                [_resourceNames addObject:resourceName];
            } else {
                NSLog(@"error: something wrong with config with resourceName: %@", resourceName);
            }
        }
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        _configs = [[NSMutableArray alloc] init];
        _resourceNames = [[NSMutableArray alloc] init];
        _emitters = [[NSMutableArray alloc] init];
        _emitterProgram = [MAGLHelper createProgramWithVertexShaderName:@"EmitterVertex" fragmentShaderName:@"EmitterFragment"];
    }
    return self;
}

@end
