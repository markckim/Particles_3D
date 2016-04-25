//
//  MAGLShader.m
//  ariel4
//
//  Created by Mark Kim on 3/29/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "MAGLShader.h"

@interface MAGLShader ()

@property (nonatomic, assign) GLuint program;

@end

@implementation MAGLShader

- (void)loadWithProgram:(GLuint)program
{
    _program = program;
}

@end
