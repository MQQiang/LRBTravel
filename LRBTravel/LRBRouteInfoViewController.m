//
//  LRBRouteInfoViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBRouteInfoViewController.h"
#import "EScrollerView.h"
#import "LRBFillFromViewController.h"


@interface LRBRouteInfoViewController ()<EScrollerViewDelegate>

@end

@implementation LRBRouteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 66, self.view.frame.size.width, 150)
                                                          ImageArray:[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"11",@"22",@"33", nil]];
    
    scroller.delegate=self;
    
    [self.view addSubview:scroller];
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


-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
    
}
- (IBAction)presentPathInfo:(id)sender {
    
}

- (IBAction)presentArrangeMemt:(id)sender {
    
}

- (IBAction)presentEquipmentRequire:(id)sender {
    
}

- (IBAction)presentCostInfo:(id)sender {
    
}

- (IBAction)presentNotice:(id)sender {
    
}
- (IBAction)connectPhoneNumber:(id)sender {
}

- (IBAction)enrollForJourney:(id)sender {
    
    LRBFillFromViewController  *fillFormVC = [LRBFillFromViewController new];
    
    [self.navigationController pushViewController:fillFormVC animated:YES];
    
}
@end
