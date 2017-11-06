//
//  BodyNode.h
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

// -----------------------------------------------------------------

@interface BodyNode : CCNode

// -----------------------------------------------------------------
// properties
@property (nonatomic, strong, readonly) CCNode *bodyInNode;
@property (nonatomic, strong, readonly) CCSprite *spriteInNode;

// -----------------------------------------------------------------
// methods

- (void)createBodyInWorld:(CCPhysicsNode *)world body:(CCPhysicsBody *)body spriteFrameName:(NSString *)spriteFrameName atPosition:(CGPoint)startPosition;
- (void)removeSprite;
- (void)removeBody;
// -----------------------------------------------------------------

@end




