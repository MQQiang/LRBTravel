//
//  LRBPersonInfoViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBPersonInfoViewController.h"

@interface LRBPersonInfoViewController ()

@end

@implementation LRBPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
  
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0,_gradientView.frame.size.width, 240);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)UIColorFromRGB(0x191970).CGColor,
                       (id)[UIColor darkGrayColor].CGColor,
                       (id)UIColorFromRGB(0xFFD700).CGColor,
                       nil];
    [self.gradientView.layer insertSublayer:gradient atIndex:0];

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

- (IBAction)backtoForward:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
