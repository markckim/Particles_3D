//
//  MAGLRenderObject.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLObject.h"

@class MAGLShader;

@interface MAGLRenderObject : MAGLObject

@property (nonatomic, strong) MAGLShader *shader;

- (void)setupWithProgram:(GLuint)program userInfo:(NSDictionary *)userInfo;
- (void)setProgram:(GLuint)program userInfo:(NSDictionary *)userInfo;
- (void)render;

@end
