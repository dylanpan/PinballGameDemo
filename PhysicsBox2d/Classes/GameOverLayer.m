//
//  GameOverLayer.m
//
//  Created by : 潘安宇
//  Project    : PhysicsBox2d
//  Date       : 2017/11/3
//
//  Copyright (c) 2017年 潘安宇.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameOverLayer.h"
#import "Helper.h"
#import "PinballTable.h"

// -----------------------------------------------------------------

@implementation GameOverLayer

// -----------------------------------------------------------------
+ (id)scene{
    CCScene *scene = [CCScene node];
    GameOverLayer *gameOverLayer = [GameOverLayer node];
    [scene addChild:gameOverLayer];
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
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Game Over" fontName:@"ArialMT" fontSize:40];
        title.position = CGPointMake([Helper screenSize].width * 0.5f, [Helper screenSize].height * 0.7f);
        title.color = [CCColor whiteColor];
        [self addChild:title z:0];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSInteger highScore = [defaults integerForKey:@"highScore"];
        CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"High Score:%ld",(long)highScore] fontName:@"ArailMT" fontSize:20];
        highScoreLabel.position = CGPointMake([Helper screenSize].width * 0.5f, [Helper screenSize].height * 0.5f);
        highScoreLabel.color = [CCColor whiteColor];
        [self addChild:highScoreLabel];
        
        CCLabelTTF *score = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score:%ld",(long)[PinballTable shareScore]] fontName:@"ArailMT" fontSize:20];
        score.position = CGPointMake([Helper screenSize].width * 0.5f, [Helper screenSize].height * 0.45f);
        score.color = [CCColor whiteColor];
        [self addChild:score];
        
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





