//
//  Plunger.h
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

@interface Plunger : BodyNode

// -----------------------------------------------------------------
// properties
@property (nonatomic, strong) CCPhysicsJoint *joint;
@property (nonatomic) BOOL doPlunger;
@property (nonatomic) CCTime *plungerTime;

// -----------------------------------------------------------------
// methods
+ (id)plungerWithWorld:(CCPhysicsNode *)world;

// -----------------------------------------------------------------

@end




