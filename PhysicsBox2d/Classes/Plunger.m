//
//  Plunger.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/19
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Plunger.h"
#import "PinballTable.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@interface Plunger(PrivateMethods)
- (void)attachPlunger;
@end

// -----------------------------------------------------------------

@implementation Plunger

// -----------------------------------------------------------------
- (id)initWithWorld:(CCPhysicsNode *)world{
    self = [super init];
    if (self) {
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        CGPoint plungerPos = CGPointMake(screenSize.width - 13.0f, 32.0f);
        
        NSInteger num = 9;
        CGPoint verts[] = {
            CGPointMake(-11.9f, 18.0f),
            CGPointMake(-12.0f, 12.2f),
            CGPointMake(-4.3f, 11.8f),
            CGPointMake(-4.0f, -17.5f),
            CGPointMake(3.4f, -17.8f),
            CGPointMake(3.5f, 12.0f),
            CGPointMake(12.2f, 11.8f),
            CGPointMake(12.1f, 18.6f),
            CGPointMake(-11.9f, 18.2f)
        };
        
        CCPhysicsBody *physicsBody = [CCPhysicsBody bodyWithPolygonFromPoints:verts count:num cornerRadius:0.0f];
        physicsBody.density = 1.0f;
        physicsBody.friction = 0.99f;
        physicsBody.elasticity = 0.01f;
        [super createBodyInWorld:world body:physicsBody spriteFrameName:@"plunger.png" atPosition:plungerPos];
        self.spriteInNode.position = plungerPos;
        [self attachPlungerWithWorld:world];
    }
    return self;
}

+ (id)plungerWithWorld:(CCPhysicsNode *)world{
    return [[self alloc] initWithWorld:world];
}

- (void)attachPlungerWithWorld:(CCPhysicsNode *)world{
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"" fontName:@"ArialMT" fontSize:20];
    label.position = CGPointMake(self.spriteInNode.position.x, 0.0f);
    CCPhysicsBody *physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:1.0f andCenter:CGPointZero];
    physicsBody.type = CCPhysicsBodyTypeStatic;
    label.physicsBody = physicsBody;
    [world addChild:label];
    //弹球开始端的弹簧，释放一定方向的速度
    CCPhysicsJoint *joint = [CCPhysicsJoint connectedSpringJointWithBodyA:self.bodyInNode.physicsBody bodyB:label.physicsBody anchorA:CGPointMake(0.0f, 0.0f) anchorB:CGPointMake(0.0f, 0.0f) restLength:5.0f stiffness:90.0f damping:5.5f];
    
    [world.physicsBody addJoint:joint];
}

- (void)update:(CCTime)delta{
    if (_doPlunger == YES) {
        _doPlunger = NO;
        self.physicsBody.force = CGPointMake(0.0f, 30.0f);
    }
}

// -----------------------------------------------------------------

@end




























