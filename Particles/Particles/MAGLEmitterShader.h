//
//  MAGLEmitterShader.h
//  ariel4
//
//  Created by Mark Kim on 3/30/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "MAGLShader.h"

@interface MAGLEmitterShader : MAGLShader

@property (nonatomic, assign) GLuint a_pStartTime;
@property (nonatomic, assign) GLuint a_pLifetimeOffset;
@property (nonatomic, assign) GLuint a_pSpeedOffset;
@property (nonatomic, assign) GLuint a_pAngleOffset;
@property (nonatomic, assign) GLuint a_pPhiOffset;
@property (nonatomic, assign) GLuint a_pAlphaStartOffset;
@property (nonatomic, assign) GLuint a_pScaleStartOffset;
@property (nonatomic, assign) GLuint a_pRotationStartOffset;
@property (nonatomic, assign) GLuint a_pPositionOffset;
@property (nonatomic, assign) GLuint a_pAccelerationOffset;
@property (nonatomic, assign) GLuint a_pColorOffset;

@property (nonatomic, assign) GLuint u_eLifetime;
@property (nonatomic, assign) GLuint u_eTime;
@property (nonatomic, assign) GLuint u_eSize;
@property (nonatomic, assign) GLuint u_eSpeed;
@property (nonatomic, assign) GLuint u_eAngle;
@property (nonatomic, assign) GLuint u_ePhi;
@property (nonatomic, assign) GLuint u_eAlphaStart;
@property (nonatomic, assign) GLuint u_eAlphaSpeed;
@property (nonatomic, assign) GLuint u_eAlphaCutoff;
@property (nonatomic, assign) GLuint u_eScaleStart;
@property (nonatomic, assign) GLuint u_eScaleSpeed;
@property (nonatomic, assign) GLuint u_ePerspectiveMaxDistance;
@property (nonatomic, assign) GLuint u_eRotationStart;
@property (nonatomic, assign) GLuint u_eRotationSpeed;
@property (nonatomic, assign) GLuint u_eAcceleration;
@property (nonatomic, assign) GLuint u_eColorStart;
@property (nonatomic, assign) GLuint u_eColorEnd;
@property (nonatomic, assign) GLuint u_ProjectionMatrix;
@property (nonatomic, assign) GLuint u_ModelMatrix;
@property (nonatomic, assign) GLuint u_Texture;

@end
