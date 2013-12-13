//
//  Grid.h
//  GameOfLife
//
//  Created by Benjamin Encz on 4/21/13.
//
//

#import <Foundation/Foundation.h>
#import "Creature.h"

typedef struct {
    NSInteger columms;
    NSInteger rows;
} GridSize;

@interface Grid : NSObject

@property (nonatomic, readonly, assign) GridSize gridSize;

- (id)initWithColumns:(NSInteger)columns Rows:(NSInteger)rows;

- (Creature *)creatureAtColumn:(NSInteger)column row:(NSInteger)row;

/**
 Determines which creatures come to life and which will die in the next step.
 */
- (void)evolveStep;

@end
