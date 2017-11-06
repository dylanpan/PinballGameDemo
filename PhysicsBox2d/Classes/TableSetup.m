//
//  TableSetup.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/18
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "TableSetup.h"
#import "PinballTable.h"
#import "Helper.h"
#import "Flipper.h"
#import "Plunger.h"
#import "Ball.h"
#import "Bumper.h"

@interface TableSetup(PrivateMethods)
- (void)addBumperAt:(CGPoint)pos;
- (void)createTableTopBody;
- (void)createTableButtomLeftBody;
- (void)createTableButtomRightBody;
- (void)createLanes;
@end

// -----------------------------------------------------------------

@implementation TableSetup

// -----------------------------------------------------------------
- (id)initTableWithWorld:(CCPhysicsNode *)world{
    self = [super init];
    if (self) {
        _world = world;
        _screenSize = [[CCDirector sharedDirector] viewSize];
        
        //添加table顶部和底部的sprite
        CCSprite *table = [[PinballTable shareTable] getTable];
        CCSprite *tableTopSprite = [CCSprite spriteWithImageNamed:@"tabletop.png"];
        tableTopSprite.position = [Helper screenCenter];
        [table addChild:tableTopSprite];
        
        CCSprite *tableBottomSprite = [CCSprite spriteWithImageNamed:@"tablebottom.png"];
        tableBottomSprite.position = [Helper screenCenter];
        [table addChild:tableBottomSprite];
        
        //添加table顶部和底部的sprite对应的静态刚体
        [self createTableTopBody];
        [self createTableButtomLeftBody];
        [self createTableButtomRightBody];
        [self createLanes];
        
        //添加table中间的减震器
        [self addBumperAt:CGPointMake(150.0f, 380.0f)];
        [self addBumperAt:CGPointMake(100.0f, 430.0f)];
        [self addBumperAt:CGPointMake(230.0f, 430.0f)];
        [self addBumperAt:CGPointMake(40.0f, 380.0f)];
        [self addBumperAt:CGPointMake(280.0f, 330.0f)];
        [self addBumperAt:CGPointMake(70.0f, 330.0f)];
        [self addBumperAt:CGPointMake(240.0f, 300.0f)];
        [self addBumperAt:CGPointMake(170.0f, 330.0f)];
        [self addBumperAt:CGPointMake(160.0f, 450.0f)];
        [self addBumperAt:CGPointMake(15.0f, 210.0f)];
        
        //添加table下端左右挡板
        Flipper *flipperLeft = [Flipper flipperWithWorld:world flipperType:FlipperTypeLeft];
        [self addChild:flipperLeft z:-2];
        Flipper *flipperRight = [Flipper flipperWithWorld:world flipperType:FlipperTypeRight];
        [self addChild:flipperRight z:-2];
        
        //添加table右下端的活塞
        Plunger *plunger = [Plunger plungerWithWorld:world];
        [self addChild:plunger z:-4];
        
        //添加个球啊
        Ball *ball = [Ball ballWithWorld:world];
        [self addChild:ball z:-1 name:@"ball"];
        
        _world = nil;
    }
    return self;
}

+ (id)setupTableWithWorld:(CCPhysicsNode *)world{
    return [[self alloc] initTableWithWorld:world];
}

- (void)addBumperAt:(CGPoint)pos{
    Bumper *bumper = [Bumper bumperWithWorld:_world position:pos];
    [self addChild:bumper];
}

- (void)createStaticBodyWithVertices:(CGPoint[])vertices numVretices:(NSInteger)numVretices{
    CCPhysicsBody *staticPhysicsBody = [CCPhysicsBody bodyWithPolygonFromPoints:vertices count:numVretices cornerRadius:0.0f];
    staticPhysicsBody.type = CCPhysicsBodyTypeStatic;
    staticPhysicsBody.density = 1000.0f;
    staticPhysicsBody.friction = 0.2f;
    staticPhysicsBody.elasticity = 1.0f;
    
    CCNode *staticBody = [CCNode node];
    staticBody.position = [Helper screenCenter];
    staticBody.physicsBody = staticPhysicsBody;
    [_world addChild:staticBody];
}

