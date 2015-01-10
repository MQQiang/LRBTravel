//
//  LRBNotificationCellTableViewCell.h
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBNotificationCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong,nonatomic) NSDictionary * dic;
-(void)setupLabelWithDic:(NSDictionary *)dic;

@end
