//
//  MAEmitterConfig.h
//  ariel4
//
//  Created by Mark Kim on 6/13/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//
//  @discussion
//  + lifetime refers to particle lifetime, differing from emitterLifetime; lifetime is normally shorter than emitterLifetime
//  + setting emitterLifetime to <= 0 means it will last indefinitely
//  + if you use additive blending (i.e., glBlendFunc(GL_ONE, GL_ONE)), alpha values will have no effect
//  + pixels with alpha < alphaCutoff will be discarded in EmitterFragment
//  + if alpha < -0.5, then we assume v_pAlpha will not be used in EmitterFragment; instead, the texture alpha value will be used
//  + forcePositionOffset is a point where a "force" is present and can affect particle acceleration; forcePositionOffset is relative to emitter position
//  + if forceValue is positive, it is an "outward" force originating from forcePosition
//  + if forceValue is negative, it is an "inward" force originating from forcePosition
//  + positionTheta = 90 keeps x = 0 (given positionThetaRange = 0)
//  + positionTheta = 0 keeps y = 0 (given positionThetaRange = 0)
//  + positionPhi = 90 keeps z = 0 (given positionPhiRange = 0)
//  + spherical coordinate conversion:
//  + x = r * sin(phi) * cos(theta)
//  + y = r * sin(phi) * sin(theta)
//  + z = r * cos(phi)

#import "JSONModel.h"

@interface MAEmitterConfig : JSONModel

// meta
@property (nonatomic, copy) NSString<Ignore> *name;

// emitter config
@property (nonatomic, assign) double lifetime;
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) double angle;
@property (nonatomic, assign) double phi;
@property (nonatomic, assign) double alpha;
@property (nonatomic, assign) double alphaSpeed;
@property (nonatomic, assign) double alphaCutoff;
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double scaleSpeed;
@property (nonatomic, assign) double perspectiveMaxDistance;
@property (nonatomic, assign) double rotation;
@property (nonatomic, assign) double rotationSpeed;
@property (nonatomic, assign) double emitterLifetime;
@property (nonatomic, assign) double emitterRotationX;
@property (nonatomic, assign) double emitterRotationY;
@property (nonatomic, assign) double emitterRotationZ;
@property (nonatomic, assign) double emitterRotationSpeedX;
@property (nonatomic, assign) double emitterRotationSpeedY;
@property (nonatomic, assign) double emitterRotationSpeedZ;
@property (nonatomic, assign) double accelerationX;
@property (nonatomic, assign) double accelerationY;
@property (nonatomic, assign) double accelerationZ;
@property (nonatomic, assign) double colorR;
@property (nonatomic, assign) double colorG;
@property (nonatomic, assign) double colorB;
@property (nonatomic, assign) double colorEndR;
@property (nonatomic, assign) double colorEndG;
@property (nonatomic, assign) double colorEndB;
@property (nonatomic, assign) double birthRate;
@property (nonatomic, assign) double maximumParticles;
@property (nonatomic, copy) NSString *imageName;

// particle config
@property (nonatomic, assign) double lifetimeRange;
@property (nonatomic, assign) double speedRange;
@property (nonatomic, assign) double angleRange;
@property (nonatomic, assign) double phiRange;
@property (nonatomic, assign) double alphaRange;
@property (nonatomic, assign) double scaleRange;
@property (nonatomic, assign) double rotationRange;
@property (nonatomic, assign) double positionRangeX;
@property (nonatomic, assign) double positionRangeY;
@property (nonatomic, assign) double positionRangeZ;
@property (nonatomic, assign) double positionRadius;
@property (nonatomic, assign) double positionRadiusRange;
@property (nonatomic, assign) double positionTheta;
@property (nonatomic, assign) double positionThetaRange;
@property (nonatomic, assign) double positionPhi;
@property (nonatomic, assign) double positionPhiRange;
@property (nonatomic, assign) double forcePositionOffsetX;
@property (nonatomic, assign) double forcePositionOffsetY;
@property (nonatomic, assign) double forcePositionOffsetZ;
@property (nonatomic, assign) double forceValue;
@property (nonatomic, assign) double colorRangeR;
@property (nonatomic, assign) double colorRangeG;
@property (nonatomic, assign) double colorRangeB;
@property (nonatomic, assign) NSInteger isPositionRectangular;
@property (nonatomic, assign) NSInteger isPositionRadial;
@property (nonatomic, assign) NSInteger isForcePresent;

@end
