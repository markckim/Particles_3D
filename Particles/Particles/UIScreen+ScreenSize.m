//
//  UIScreen+ScreenSize.m
//  ariel2
//
//  Created by Mark Kim on 10/21/14.
//  Copyright (c) 2014 Mark Kim. All rights reserved.
//

#import "UIScreen+ScreenSize.h"

@implementation UIScreen (ScreenSize)

+ (CGSize)screenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    } else {
        return screenSize;
    }
}

+ (CGFloat)scale
{
    return [[UIScreen mainScreen] scale];
}

+ (CGSize)nativeScreenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)nativeScale
{
    return [[UIScreen mainScreen] nativeScale];
}

+ (CGSize)nativePixelSize
{
    CGFloat nativeScale = [UIScreen nativeScale];
    CGSize nativeScreenSize = [UIScreen nativeScreenSize];
    return CGSizeMake(nativeScale * nativeScreenSize.width, nativeScale * nativeScreenSize.height);
}

+ (BOOL)isPortrait
{
    CGSize screenSize = [UIScreen screenSize];
    return (screenSize.height > screenSize.width) ? YES : NO;
}

+ (CGFloat)aspectRatio
{
    CGSize screenSize = [UIScreen screenSize];
    return screenSize.width / screenSize.height;
}

@end
