//
//  MAParticleConfig.h
//  ariel3
//
//  Created by Mark Kim on 2/9/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "MAObject.h"

@interface MAParticleConfig : MAObject

@property (nonatomic, assign) GLfloat       lifetimeRange;
@property (nonatomic, assign) GLfloat       speedRange;
@property (nonatomic, assign) GLfloat       angleRange;
@property (nonatomic, assign) GLfloat       phiRange;
@property (nonatomic, assign) GLfloat       alphaStartRange;
@property (nonatomic, assign) GLfloat       phiStartRange;
@property (nonatomic, assign) GLfloat       scaleStartRange;
@property (nonatomic, assign) GLfloat       rotationStartRange;
@property (nonatomic, assign) GLKVector3    positionRange;
@property (nonatomic, assign) GLfloat       positionRadius;
@property (nonatomic, assign) GLfloat       positionRadiusRange;
@property (nonatomic, assign) GLfloat       positionTheta;
@property (nonatomic, assign) GLfloat       positionThetaRange;
@property (nonatomic, assign) GLfloat       positionPhi;
@property (nonatomic, assign) GLfloat       positionPhiRange;
@property (nonatomic, assign) GLKVector3    forcePositionOffset;
@property (nonatomic, assign) GLfloat       forceValue;
@property (nonatomic, assign) GLKVector3    colorRange;
@property (nonatomic, assign) GLint         isPositionRectangular;
@property (nonatomic, assign) GLint         isPositionRadial;
@property (nonatomic, assign) GLint         isForcePresent;

@end
