//
//  MAGLKBaseViewController.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLKBaseViewController.h"
#import "MAGLController.h"

//#define FPS_LOG
#define UPDATE_RATE 1.0 / 60.0

@interface MAGLKBaseViewController ()

@property (nonatomic, assign) NSTimeInterval accumulatedTime;
@property (nonatomic, strong) NSMutableArray *controllers;

@end

@implementation MAGLKBaseViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    for (MAGLController *controller in _controllers) {
        [controller setupProjections];
    }
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
#ifdef FPS_LOG
    CFTimeInterval previousTimestamp = CFAbsoluteTimeGetCurrent();
#endif
    [view bindDrawable];
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    for (MAGLController *controller in _controllers) {
        [controller renderWithView:view];
    }
#ifdef FPS_LOG
    CFTimeInterval frameDuration = CFAbsoluteTimeGetCurrent() - previousTimestamp;
    DDLogDebug(@"FPS: %f", 1.0 / frameDuration);
#endif
}

- (void)updateWithDeltaTime:(NSTimeInterval)deltaTime
{
    for (MAGLController *controller in _controllers) {
        [controller update:deltaTime];
    }
}

- (id)addController:(MAGLController *)controller
{
    [_controllers addObject:controller];
    return controller;
}

- (void)update
{
    if (!_isGamePaused) {
        _accumulatedTime += self.timeSinceLastUpdate;
        while (_accumulatedTime > UPDATE_RATE) {
            _accumulatedTime -= UPDATE_RATE;
            [self updateWithDeltaTime:UPDATE_RATE];
        }
    }
}

- (MAObject *)objectContainingTouchLocation:(CGPoint)touchLocation
{
    return nil;
}

- (void)setupControllers {}

- (void)_base_setupView
{
    if (_context) {
        GLKView *view = (GLKView *)self.view;
        view.context = _context;
        view.contentMode = UIViewContentModeScaleToFill;
        view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
        view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
        view.drawableStencilFormat = GLKViewDrawableStencilFormat8;
        view.drawableMultisample = GLKViewDrawableMultisampleNone;
    }
}

- (void)_base_setup
{
    self.preferredFramesPerSecond = 60;
    _isGamePaused = NO;
    _accumulatedTime = 0.0;
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!_context) {
        NSLog(@"failed to create ES context");
    } else {
        [EAGLContext setCurrentContext:_context];
        glClearColor(0.0, 0.0, 0.0, 0.0);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glEnable(GL_DEPTH_TEST);
        glEnable(GL_STENCIL_TEST);
        glEnable(GL_BLEND);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _controllers = [[NSMutableArray alloc] init];
    [self _base_setup];
    [self _base_setupView];
    [self setupControllers];
}

@end
