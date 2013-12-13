//
//  HelloWorldScene.h
//  GameOfLife
//
//  Created by Benjamin Encz on 12/12/13.
//  Copyright MakeGamesWithUs 2013. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface HelloWorldScene : CCScene

// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end