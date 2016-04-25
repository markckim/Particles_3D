//
//  MAGLObject.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLObject.h"

@implementation MAGLObject

- (void)dealloc
{
    glDeleteBuffers(1, &_buffer0);
    glDeleteBuffers(1, &_buffer1);
}

- (GLuint *)bufferRef0
{
    return &_buffer0;
}

- (GLuint *)bufferRef1
{
    return &_buffer1;
}

@end
