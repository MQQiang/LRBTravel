//
//  LRBIndexViewTableViewCell.m
//  LRBTravel
//
//  Created by mq on 14/11/8.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBIndexViewTableViewCell.h"

@implementation LRBIndexViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell:(UIImage *)guideImage
{
    self.guideImageView.image = guideImage;
}

@end
