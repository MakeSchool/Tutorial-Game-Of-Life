//
//  HelloWorldScene.m
//  GameOfLife
//
//  Created by Benjamin Encz on 12/12/13.
//  Copyright MakeGamesWithUs 2013. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"

@implementation HelloWorldScene


+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}


- (id)init
{
    self = [super init];

    CCLabelTTF *helloWorld = [CCLabelTTF labelWithString:@"Hello cocos2d 3.0!" fontName:@"Arial" fontSize:48];
    helloWorld.positionType = CCPositionTypeNormalized;
    helloWorld.position = ccp(0.5f, 0.5f);
    
    [self addChild:helloWorld];

	return self;
}

@end