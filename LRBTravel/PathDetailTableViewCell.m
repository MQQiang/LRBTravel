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
    
    if (_type) {
        
        [_headImage setFrame:CGRectMake(self.frame.origin.x-50, self.frame.origin.y-20, self.frame.size.width-60, self.frame.size.height-100)];
    }
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithDic:(NSDictionary *)dic Type:(NSInteger)type{
    
    _type = type;
    if (type) {
        [_headImage setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-20, self.frame.size.width-60, self.frame.size.height-100)];
        
          [_headImage setImageWithURL:[NSURL URLWithString: [[LRBUtil imageProfix] stringByAppendingString:[dic objectForKey:@"image"]]]];
         _detailTextView.text = dic[@"intro"];
        
        _nameLabel.text = dic[@"name"];
        _telLabel.text = dic[@"phone"];
        
        return;
    }
    [LRBUtil drawCircleImage: _headImage];
    
    [_headImage setImageWithURL:[NSURL URLWithString: [[LRBUtil imageProfix] stringByAppendingString:[dic objectForKey:@"image"]]]];
    _detailTextView.text = dic[@"intro"];
    _nameLabel.text = dic[@"name"];
    _telLabel.text = dic[@"phone"];
}

@end
