//
//  LRBTestViewController.m
//  LRBTravel
//
//  Created by mq on 14/11/4.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBTestViewController.h"
#import "LRBFillFromViewController.h"
@interface LRBTestViewController ()

@end

@implementation LRBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f %f",self.view.frame.size.width,self.view.frame.size.height);
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)testFillFrom:(id)sender {
    
    LRBFillFromViewController  * controller = [[LRBFillFromViewController alloc ] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
