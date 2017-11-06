//
//  PinballTable.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/10/18
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "PinballTable.h"
#import "TableSetup.h"
#import "BodyNode.h"
#import "Helper.h"
#import "Plunger.h"
#import "Flipper.h"
#import "Ball.h"

@interface PinballTable(PrivateMethods)<CCPhysicsCollisionDelegate>
- (void)initPhysicsWorld;
@end

// -----------------------------------------------------------------

@implementation PinballTable

// -----------------------------------------------------------------
static PinballTable *pinballTableInstance;
static NSInteger scoreInstance;

+ (PinballTable *)shareTable{
    NSAssert(pinballTableInstance != nil, @"table not yet initialized");
    return pinballTableInstance;
}

+ (NSInteger)shareScore{
    return scoreInstance;
}

+ (id)scene{
    CCScene *scene = [CCScene node];
    PinballTable *layer = [PinballTable node];
    [scene addChild:layer];
    return scene;
}

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    if (self) {
        self.userInteractionEnabled = YES;
        pinballTableInstance = self;
        scoreInstance = 0;
        _screenSize = [[CCDirector sharedDirector] viewSize];
        
        [self initPhysicsWorld];
        
        //预加载
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"table1.plist"];
        
        //设置背景
        CCNodeColor *colorLayer = [CCNodeColor nodeWithColor:[CCColor colorWithCcColor4b:ccc4(222, 222, 222, 255)]];
        [self addChild:colorLayer z:-3];
        
        //为了动态元素
        CCSprite *table = [CCSprite spriteWithImageNamed:@"table-empty1.png"];
        [self addChild:table z:-2 name:@"TableNode"];
        table.position = [Helper screenCenter];
        
        //设置静态元素
        TableSetup *tableSetup = [TableSetup setupTableWithWorld:_world];
        [self addChild:tableSetup z:-1];
        tableSetup.position = [Helper screenCenter];
        
        //添加分数面板
        _scoreLabel = [CCLabelTTF labelWithString:@"Score:0" fontName:@"ArailMT" fontSize:18];
        _scoreLabel.position = CGPointMake(_screenSize.width * 0.5f, _screenSize.height - _scoreLabel.contentSize.height * 0.5f);
        [self addChild:_scoreLabel z:1];
        
        //添加重新开始按钮
        _restartLabel = [CCLabelTTF labelWithString:@"Restart" fontName:@"ArailMT" fontSize:18];
        _restartLabel.position = CGPointMake(_restartLabel.contentSize.width * 0.5f, _screenSize.height - _restartLabel.contentSize.height * 0.5f);
        [self addChild:_restartLabel z:1];
        
//        self.scale = 0.5f;
//        self.anchorPoint = CGPointMake(-1.0f, -1.0f);
    }
    
    return self;
}

- (void)initPhysicsWorld{
    _world = [CCPhysicsNode node];
    _world.debugDraw = YES;
    _world.position = CGPointMake(0.0f, 0.0f);
    _world.contentSize = [[CCDirector sharedDirector] viewSize];
    _world.gravity = CGPointMake(0.0f, -50.0f);
    CGPoint points[] = {
        CGPointMake(0.0f, 0.0f),
        CGPointMake(0.0f, _screenSize.height),
        CGPointMake(_screenSize.width, _screenSize.height),
        CGPointMake(_screenSize.width, 0.0f),
    };
    _world.physicsBody = [CCPhysicsBody bodyWithPolylineFromPoints:points count:4 cornerRadius:0.0f looped:NO];
    _world.physicsBody.type = CCPhysicsBodyTypeStatic;
    _world.physicsBody.density = 1000.0f;
    _world.collisionDelegate = self;
    [self addChild:_world];
}

- (CCSprite *)getTable{
    return (CCSprite *)[self getChildByName:@"TableNode" recursively:YES];
}

+ (void)storeHighScore{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger highScore = [defaults integerForKey:@"highScore"];
    if (scoreInstance > highScore) {
        [defaults setInteger:scoreInstance forKey:@"highScore"];
        [defaults synchronize];
    }
}

- (void)update:(CCTime)delta{
    //获取world中child，从中拿到BodyNode类的属性信息
    NSArray *bodies = [_world children];
    for (CCNode *body in bodies) {
        BodyNode *eachBodyNode = (BodyNode *)body.userObject;
        if (eachBodyNode != nil && eachBodyNode.spriteInNode != nil) {
            eachBodyNode.spriteInNode.position = body.position;
            eachBodyNode.spriteInNode.rotation = body.rotation;
        }
    }
    _scoreLabel.string = [NSString stringWithFormat:@"Score:%ld",(long)scoreInstance];
}

#pragma collision delegate methods
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA bumper:(CCNode *)nodeB{
//    NSArray *bodies = [_world children];
//    for (CCNode *body in bodies) {
//        if ([body.userObject isKindOfClass:[Ball class]]) {
//            Ball *ball = (Ball *)body.userObject;
//
//        }
//    }
//    NSLog(@"collision happened");
    
    scoreInstance++;
    return YES;
}


#pragma touch delegate methods
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLocation = [Helper locationFromTouch:touch];
    NSArray *bodies = [_world children];
    for (CCNode *body in bodies) {
        if ([body.userObject isKindOfClass:[Plunger class]]) {
            Plunger *plunger = (Plunger *)body.userObject;
            CGRect plungerRect = CGRectMake(plunger.spriteInNode.position.x - plunger.spriteInNode.contentSize.width * 0.5f, plunger.spriteInNode.position.y - plunger.spriteInNode.contentSize.height * 0.5f, plunger.spriteInNode.contentSize.width, plunger.spriteInNode.contentSize.height);
            if (CGRectContainsPoint(plungerRect, touchLocation)) {
                plunger.bodyInNode.physicsBody.velocity = CGPointMake(0.0f, 500.0f);
            }
        }
        if ([body.userObject isKindOfClass:[Flipper class]]) {
            Flipper *flipper = (Flipper *)body.userObject;
            //CGRect flipperRect = CGRectMake(flipper.spriteInNode.position.x - flipper.spriteInNode.contentSize.width * 0.5f, flipper.spriteInNode.position.y - flipper.spriteInNode.contentSize.height * 0.5f, flipper.spriteInNode.contentSize.width, flipper.spriteInNode.contentSize.height);
            CGRect screenLeftRect = CGRectMake(0.0f, 0.0f, _screenSize.width * 0.5f, _screenSize.height * 0.2f);
            CGRect screenRightRect = CGRectMake(_screenSize.width * 0.5f, 0.0f, _screenSize.width * 0.5f, _screenSize.height * 0.2f);
            if (CGRectContainsPoint(screenLeftRect, touchLocation)) {
                flipper.bodyInNode.physicsBody.velocity = CGPointMake(0.0f, 200.0f);
            }else if (CGRectContainsPoint(screenRightRect, touchLocation)) {
                flipper.bodyInNode.physicsBody.velocity = CGPointMake(0.0f, 200.0f);
            }
        }
    }
    CGRect restartLabelRect = [Helper getRect:_restartLabel];
    if (CGRectContainsPoint(restartLabelRect, touchLocation)) {
        [[CCDirector sharedDirector] replaceScene:[PinballTable scene]];
    }
}


// -----------------------------------------------------------------

@end



























