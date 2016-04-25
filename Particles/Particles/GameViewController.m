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
    NSArray *resourceNames = @[@"RedRotationEmitter", @"BlueExplosionEmitter", @"PinkFireworksEmitter"];
    
    // set particle controller
    _particleController = [[MAParticleController alloc] initWithResourceNames:resourceNames];
    [_particleController showOptions];
    [self addController:_particleController];
}

@end
