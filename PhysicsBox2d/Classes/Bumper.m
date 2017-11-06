//
//  Bumper.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/19
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Bumper.h"
#import "PinballTable.h"

// -----------------------------------------------------------------

@implementation Bumper

// -----------------------------------------------------------------
- (id)initWithWorld:(CCPhysicsNode *)world position:(CGPoint)pos{
    self = [super init];
    if (self) {
        CCSprite *bumperSprite = [CCSprite spriteWithImageNamed:@"bumper.png"];
        CCPhysicsBody *physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:bumperSprite.contentSize.width * 0.5f andCenter:CGPointMake(0.0f,0.0f)];
        physicsBody.type = CCPhysicsBodyTypeStatic;
        physicsBody.density = 1.0f;
        physicsBody.elasticity = 2.0f;
        physicsBody.collisionType = [NSString stringWithFormat:@"bumper"];
        
        [super createBodyInWorld:world body:physicsBody spriteFrameName:@"bumper.png" atPosition:pos];
        self.spriteInNode.color = [CCColor greenColor];
    }
    return self;
}

+ (id)bumperWithWorld:(CCPhysicsNode *)world position:(CGPoint)pos{
    return [[self alloc] initWithWorld:world position:pos];
}
// -----------------------------------------------------------------

@end





