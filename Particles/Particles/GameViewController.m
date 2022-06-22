//
//  GameViewController.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "GameViewController.h"
#import "MAParticleController.h"
#import "MAEmitterConfig.h"

@interface GameViewController ()

@property (nonatomic, strong) MAParticleController *particleController;

@end

@implementation GameViewController

- (IBAction)didTapOptionsButton:(id)sender
{
    [_particleController showOptions];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touches.anyObject locationInView:self.view];
    [_particleController createParticleWithStartLocation:touchPoint];
}

- (void)setupControllers
{
    [super setupControllers];
    
    // set resource names
    NSArray *resourceNames = @[@"BlueExplosionEmitter",
                               @"BlueExplosionEmitterNearForceSource",
                               @"RedRotationXEmitter",
                               @"RedRotationYEmitter",
                               @"RainbowFireworksEmitter"];

    // set resource displayed names
    NSArray *resourceDisplayedNames = @[@"Explosion (constant speed)",
                                        @"Explosion (outward force)",
                                        @"X-axis Rotation (inward force)",
                                        @"Y-axis Rotation (inward force)",
                                        @"Fireworks (gravity)"];

    // set particle controller
    _particleController = [[MAParticleController alloc] initWithResourceNames:resourceNames resourceDisplayedNames:resourceDisplayedNames];
    [_particleController showOptions];
    [self addController:_particleController];
}

@end
