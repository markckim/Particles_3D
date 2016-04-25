//
//  gl_functions.m
//  a5
//
//  Created by Mark Kim on 12/27/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import "gl_functions.h"

GLuint setupEmptyTexture(size_t width, size_t height)
{
    GLubyte *data = (GLubyte *)calloc(width * height * 4, sizeof(GLubyte));
    
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    free(data);
    
    return texName;
}

GLuint setupTextureWithImage(UIImage *image)
{
    CGImageRef spriteImage = image.CGImage;
    if (!spriteImage) {
        NSLog(@"failed to load image");
        exit(1);
    }
    
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    GLubyte * spriteData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte)); // if 4 components per pixel (RGBA)
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height,
                                                       bitsPerComponent, bytesPerRow, CGImageGetColorSpace(spriteImage),
                                                       kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    // need to translate and scale y; otherwise, the image will be upside down
    CGContextTranslateCTM(spriteContext, 0.0, image.size.height);
    CGContextScaleCTM(spriteContext, 1.0, -1.0);
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);
    
    GLuint texName;
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    free(spriteData);
    
    return texName;
}

GLuint setupTexture(NSString *fileName)
{
    UIImage *sprite = [UIImage imageNamed:fileName];
    if (!sprite) {
        NSLog(@"failed to load image %@", fileName);
        exit(1);
    }
    return setupTextureWithImage(sprite);
}

GLKVector2 glPositionFromScreenPoint(CGPoint screenPoint, CGSize screenSize, CGFloat aspectRatio)
{
    CGPoint glPoint = CGPointMake(screenPoint.x / screenSize.width , screenPoint.y / screenSize.height);
    GLfloat x = (glPoint.x * 2.0) - 1.0;
    GLfloat y = ((glPoint.y * 2.0) - 1.0) * (-1.0 / aspectRatio);
    return GLKVector2Make(x, y);
}
