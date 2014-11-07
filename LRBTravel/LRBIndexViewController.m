//
//  LRBIndexViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBIndexViewController.h"
#import "REFrostedViewController.h"
#import "EScrollerView.h"

@interface LRBIndexViewController ()<EScrollerViewDelegate>

@end

@implementation LRBIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];

    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 66, self.view.frame.size.width, 120)
                                                          ImageArray:[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"11",@"22",@"33", nil]];
    scroller.delegate=self;
    
    [self.view addSubview:scroller];


    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
        [self edgePanGesture:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
    NSLog(@"%lu",(unsigned long)index);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edgePanGesture:(id)sender {
    
    [self.frostedViewController presentMenuViewController];
//    [self.frostedViewController panGestureRecognized:sender];
}

-(void)panGestureRecognized:(id)sender{
    
     [self.frostedViewController panGestureRecognized:sender];
    
}
@end
