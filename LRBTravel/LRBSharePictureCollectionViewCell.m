//
//  LRBSharePictureCollectionViewCell.m
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBSharePictureCollectionViewCell.h"

@implementation LRBSharePictureCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 5.0f;
    
}

-(void)setupCellWithDic:(NSDictionary *)dic{
    
    _titleLabel.text = dic[@"share_title"];
    [_sharedPictureView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"share_image"]]]];
    
    _nameLabel.text = dic[@"user_name"];
    
    [_headImage setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"user_image"]]]];
    NSLog(@"%@",[[LRBUtil imageProfix] stringByAppendingString:dic[@"user_image"]]);
    
    NSLog(@"%f",self.bounds.size.height);
    [self setNeedsDisplay ];
}

@end
