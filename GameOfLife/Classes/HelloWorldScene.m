//
//  HelloWorldScene.m
//  GameOfLife
//
//  Created by Benjamin Encz on 12/12/13.
//  Copyright MakeGamesWithUs 2013. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "Creature.h"
#import "Grid.h"

#define CANVAS_SIZE CGSizeMake(400, 320)
#define LABEL_ANIMATE   @"Animate"
#define LABEL_STOP      @"Stop"
#define LABEL_STEP      @"Step"


@interface HelloWorldScene()

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) float columnWidth;
@property (nonatomic, assign) float rowHeight;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) Grid *creatureGrid;
@property (nonatomic, strong) CCButton *calculationStepButton;
@property (nonatomic, strong) CCButton *animationButton;

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition;
- (void)nextFrame;

@end

@implementation HelloWorldScene

#pragma mark - initialization

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

-(id) init {
    
	if ((self = [super init])) {
        self.userInteractionEnabled = TRUE;

        self.creatureGrid = [[Grid alloc] initWithColumns:20 Rows:20];
        
        self.columnWidth = CANVAS_SIZE.width / self.creatureGrid.gridSize.columms;
        self.rowHeight = CANVAS_SIZE.height / self.creatureGrid.gridSize.rows;
        
        self.calculationStepButton = [CCButton buttonWithTitle:LABEL_STEP];
        [self.calculationStepButton setTarget:self selector:@selector(calculationStepButtonTouched:)];
    
        self.animationButton = [CCButton buttonWithTitle:LABEL_ANIMATE];
        [self.animationButton setTarget:self selector:@selector(animateButtonTouched:)];
        
        CCLayoutBox *layoutBox = [[CCLayoutBox alloc] init];
        layoutBox.anchorPoint = ccp(0.5, 0.5);
        [layoutBox addChild:self.calculationStepButton];
        [layoutBox addChild:self.animationButton];
        layoutBox.spacing = 10.f;
        layoutBox.direction = CCLayoutBoxDirectionVertical;
        [layoutBox layout];
        
        layoutBox.position = ccp(CANVAS_SIZE.width + (self.contentSize.width - CANVAS_SIZE.width)/2, self.contentSize.height/2);
        [self addChild:layoutBox];
    }
    
	return self;
}

#pragma mark - Button Callbacks

- (void)calculationStepButtonTouched:(id)sender
{
    [self.creatureGrid evolveStep];
}

- (void)animateButtonTouched:(id)sender
{
    self.isAnimating = !self.isAnimating;
    // don't allow manual steps, when animation is going on
    self.calculationStepButton.enabled = !self.isAnimating;
    if (self.isAnimating) {
        [self.animationButton setTitle:LABEL_STOP];
        [self schedule:@selector(nextFrame) interval:0.5f];
    } else {
        [self.animationButton setTitle:LABEL_ANIMATE];
        [self unschedule:@selector(nextFrame)];
    }
}

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    creature.isAlive = !creature.isAlive;
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition {
    Creature *creature = nil;
    
    float leftBorder = self.origin.x;
    float rightBorder = self.origin.x + CANVAS_SIZE.width;
    
    if ( (touchPosition.x >= leftBorder) && (touchPosition.x <= rightBorder)) {
        int column = (touchPosition.x - self.origin.x) / self.columnWidth;
        int row = (touchPosition.y - self.origin.y) / self.rowHeight;
        creature = [self.creatureGrid creatureAtColumn:column row:row];
    }
    
    return creature;
}

- (void)nextFrame {
    [self.creatureGrid evolveStep];
}

#pragma mark - custom drawing

-(void) draw {
    // note: CCDrawNode offers better performance than this, however it is harder to use for beginners
    ccDrawColor4B(100, 0, 255, 255); //purple, values range from 0 to 255
    ccColor4F purpleColor = (ccColor4F) {100,0,255,255};
    
    for (int i = 0; i < self.creatureGrid.gridSize.columms; i++) {
        
        for (int j = 0; j < self.creatureGrid.gridSize.rows; j++) {
            CGPoint origin = ccp(self.origin.x + (i*self.columnWidth), self.origin.y + (j*self.rowHeight));
            CGPoint destination = ccp(self.origin.x + ((i+1)*self.columnWidth), self.origin.y + ((j+1)*self.rowHeight));
            
            Creature *creature = [self.creatureGrid creatureAtColumn:i row:j];
            if ([creature isAlive]) {
                ccDrawSolidRect(origin, destination, purpleColor);
            } else {
                ccDrawRect(origin, destination);
            }
        }
    }
}

@end