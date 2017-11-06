//
//  Ball.h
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/18
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"

// -----------------------------------------------------------------

@interface Ball : BodyNode

// -----------------------------------------------------------------
// properties
@property (nonatomic) BOOL moveToFinger;
@property (nonatomic) CGPoint fingerLocation;
@property (nonatomic, strong) CCLabelTTF *lifeLabel;

// -----------------------------------------------------------------
// methods
+ (id)ballWithWorld:(CCPhysicsNode *)world;
+ (NSInteger)shareLife;
// -----------------------------------------------------------------

@end




