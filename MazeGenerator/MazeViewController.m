//
//  MazeViewController.m
//  MazeGenerator
//
//  Created by CHEN KAIDI on 7/12/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "MazeViewController.h"
#import "Canvas.h"

@interface MazeViewController ()

@end


@implementation MazeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Canvas *canvas = [Canvas create:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [canvas setup];
    [self.view addSubview:canvas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
