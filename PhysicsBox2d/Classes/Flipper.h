//
//  Flipper.h
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

typedef NS_ENUM(NSInteger, FlipperTypes){
    FlipperTypeLeft,
    FlipperTypeRight,
};

// -----------------------------------------------------------------

@interface Flipper : BodyNode

// -----------------------------------------------------------------
// properties
@property (nonatomic) FlipperTypes type;
@property (nonatomic, strong) CCPhysicsJoint *joint;
@property (nonatomic) CGFloat totalTime;
@property (nonatomic, strong) CCPhysicsBody *myBody;

// -----------------------------------------------------------------
// methods
+ (id)flipperWithWorld:(CCPhysicsNode *)world flipperType:(FlipperTypes)flipperType;

// -----------------------------------------------------------------

@end




