//
//  GameStartLayer.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/11/3
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameStartLayer.h"
#import "Helper.h"
#import "PinballTable.h"

// -----------------------------------------------------------------

@implementation GameStartLayer

// -----------------------------------------------------------------
+ (id)scene{
    CCScene *scene = [CCScene node];
    GameStartLayer *gameStartLayer = [GameStartLayer node];
    [scene addChild:gameStartLayer];
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
        
        CCNodeColor *background = [[CCNodeColor alloc] initWithColor:[CCColor blueColor] width:[Helper screenSize].width height:[Helper screenSize].height];
        background.position = CGPointZero;
        [self addChild:background z:-1];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Pinball" fontName:@"ArialMT" fontSize:40];
        title.position = CGPointMake([Helper screenSize].width * 0.5f, [Helper screenSize].height * 0.7f);
        title.color = [CCColor whiteColor];
        [self addChild:title z:0];
        
        CCLabelTTF *start = [CCLabelTTF labelWithString:@"Tap to start" fontName:@"ArialMT" fontSize:20];
        start.position = CGPointMake([Helper screenSize].width * 0.5f, [Helper screenSize].height * 0.3f);
        start.color = [CCColor whiteColor];
        [self addChild:start z:0];
        
        CCActionBlink *blinkAction = [CCActionBlink actionWithDuration:1.0f blinks:2];
        CCActionRepeatForever *repeatAction = [CCActionRepeatForever actionWithAction:blinkAction];
        [start runAction:repeatAction];
    }
    return self;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLacotion = [Helper locationFromTouch:touch];
    CGRect screenRect = [Helper screenRect];
    if (CGRectContainsPoint(screenRect, touchLacotion)) {
        [[CCDirector sharedDirector] replaceScene:[PinballTable scene]];
    }
}


// -----------------------------------------------------------------

@end





