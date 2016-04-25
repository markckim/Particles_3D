//
//  MAGLController.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAObject.h"
#import <GLKit/GLKit.h>

@interface MAGLController : MAObject

- (void)setupProjections;
- (void)setup;
- (void)renderWithView:(GLKView *)view;

@end
