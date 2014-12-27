//
//  LRBFillFromViewController.h
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRBFillFormOrderInfo.h"

@interface LRBFillFormViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UITableView *formTableView;
@property (strong, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningLable;
@property (strong, nonatomic) IBOutlet UIView *confrimView;
//@property (strong, nonatomic) NSArray *personInfos;
@property (weak, nonatomic) IBOutlet UIButton *addPersonBtm;

@property (assign, nonatomic) NSInteger numPerson;
@property (strong,nonatomic) NSMutableArray* personInfo;
@property (strong,nonatomic) LRBFillFormOrderInfo* orderInfo;

@end
