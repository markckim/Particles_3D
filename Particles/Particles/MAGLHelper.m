//
//  MAGLHelper.m
//  a5
//
//  Created by Mark Kim on 12/16/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "MAGLHelper.h"
#import <GLKit/GLKit.h>

@implementation MAGLHelper

+ (GLuint)createProgramWithVertexShaderName:(NSString *)vertexShaderName fragmentShaderName:(NSString *)fragmentShaderName
{
    GLuint vertexShader = [MAGLHelper compileShader:vertexShaderName type:GL_VERTEX_SHADER];
    GLuint fragmentShader = [MAGLHelper compileShader:fragmentShaderName type:GL_FRAGMENT_SHADER];
    
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    glLinkProgram(programHandle);
    
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"program link error: %@", messageString);
        exit(1);
    }
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    return programHandle;
}

+ (GLuint)createProgramWithVertexShader:(GLuint)vertexShader fragmentShader:(GLuint)fragmentShader
{
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    glLinkProgram(programHandle);
    
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"program link error: %@", messageString);
        exit(1);
    }
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    return programHandle;
}

+ (GLuint)compileShader:(NSString *)shaderName type:(GLenum)shaderType
{
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    NSError *error;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    const char *shaderStringUTF8 = [shaderString UTF8String];
    NSUInteger shaderStringLength = [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, (GLint *)&shaderStringLength);
    
    glCompileShader(shaderHandle);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"shader compile error: %@", messageString);
        exit(1);
    }
    return shaderHandle;
}

@end
