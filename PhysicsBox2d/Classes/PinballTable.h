//
//  PinballTable.h
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

@interface PinballTable : CCScene

// -----------------------------------------------------------------
// properties
@property (nonatomic, strong) CCPhysicsNode *world;
@property (nonatomic) CGSize screenSize;
@property (nonatomic) CCLabelTTF *scoreLabel;
@property (nonatomic) CCLabelTTF *restartLabel;

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
+ (id)scene;
+ (PinballTable *)shareTable;
+ (NSInteger)shareScore;
- (CCSprite *)getTable;
+ (void)storeHighScore;

// -----------------------------------------------------------------

@end




