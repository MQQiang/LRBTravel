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

-(void)setupCellWith:(NSDictionary*)dic{
    
    
    _descreptionLabel.text = [dic objectForKey:@"short_intro"];
    [self.guideImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix]stringByAppendingString:[dic objectForKey:@"image"] ]]];
    _titleLabel.text = [dic objectForKey:@"address"];
    NSString * price =[dic objectForKey:@"price"];
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
}

@end