- (void)createTableTopBody{
    {
        NSInteger num = 5;
        CGPoint verts[] = {
            CGPointMake(-158.3f, 282.7f),
            CGPointMake(-158.3f, 173.6f),
            CGPointMake(-131.5f, 227.3f),
            CGPointMake(-131.8f, 283.3f),
            CGPointMake(-157.6f, 283.2f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 6;
        CGPoint verts[] = {
            CGPointMake(-129.0f, 227.4f),
            CGPointMake(-128.4f, 283.7f),
            CGPointMake(-58.6f, 283.7f),
            CGPointMake(-57.2f, 264.8f),
            CGPointMake(-92.8f, 254.3f),
            CGPointMake(-129.1f, 228.2f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 6;
        CGPoint verts[] = {
            CGPointMake(-57.8f, 284.0f),
            CGPointMake(-56.8f, 264.5f),
            CGPointMake(40.3f, 267.4f),
            CGPointMake(68.8f, 261.0f),
            CGPointMake(69.6f, 283.2f),
            CGPointMake(-57.2f, 283.8f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 6;
        CGPoint verts[] = {
            CGPointMake(68.9f, 283.1f),
            CGPointMake(69.1f, 260.3f),
            CGPointMake(104.0f, 240.7f),
            CGPointMake(135.7f, 210.8f),
            CGPointMake(137.1f, 283.1f),
            CGPointMake(69.3f, 283.1f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 5;
        CGPoint verts[] = {
            CGPointMake(138.5f, 282.9f),
            CGPointMake(137.7f, 210.5f),
            CGPointMake(159.2f, 165.3f),
            CGPointMake(158.3f, 282.8f),
            CGPointMake(138.6f, 283.4f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
}

- (void)createTableButtomLeftBody{
    {
        NSInteger num = 5;
        CGPoint verts[] = {
            CGPointMake(-158.7f, -182.1f),
            CGPointMake(-157.4f, -282.8f),
            CGPointMake(-90.3f, -282.2f),
            CGPointMake(-91.2f, -267.1f),
            CGPointMake(-158.1f, -183.0f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 5;
        CGPoint verts[] = {
            CGPointMake(-89.0f, -267.2f),
            CGPointMake(-89.4f, -282.3f),
            CGPointMake(-41.2f, -281.5f),
            CGPointMake(-41.8f, -277.6f),
            CGPointMake(-88.0f, -268.2f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
}

- (void)createTableButtomRightBody{
    {
        NSInteger num = 4;
        CGPoint verts[] = {
            CGPointMake(27.8f, -282.2f),
            CGPointMake(113.1f, -231.3f),
            CGPointMake(113.8f, -281.5f),
            CGPointMake(31.0f, -281.8f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 7;
        CGPoint verts[] = {
            CGPointMake(115.9f, -280.5f),
            CGPointMake(133.3f, -280.5f),
            CGPointMake(133.6f, -203.5f),
            CGPointMake(127.3f, -195.3f),
            CGPointMake(119.2f, -195.7f),
            CGPointMake(115.6f, -202.6f),
            CGPointMake(116.6f, -279.7f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 5;
        CGPoint verts[] = {
            CGPointMake(134.2f, -248.4f),
            CGPointMake(134.0f, -282.1f),
            CGPointMake(144.9f, -281.6f),
            CGPointMake(137.1f, -249.3f),
            CGPointMake(135.1f, -248.9f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 5;
        CGPoint verts[] = {
            CGPointMake(150.9f, -282.0f),
            CGPointMake(158.0f, -282.7f),
            CGPointMake(158.7f, -251.0f),
            CGPointMake(157.1f, -250.9f),
            CGPointMake(151.0f, -282.8f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
}

- (void)createLanes{
    {
        NSInteger num = 8;
        CGPoint verts[] = {
            CGPointMake(-123.6f, -167.4f),
            CGPointMake(-60.9f, -212.1f),
            CGPointMake(-60.0f, -222.9f),
            CGPointMake(-65.6f, -228.0f),
            CGPointMake(-73.6f, -228.8f),
            CGPointMake(-125.9f, -184.1f),
            CGPointMake(-126.5f, -171.8f),
            CGPointMake(-123.2f, -167.9f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    {
        NSInteger num = 8;
        CGPoint verts[] = {
            CGPointMake(56.9f, -207.5f),
            CGPointMake(51.8f, -219.4f),
            CGPointMake(58.0f, -235.8f),
            CGPointMake(67.2f, -236.3f),
            CGPointMake(94.7f, -220.8f),
            CGPointMake(101.7f, -192.0f),
            CGPointMake(97.5f, -186.8f),
            CGPointMake(57.6f, -208.2f)
        };
        [self createStaticBodyWithVertices:verts numVretices:num];
    }
    
}


// -----------------------------------------------------------------

@end

































