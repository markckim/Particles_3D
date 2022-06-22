//
//  MAParticleController.h
//  Particles
//
//  Created by Mark Kim on 4/25/16.
//  Copyright © 2016 Mark Kim. All rights reserved.
//

#import "MAGLController.h"

@class MAEmitterConfig;

@interface MAParticleController : MAGLController

- (void)createParticleWithStartLocation:(CGPoint)startLocation;
- (void)showOptions;
- (instancetype)initWithResourceNames:(NSArray *)resourceNames resourceDisplayedNames:(NSArray *)resourceDisplayedNames;

@end
