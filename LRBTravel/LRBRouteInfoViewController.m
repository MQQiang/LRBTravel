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
#import "LRBLeaderInfoViewController.h"

@interface LRBRouteInfoViewController ()<EScrollerViewDelegate>{
    
    UIBarButtonItem *_favouriteButton;
}

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
    
    self.title = @"路线详情";
    
//    _favouriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorite"]style:UIBarButtonItemStylePlain target:self action:@selector(addThisToMyFavourite:)];
//    
//    self.navigationItem.rightBarButtonItem = _favouriteButton;
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
#pragma mark - Button Method

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

- (IBAction)presentLeaderInfo:(id)sender {
    
    LRBLeaderinfoViewController * leaderInfoVC = [[LRBLeaderinfoViewController alloc] init];
    
    leaderInfoVC.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:leaderInfoVC animated:YES completion:^(){
       
        leaderInfoVC.view.superview.backgroundColor = [UIColor clearColor];
        
    }];
    
    
}

#pragma mark - selector
-(void)addThisToMyFavourite:(id)sender{
    
    _favouriteButton.image = [UIImage imageNamed:@"favorite"];
}
@end
