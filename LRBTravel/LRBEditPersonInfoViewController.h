//
//  LRBEditPersonInfoViewController.h
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRBAlterInfoViewModel.h"

@interface LRBEditPersonInfoViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *tableTitle;
@property(nonatomic,strong) NSArray *sectionTitle;

@property (nonatomic,strong) NSMutableArray *alterViewModels;

@end
