//
//  LRBPhotoBrowserViewController.m
//  LRBTravel
//
//  Created by Macintosh on 15-2-17.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBPhotoBrowserViewController.h"

@interface LRBPhotoBrowserViewController ()

@end

@implementation LRBPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.navigationController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
   // [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    UINavigationBar* navigationBar=self.navigationController.navigationBar;
    navigationBar.tintColor=[UIColor blackColor];
    [navigationBar setBackgroundColor:[UIColor blackColor]];

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
