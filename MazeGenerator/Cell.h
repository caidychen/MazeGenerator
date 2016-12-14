//
//  Cell.h
//  MazeGenerator
//
//  Created by CHEN KAIDI on 7/12/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UIView

@property (nonatomic, assign) NSInteger i, j, cols, rows;
@property (nonatomic, assign) BOOL visited;
@property (nonatomic, assign) BOOL hightlighted;
@property (nonatomic, assign) BOOL destination;

// We render maze by specifying which wall(s) of individual cells should be open or close.
// The walls array is holding boolean values for all 4 walls, determining whether each of them should be open or close.
// [0, 0, 0, 0] as Top, Right, Bottom, Left. 0 for "wall open" and 1 for "wall close"
@property (nonatomic, strong) NSMutableArray *walls;


+(Cell*)create:(CGRect)frame i:(NSInteger)i j:(NSInteger)j cols:(NSInteger)cols rows:(NSInteger)rows;
-(Cell *)checkNeighbors:(NSArray *)grid;

@end
