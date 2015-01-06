//
//  LRBNotificationCellTableViewCell.m
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBNotificationCellTableViewCell.h"

@implementation LRBNotificationCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_headImageView drawCircleImage];
    _bgView.layer.cornerRadius = 6.0f;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupLabelWithDic:(NSDictionary *)dic{
    
    NSLog(@"dic+%@",dic);
    
    _nameLabel.text = dic[@"u_name"];
    
   [_headImageView setupimageViewWithString:dic[@"u_image"]];
    
    _contentLabel.text = dic[@"s_title"];
    
    _timeLabel.text =  [LRBUtil intervalSinceNow:dic[@"m_create_time"]] ;

    
}

@end
