//
//  MAGLObject.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAObject.h"
#import <GLKit/GLKit.h>

@interface MAGLObject : MAObject

@property (nonatomic, assign) GLuint buffer0;
@property (nonatomic, assign) GLuint buffer1;

- (GLuint *)bufferRef0;
- (GLuint *)bufferRef1;

@end
