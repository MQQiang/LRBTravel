//
//  LRBRectUIView.m
//  LRBTravel
//
//  Created by mq on 15/2/7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBRectUIView.h"

@implementation LRBRectUIView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    self.layer.cornerRadius = 2.0f;
    

    return self;
}

@end
