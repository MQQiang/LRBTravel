//
//  LRBEditPersonInforViewCell.m
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-3.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBEditPersonInforViewCell.h"

@implementation LRBEditPersonInforViewCell

- (void)awakeFromNib {
    // Initialization code
     _headView.layer.masksToBounds = YES;
    _headView.layer.cornerRadius = 40.0f;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changeImage:(id)sender {
    [self.delegate changeView];
}
@end
