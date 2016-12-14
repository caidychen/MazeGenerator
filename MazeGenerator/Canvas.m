//
//  Canvas.m
//  MazeGenerator
//
//  Created by CHEN KAIDI on 7/12/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "Canvas.h"
#import "Cell.h"
#import "MJGStack.h"

@interface Canvas (){
    
}
@property (nonatomic, assign) NSInteger cols, rows;
@property (nonatomic, strong) NSMutableArray <Cell*>*grid;
@property (nonatomic, strong) Cell *currentCell;
@property (nonatomic, strong) MJGStack *stack;
@property (nonatomic, assign) NSInteger visitCount;
@end

static CGFloat w = 20.0f;
@implementation Canvas

+(Canvas *)create:(CGRect)frame{
    Canvas *canvas = [[Canvas alloc] initWithFrame:frame];
    return canvas;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    }
    return self;
}

-(void)setup{
    self.cols = floorf(self.frame.size.width/w);
    self.rows = floorf(self.frame.size.height/w);
    
    for (int j = 0; j < self.rows; j++) {
        for (int i = 0; i < self.cols; i++) {
            Cell *cell = [Cell create:CGRectMake(i*w, j*w, w, w) i:i j:j cols:self.cols rows:self.rows];
            [self.grid addObject:cell];
            [self addSubview:cell];
        }
    }
    self.currentCell = [self.grid firstObject];
    self.currentCell.hightlighted = YES;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(draw) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)draw{
    
    self.currentCell.visited = YES;
    // STEP 1
    Cell *next = [self.currentCell checkNeighbors:self.grid];
    if (next) {
        next.visited = YES;
        self.visitCount ++;
        // STEP 2
        [self.stack pushObject:self.currentCell];
        
        // STEP 3
        [self removeWallsBetweenCellA:self.currentCell cellB:next];
        self.currentCell.hightlighted = NO;
        next.hightlighted = YES;
        if (self.visitCount == self.cols * self.rows) {
            next.destination = YES;
        }
        [self.currentCell setNeedsDisplay];
        [next setNeedsDisplay];
        
        // STEP 4
        self.currentCell = next;
        
    }else if (self.stack.count > 0){
        
        self.currentCell.hightlighted = NO;
        [self.currentCell setNeedsDisplay];
        Cell *cell = [self.stack popObject];
        cell.hightlighted = YES;
        [cell setNeedsDisplay];
        self.currentCell = cell;
        
    }
    
}

-(void)removeWallsBetweenCellA:(Cell *)cellA cellB:(Cell *)cellB{
    NSInteger x = cellA.i - cellB.i;
    if (x == 1) {
        cellA.walls[3] = @0;
        cellB.walls[1] = @0;
    }else if (x == -1){
        cellA.walls[1] = @0;
        cellB.walls[3] = @0;
    }
    NSInteger y = cellA.j - cellB.j;
    if (y == 1) {
        cellA.walls[0] = @0;
        cellB.walls[2] = @0;
    }else if (y == -1){
        cellA.walls[2] = @0;
        cellB.walls[0] = @0;
    }

}


-(NSMutableArray *)grid{
    if (!_grid) {
        _grid = [[NSMutableArray alloc] init];
    }
    return _grid;
}

-(MJGStack *)stack{
    if (!_stack) {
        _stack = [[MJGStack alloc] initWithArray:[[NSArray alloc] init]];
    }
    return _stack;
}

@end
