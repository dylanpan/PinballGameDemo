//
//  Bumper.h
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/19
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"

// -----------------------------------------------------------------

@interface Bumper : BodyNode

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods
+ (id)bumperWithWorld:(CCPhysicsNode *)world position:(CGPoint)pos;

// -----------------------------------------------------------------

@end




