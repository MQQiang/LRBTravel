//
//  PathDetailTableViewCell.m
//  LRBTravel
//
//  Created by mq on 15/1/13.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "PathDetailTableViewCell.h"

@implementation PathDetailTableViewCell

- (void)awakeFromNib {
    
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithDic:(NSDictionary *)dic Type:(NSInteger)type{
     [LRBUtil drawCircleImage: _headImage];
}

@end
