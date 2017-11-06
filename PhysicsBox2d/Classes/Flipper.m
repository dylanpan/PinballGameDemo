//
//  Flipper.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/19
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Flipper.h"
#import "PinballTable.h"
#import "Helper.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@interface Flipper(privateMethods)
- (void)attachFlipperAt:(CGPoint)pos;
@end

// -----------------------------------------------------------------

@implementation Flipper

// -----------------------------------------------------------------
- (id)initWithWorld:(CCPhysicsNode *)world flipperType:(FlipperTypes)flipperType{
    self = [super init];
    if (self) {
        _type = flipperType;
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        if (_type == FlipperTypeLeft) {
            CGPoint flipperPos = CGPointMake(screenSize.width * 0.5f - 45.0f, 55.0f);
            NSInteger num = 6;
            CGPoint verts[] = {
                CGPointMake(-21.1f, -2.0f),
                CGPointMake(22.6f, -24.9f),
                CGPointMake(27.7f, -24.8f),
                CGPointMake(29.4f, -23.6f),
                CGPointMake(-10.2f, 13.5f),
                CGPointMake(-20.3f, -1.8f)
            };
            CCPhysicsBody *physicsBody = [CCPhysicsBody bodyWithPolygonFromPoints:verts count:num cornerRadius:0.0f];
            physicsBody.density = 1.0f;
            physicsBody.friction = 0.99f;
            physicsBody.elasticity = 0.1f;
            physicsBody.affectedByGravity = NO;
            [super createBodyInWorld:world body:physicsBody spriteFrameName:@"flipper-left.png" atPosition:flipperPos];
            _myBody = physicsBody;
            CGPoint revolutePointOffset = CGPointMake(0.5f, 0.0f);
            CGPoint revolutePoint = CGPointMake(flipperPos.x - revolutePointOffset.x, flipperPos.y - revolutePointOffset.y);
            [self attachFlipperWithWorld:world position:revolutePoint flipperType:_type];
        }else if (_type == FlipperTypeRight) {
            CGPoint flipperPos = CGPointMake(screenSize.width * 0.5f + 36.0f, 51.0f);
            NSInteger num = 6;
            CGPoint verts[] = {
                CGPointMake(11.2f, 13.7f),
                CGPointMake(-29.3f, -23.1f),
                CGPointMake(-27.6f, -25.2f),
                CGPointMake(-22.9f, -24.8f),
                CGPointMake(21.2f, -3.1f),
                CGPointMake(11.2f, 13.2f)
            };
            CCPhysicsBody *physicsBody = [CCPhysicsBody bodyWithPolygonFromPoints:verts count:num cornerRadius:0.0f];
            physicsBody.density = 1.0f;
            physicsBody.friction = 0.99f;
            physicsBody.elasticity = 0.1f;
            physicsBody.affectedByGravity = NO;
            [super createBodyInWorld:world body:physicsBody spriteFrameName:@"flipper-right.png" atPosition:flipperPos];
            _myBody = physicsBody;
            CGPoint revolutePointOffset = CGPointMake(0.5f, 0.0f);
            CGPoint revolutePoint = CGPointMake(flipperPos.x + revolutePointOffset.x, flipperPos.y + revolutePointOffset.y);
            [self attachFlipperWithWorld:world position:revolutePoint flipperType:_type];
        }
        self.userInteractionEnabled = YES;
    }
    return self;
}

+ (id)flipperWithWorld:(CCPhysicsNode *)world flipperType:(FlipperTypes)flipperType{
    return [[self alloc] initWithWorld:world flipperType:flipperType];
}

- (void)attachFlipperWithWorld:(CCPhysicsNode *)world position:(CGPoint)pos flipperType:(FlipperTypes)flipperType{
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"" fontName:@"ArialMT" fontSize:20];
    label.position = CGPointMake(self.spriteInNode.position.x, self.spriteInNode.position.y);
    CCPhysicsBody *physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:1.0f andCenter:CGPointZero];
    physicsBody.type = CCPhysicsBodyTypeStatic;
    label.physicsBody = physicsBody;
    [world addChild:label];
    CCPhysicsJoint *joint;
    if (_type == FlipperTypeLeft) {
        //弹球的挡板，在旋转角度放置不可见的大摩擦力的静态刚体，touchbegan给一个速度，touchend给一个相反的速度
        joint = [CCPhysicsJoint connectedPivotJointWithBodyA:self.bodyInNode.physicsBody bodyB:label.physicsBody anchorA:CGPointMake(-15.0f, 5.0f)];
    }else if (_type == FlipperTypeRight) {
        joint = [CCPhysicsJoint connectedPivotJointWithBodyA:self.bodyInNode.physicsBody bodyB:label.physicsBody anchorA:CGPointMake(15.0f, 5.0f)];
    }
    
    [world.physicsBody addJoint:joint];
}

- (BOOL)isTouchForMe:(CGPoint)location{
    if (_type == FlipperTypeLeft && location.x < [Helper screenCenter].x) {
        return YES;
    }else if (_type == FlipperTypeRight && location.x > [Helper screenCenter].x) {
        return YES;
    }
    return NO;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint location = [Helper locationFromTouch:touch];
    if ([self isTouchForMe:location]) {
        _myBody.force = CGPointMake(0.0f, 20.0f);
    }
}

// -----------------------------------------------------------------

@end


























