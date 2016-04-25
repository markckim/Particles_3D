//
//  MAGLKBaseViewController.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import <GLKit/GLKit.h>

@class MAGLController;

@interface MAGLKBaseViewController : GLKViewController

@property (nonatomic, assign) BOOL isGamePaused;
@property (nonatomic, strong) EAGLContext *context;

- (void)updateWithDeltaTime:(NSTimeInterval)deltaTime;
- (id)addController:(MAGLController *)controller;
- (void)setupControllers;

@end
