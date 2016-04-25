//
//  MAGLShader.h
//  ariel4
//
//  Created by Mark Kim on 3/29/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "MAObject.h"

@interface MAGLShader : MAObject

@property (nonatomic, readonly) GLuint program;

- (void)loadWithProgram:(GLuint)program;

@end
