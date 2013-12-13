//
//  Creature.h
//  GameOfLife
//
//  Created by Benjamin Encz on 4/16/13.
//
//

#import <Foundation/Foundation.h>

@interface Creature : NSObject

// stores the current state of the creature
@property (nonatomic, assign) BOOL isAlive;

// stores the amount of living neighbours
@property (nonatomic, assign) NSInteger livingNeighbours;

@end
