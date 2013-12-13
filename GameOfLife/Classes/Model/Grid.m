//
//  Grid.m
//  GameOfLife
//
//  Created by Benjamin Encz on 4/21/13.
//
//

#import "Grid.h"

@interface Grid ()

@property (nonatomic, strong) NSMutableArray *gridArray;

@end

@implementation Grid 

@synthesize gridArray = _gridArray;

- (void)dealloc {
    self.gridArray = nil;
}

- (id)initWithColumns:(NSInteger)columns Rows:(NSInteger)rows {
    self = [super init];
    
    if (self) {
        _gridSize = (GridSize) {columns, rows};
        self.gridArray = [[NSMutableArray alloc] init];
        
        // initialize Creatures 
        for (int i = 0; i < _gridSize.columms; i++) {
            self.gridArray[i] = [[NSMutableArray alloc] init];
            
            for (int j = 0; j < _gridSize.rows; j++) {
                self.gridArray[i][j] = [[Creature alloc] init];
            }
        }
    }
    
    return self;
}


- (void)evolveStep{
    for (int i = 0; i < _gridSize.columms; i++) {
        for (int j = 0; j < _gridSize.rows; j++) {
            Creature *currentCreature = self.gridArray[i][j];
            // reset neighbour counter
            currentCreature.livingNeighbours = 0;
            
            for (int x = (i-1); x <= (i+1); x++) {
                for (int y = (j-1); y <= (j+1); y++) {
                    
                    BOOL indexesValid = TRUE;
                    indexesValid &= x > 0;
                    indexesValid &= y > 0;
                    if (indexesValid) {
                        indexesValid &= x < (int) [self.gridArray count];
                        if (indexesValid) {
                            indexesValid &= y < (int) [(NSMutableArray*) self.gridArray[x] count];
                        }
                    }
                    
                    if (!((x == i) && (y == j)) && indexesValid) {
                        Creature *neighbour = self.gridArray[x][y];
                        currentCreature.livingNeighbours += neighbour.isAlive;
                    }
                }
            }
        }
    }
    
    for (int i = 0; i < _gridSize.columms; i++) {
        for (int j = 0; j < _gridSize.rows; j++) {
            Creature *currentCreature = self.gridArray[i][j];
            if (currentCreature.livingNeighbours == 3) {
                currentCreature.isAlive = TRUE;
            } else if ( (currentCreature.livingNeighbours <= 1) || (currentCreature.livingNeighbours >= 4)) {
                currentCreature.isAlive = FALSE;
            }
        }
    }
}

- (Creature *)creatureAtColumn:(NSInteger)column row:(NSInteger)row {
    return self.gridArray[column][row];
}

@end
