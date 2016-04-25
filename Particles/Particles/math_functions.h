//
//  math_functions.h
//  ariel4
//
//  Created by Mark Kim on 5/10/15.
//  Copyright (c) 2015 Mark Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

CGFloat randomBetween(CGFloat min, CGFloat max);

double originScreenZ(CGSize screenSize, double degreesVerticalFieldOfView);

GLKVector2 glPositionForScreenLocation(CGPoint screenLocation);

GLKVector3 directionVector3(CGPoint screenLocation, float originScreenZ);
