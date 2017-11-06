//
//  Ball.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/18
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Ball.h"
#import "PinballTable.h"
#import "Helper.h"
#import "GameOverLayer.h"

@interface Ball(PrivateMethods)
- (void)createBallInWorld:(CCPhysicsNode *)world;
@end
// -----------------------------------------------------------------

@implementation Ball

// -----------------------------------------------------------------
static NSInteger life;

+ (NSInteger)shareLife{
    return life;
}

- (id)initWithWorld:(CCPhysicsNode *)world{
    self = [super init];
    
    if (self) {
        life = 1;
        [self createBallInWorld:world];
        
        _lifeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Life:%ld",(long)life] fontName:@"ArailMT" fontSize:20];
        _lifeLabel.position = CGPointMake([Helper screenSize].width - _lifeLabel.contentSize.width * 0.5f, [Helper screenSize].height - _lifeLabel.contentSize.height * 0.5f);
        [[PinballTable shareTable] addChild:_lifeLabel];
    }
    return self;
}

+ (id)ballWithWorld:(CCPhysicsNode *)world{
    return [[self alloc] initWithWorld:world];
}

- (void)createBallInWorld:(CCPhysicsNode *)world{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    CGFloat randomOffset = CCRANDOM_0_1() * 10.0f - 5.0f;
    CGPoint startPos = CGPointMake(screenSize.width - 13.0f + randomOffset, 80);
    CCSprite *ballSprite = [CCSprite spriteWithImageNamed:@"ball.png"];
    
    //创建一个刚体和设置他的属性
    CCPhysicsBody *physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:ballSprite.contentSize.width * 0.5f andCenter:CGPointMake(0.0f,0.0f)];
    physicsBody.density = 0.8f;
    physicsBody.elasticity = 0.7f;
    physicsBody.collisionType = [NSString stringWithFormat:@"ball"];
    
    [super createBodyInWorld:world body:physicsBody spriteFrameName:@"ball.png" atPosition:startPos];
    
    self.spriteInNode.color = [CCColor blueColor];
}

- (void)applyForceTowardsFinger{
    CGPoint bodyPos = CGPointMake(self.bodyInNode.position.x, self.bodyInNode.position.y) ;
    CGPoint fingerPos = _fingerLocation;
    
    CGPoint bodyToFinger = CGPointMake(fingerPos.x - bodyPos.x, fingerPos.y - bodyPos.y);
    CGPoint force = CGPointMake(bodyToFinger.x * 10.0f, bodyToFinger.y * 10.0f);
    [self.bodyInNode.physicsBody applyForce:force];
}

- (void)update:(CCTime)delta{
    if (_moveToFinger == YES) {
        [self applyForceTowardsFinger];
    }
    
    if (self.spriteInNode.position.y < -(self.spriteInNode.contentSize.height * 10)) {
        CCNode *node = self.bodyInNode.parent;
        NSAssert([node isKindOfClass:[CCPhysicsNode class]], @"not a world");
        CCPhysicsNode *world = (CCPhysicsNode *)node;
        //ball掉落到屏幕一下后创建一个新的ball，删除掉旧的ball
        [self createBallInWorld:world];
        if (life > 0) {
            life--;
            _lifeLabel.string = [NSString stringWithFormat:@"Life:%ld",(long)life];
        }else if (life <= 0){
            life = 3;
            //判断分数，保存最高分
            [PinballTable storeHighScore];
            //跳转game over layer
            [[CCDirector sharedDirector] replaceScene:[GameOverLayer scene]];
        }
    }
}

// -----------------------------------------------------------------

@end






























