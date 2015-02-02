//
//  LRBThemeTabelViewCell.m
//  LRBTravel
//
//  Created by mq on 15/1/1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBThemeTabelViewCell.h"

@implementation LRBThemeTabelViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupViewWithDic:(NSDictionary *)dic{
    
    NSArray *pathArray = dic[@"paths"];
    
    _pathNumLabel.text = [NSString stringWithFormat:@"%lu条线路",(unsigned long)[pathArray count]];
    if([dic[@"image"] containsString:@"|"]){
        
        NSArray *array = [dic[@"image"] componentsSeparatedByString:@"|"];
        
         [_picView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[array objectAtIndex:0]]]];
        
        return;
        
    }
    
    
    
    [_picView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"image"]]]];


}
@end
