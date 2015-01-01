//
//  LRBThemeTabelViewCell.h
//  LRBTravel
//
//  Created by mq on 15/1/1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBThemeTabelViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *pathNumLabel;
@property (strong, nonatomic) IBOutlet UIImageView *picView;
-(void)setupViewWithDic:(NSDictionary *)dic;
@end
