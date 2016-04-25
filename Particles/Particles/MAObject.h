//
//  MAObject.h
//  a5
//
//  Created by Mark Kim on 12/15/15.
//  Copyright © 2015 Mark Kim. All rights reserved.
//

#import <GLKit/GLKit.h>

@protocol MATouchProtocol <NSObject>
- (void)didBeginTouchingWithStartLocation:(CGPoint)startLocation;
- (void)continueTouchingwithCurrentPosition:(CGPoint)currentPosition previousPosition:(CGPoint)previousPosition;
- (void)didStopTouchingWithFinalPosition:(CGPoint)finalPosition velocity:(CGVector)velocity;
@end

@interface MAObject : NSObject <MATouchProtocol>

- (void)update:(NSTimeInterval)deltaTime;

@end
