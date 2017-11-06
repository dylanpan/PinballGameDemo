//
//  Helper.m
//  PhysicsBox2d
//
//  Created by 潘安宇 on 2017/10/18.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (CGPoint)locationFromTouch:(CCTouch *)touch{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
    
}

+ (CGPoint)screenCenter{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    return CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
}

+ (CGSize)screenSize{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    return screenSize;
}

+ (CGRect)screenRect{
    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    return CGRectMake(0.0f, 0.0f, screenSize.width, screenSize.height);
}

+ (CGRect)getRect:(CCNode *)sender{
    return CGRectMake(sender.position.x - sender.contentSize.width * 0.5f, sender.position.y - sender.contentSize.height * 0.5f, sender.contentSize.width, sender.contentSize.height);
}

@end
