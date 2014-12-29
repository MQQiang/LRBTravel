//
//  LRBPathTabelViewCell.m
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBPathTabelViewCell.h"

@implementation LRBPathTabelViewCell

- (void)awakeFromNib {
    
    
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupTabelViewCellWith:(NSDictionary *)dic Type:(NSInteger)type {
    
    
    _timeLabel.text = [dic[@"create_time"] substringToIndex:10];
    [_picImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"image"]]]];
    _titleLabel.text = dic[@"title"];
    
}
@end
