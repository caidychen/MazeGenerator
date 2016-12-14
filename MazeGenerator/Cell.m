//
//  Cell.m
//  MazeGenerator
//
//  Created by CHEN KAIDI on 7/12/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "Cell.h"
#import "NSObject+SOObject.h"

@interface Cell ()

@end

@implementation Cell

+(Cell*)create:(CGRect)frame i:(NSInteger)i j:(NSInteger)j cols:(NSInteger)cols rows:(NSInteger)rows{
    Cell *cell = [[Cell alloc] initWithFrame:frame];
    cell.i = i;
    cell.j = j;
    cell.cols = cols;
    cell.rows = rows;
    cell.clearsContextBeforeDrawing = YES;
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

-(NSInteger)getTwoDimensionalIndexFromI:(NSInteger)i J:(NSInteger)j{
    if (i < 0 || j < 0 || i > self.cols - 1 || j > self.rows - 1) {
        return -1;
    }
    return i + j * self.cols;
}

-(void)setHightlighted:(BOOL)hightlighted{
    _hightlighted = hightlighted;
    [self setNeedsDisplay];
}

-(Cell *)checkNeighbors:(NSArray *)grid{
    
    NSMutableArray *neighbors = [[NSMutableArray alloc] init];
    Cell *top       = [grid safeObjectAtIndex:[self getTwoDimensionalIndexFromI:self.i J:self.j-1]];
    Cell *right     = [grid safeObjectAtIndex:[self getTwoDimensionalIndexFromI:self.i+1 J:self.j]];
    Cell *bottom    = [grid safeObjectAtIndex:[self getTwoDimensionalIndexFromI:self.i J:self.j+1]];
    Cell *left      = [grid safeObjectAtIndex:[self getTwoDimensionalIndexFromI:self.i-1 J:self.j]];
    
    if (top && !top.visited) {
        [neighbors addObject:top];
    }
    if (bottom && !bottom.visited) {
        [neighbors addObject:bottom];
    }
    if (left && !left.visited) {
        [neighbors addObject:left];
    }
    if (right && !right.visited) {
        [neighbors addObject:right];
    }
    
    if (neighbors.count > 0) {
        NSInteger random = arc4random()%neighbors.count;
        return [neighbors safeObjectAtIndex:random];
    }else{
        return nil;
    }
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 1.0f);
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    if (self.visited) {
        CGRect rectangle = CGRectMake(0, 0, w, h);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1.0, 0.0, 1.0, 0.5);
        CGContextFillRect(context, rectangle);
    }
    
    
    if ([[self.walls objectAtIndex:0] integerValue] == 1)
    {
        CGContextMoveToPoint(context, 0.0f, 0.0f); //start at this point
        CGContextAddLineToPoint(context, w, 0); //upper line
        
    }
    
    if ([[self.walls objectAtIndex:1] integerValue] == 1)
    {
        CGContextMoveToPoint(context, w, 0); //start at this point
        CGContextAddLineToPoint(context, w, h); //right line
    }
    
    if ([[self.walls objectAtIndex:2] integerValue] == 1)
    {
        CGContextMoveToPoint(context, w, h); //start at this point
        CGContextAddLineToPoint(context, 0, h); //bottom line
    }
    
    if ([[self.walls objectAtIndex:3] integerValue] == 1)
    {
        CGContextMoveToPoint(context, 0, h); //start at this point
        CGContextAddLineToPoint(context, 0, 0); //left line
    }

    if (self.hightlighted) {
        CGRect rectangle = CGRectMake(0, 0, w, h);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.4);
        CGContextFillRect(context, rectangle);
    }

    
    if (self.destination) {
        CGRect rectangle = CGRectMake(0, 0, w, h);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
        CGContextFillRect(context, rectangle);
    }
    // and now draw the Path!
    CGContextStrokePath(context);
}

-(NSMutableArray *)walls{
    if (!_walls) {
        _walls = [[NSMutableArray alloc] initWithArray:@[@1, @1, @1, @1]];// All walls are closed by default
    }
    return _walls;
}

@end
