//
//  LRBPathTabelViewCell.h
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBPathTabelViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *promptButton;
@property (strong, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

-(void)setupTabelViewCellWith:(NSDictionary *)dic Type:(NSInteger) type;
@end
