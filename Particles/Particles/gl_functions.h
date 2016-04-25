//
//  gl_functions.h
//  a5
//
//  Created by Mark Kim on 12/27/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

GLuint setupEmptyTexture(size_t width, size_t height);

GLuint setupTexture(NSString *fileName);

GLuint setupTextureWithImage(UIImage *image);

GLKVector2 glPositionFromScreenPoint(CGPoint screenPoint, CGSize screenSize, CGFloat aspectRatio);
