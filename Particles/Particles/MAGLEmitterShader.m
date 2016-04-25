//
//  MAGLEmitterShader.m
//  ariel4
//
//  Created by Mark Kim on 3/30/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "MAGLEmitterShader.h"

@implementation MAGLEmitterShader

- (void)loadWithProgram:(GLuint)program
{
    [super loadWithProgram:program];
    _a_pStartTime = glGetAttribLocation(program, "a_pStartTime");
    _a_pLifetimeOffset = glGetAttribLocation(program, "a_pLifetimeOffset");
    _a_pSpeedOffset = glGetAttribLocation(program, "a_pSpeedOffset");
    _a_pAngleOffset = glGetAttribLocation(program, "a_pAngleOffset");
    _a_pPhiOffset = glGetAttribLocation(program, "a_pPhiOffset");
    _a_pAlphaStartOffset = glGetAttribLocation(program, "a_pAlphaStartOffset");
    _a_pScaleStartOffset = glGetAttribLocation(program, "a_pScaleStartOffset");
    _a_pRotationStartOffset = glGetAttribLocation(program, "a_pRotationStartOffset");
    _a_pPositionOffset = glGetAttribLocation(program, "a_pPositionOffset");
    _a_pAccelerationOffset = glGetAttribLocation(program, "a_pAccelerationOffset");
    _a_pColorOffset = glGetAttribLocation(program, "a_pColorOffset");
    _u_eLifetime = glGetUniformLocation(program, "u_eLifetime");
    _u_eTime = glGetUniformLocation(program, "u_eTime");
    _u_eSize = glGetUniformLocation(program, "u_eSize");
    _u_eSpeed = glGetUniformLocation(program, "u_eSpeed");
    _u_eAngle = glGetUniformLocation(program, "u_eAngle");
    _u_ePhi = glGetUniformLocation(program, "u_ePhi");
    _u_eAlphaStart = glGetUniformLocation(program, "u_eAlphaStart");
    _u_eAlphaSpeed = glGetUniformLocation(program, "u_eAlphaSpeed");
    _u_eAlphaCutoff = glGetUniformLocation(program, "u_eAlphaCutoff");
    _u_eScaleStart = glGetUniformLocation(program, "u_eScaleStart");
    _u_eScaleSpeed = glGetUniformLocation(program, "u_eScaleSpeed");
    _u_ePerspectiveMaxDistance = glGetUniformLocation(program, "u_ePerspectiveMaxDistance");
    _u_eRotationStart = glGetUniformLocation(program, "u_eRotationStart");
    _u_eRotationSpeed = glGetUniformLocation(program, "u_eRotationSpeed");
    _u_eAcceleration = glGetUniformLocation(program, "u_eAcceleration");
    _u_eColorStart = glGetUniformLocation(program, "u_eColorStart");
    _u_eColorEnd = glGetUniformLocation(program, "u_eColorEnd");
    _u_ProjectionMatrix = glGetUniformLocation(program, "u_ProjectionMatrix");
    _u_ModelMatrix = glGetUniformLocation(program, "u_ModelMatrix");
    _u_Texture = glGetUniformLocation(program, "u_Texture");
}

@end
