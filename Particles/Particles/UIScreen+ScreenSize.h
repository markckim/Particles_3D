//
//  UIScreen+ScreenSize.h
//  ariel2
//
//  Created by Mark Kim on 10/21/14.
//  Copyright (c) 2014 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ScreenSize)

+ (CGSize)screenSize;

+ (CGFloat)scale;

+ (CGSize)nativeScreenSize;

+ (CGFloat)nativeScale;

+ (CGSize)nativePixelSize;

+ (BOOL)isPortrait;

+ (CGFloat)aspectRatio;

@end
