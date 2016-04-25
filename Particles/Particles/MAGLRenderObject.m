//
//  MAGLRenderObject.m
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLRenderObject.h"
#import "MAGLShader.h"

@implementation MAGLRenderObject

- (void)setupWithProgram:(GLuint)program userInfo:(NSDictionary *)userInfo
{
    [_shader loadWithProgram:program];
}

- (void)setProgram:(GLuint)program userInfo:(NSDictionary *)userInfo
{
    [_shader loadWithProgram:program];
}

- (void)render {}

@end
