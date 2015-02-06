//
//  UIImageView+Circle.m
//  LRBTravel
//
//  Created by mq on 15/1/3.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "UIImageView+Circle.h"

@implementation UIImageView(Circle)

-(void)drawCircleImage{
    
    CGRect rect = self.frame;
    self.layer.masksToBounds = YES;// 这个必须设置为
    self.layer.cornerRadius = self.frame.size.height/2.0f;
    NSLog(@"%f",self.layer.cornerRadius);
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 3.0f;
}


-(void)setupimageViewWithString:(NSString *)string{
    
    if (string) {
        
        
        [self setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:string ]] placeholderImage:nil];
        
    }
  
    
}

@end
