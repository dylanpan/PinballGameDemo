//
//  BodyNode.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/18
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "BodyNode.h"
#import "PinballTable.h"

// -----------------------------------------------------------------

@implementation BodyNode

// -----------------------------------------------------------------

- (void)createBodyInWorld:(CCPhysicsNode *)world body:(CCPhysicsBody *)physicsBody spriteFrameName:(NSString *)spriteFrameName atPosition:(CGPoint)startPosition{
    NSAssert(world != nil, @"world is nil");
    NSAssert(physicsBody != nil, @"physicsBody is nil");
    NSAssert(spriteFrameName != nil, @"spriteFrameName != nil");
    
    [self removeSprite];
    [self removeBody];
    
    CCSprite *table = [[PinballTable shareTable] getTable];
    _spriteInNode = [CCSprite spriteWithImageNamed:spriteFrameName];
    [table addChild:_spriteInNode z:-4];
    
    _bodyInNode = [CCNode node];
    _bodyInNode.physicsBody = physicsBody;
    _bodyInNode.position = startPosition;
    [world addChild:_bodyInNode];
    
    _bodyInNode.userObject = self;
}

- (void)removeSprite{
    CCSprite *table = [[PinballTable shareTable] getTable];
    NSArray *batchChildren = [table children];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:batchChildren];
    if (_spriteInNode != nil && [temp containsObject:_spriteInNode]) {
        [temp removeObject:_spriteInNode];
        _spriteInNode = nil;
    }
}

- (void)removeBody{
    if (_bodyInNode != nil) {
        NSArray * worldChildren = [[PinballTable shareTable].world children];
        for (CCNode *body in worldChildren) {
            if (body == _bodyInNode) {
                _bodyInNode = nil;
            }
        }
    }
}

// -----------------------------------------------------------------

@end





