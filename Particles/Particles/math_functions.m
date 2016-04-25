//
//  math_functions.m
//  ariel4
//
//  Created by Mark Kim on 5/10/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import "UIScreen+ScreenSize.h"
#import "math_functions.h"

CGFloat randomBetween(CGFloat min, CGFloat max)
{
    CGFloat range = max - min;
    return (((CGFloat) (arc4random() % ((NSUInteger)RAND_MAX + 1)) / RAND_MAX) * range) + min;
}

double originScreenZ(CGSize screenSize, double degreesVerticalFieldOfView)
{
    CGFloat tanFOV_V_over_2 = tanf(GLKMathDegreesToRadians(0.5 * degreesVerticalFieldOfView));
    CGFloat distanceToZ = (0.5 * screenSize.height) / tanFOV_V_over_2;
    return -1.0 * distanceToZ;
}

GLKVector2 glPositionForScreenLocation(CGPoint screenLocation)
{
    CGSize screenSize = [UIScreen screenSize];
    float glX = screenLocation.x - 0.5 * screenSize.width;
    float glY = -1.0 * (screenLocation.y - 0.5 * screenSize.height);
    return GLKVector2Make(glX, glY);
}

GLKVector3 directionVector3(CGPoint screenLocation, float originScreenZ)
{
    GLKVector2 glPosition = glPositionForScreenLocation(screenLocation);
    float glX = glPosition.x;
    float glY = glPosition.y;
    float glZ = originScreenZ;
    return GLKVector3Make(glX, glY, glZ);
}
