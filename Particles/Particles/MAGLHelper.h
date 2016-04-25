//
//  MAGLHelper.h
//  a5
//
//  Created by Mark Kim on 12/16/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAObject.h"

@interface MAGLHelper : MAObject

+ (GLuint)createProgramWithVertexShaderName:(NSString *)vertexShaderName fragmentShaderName:(NSString *)fragmentShaderName;

+ (GLuint)createProgramWithVertexShader:(GLuint)vertexShader fragmentShader:(GLuint)fragmentShader;

+ (GLuint)compileShader:(NSString *)shaderName type:(GLenum)shaderType;

@end
