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


-(void)setupTabelViewCellWith:(NSDictionary *)dic Type:(LRBPathTabelViewCellType)type {
    
    
    _timeLabel.text = [dic[@"create_time"] substringToIndex:10];
    [_picImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"image"]]]];
    _titleLabel.text = dic[@"title"];
    
    
    switch (type) {
        case TYPE_COLLECTION:{
            [_promptButton setEnabled:true];
           [_promptButton setTitle: @"取消收藏" forState: UIControlStateNormal];
            
               [_promptButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        }
            break;
        case TYPE_ORDER_PAYED:
            
             [_promptButton setTitle: @"已支付" forState: UIControlStateNormal];
            break;
        case TYPE_ORDER_UNPAY:
             [_promptButton setTitle: @"未支付" forState: UIControlStateNormal];
            [_promptButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            break;
        case TYPE_ORDER_CANCEL:
            [_promptButton setTitle: @"订单取消" forState: UIControlStateNormal];
            break;
        default:
            break;
    }
    [self setNeedsLayout];
    
    
    
}
@end
