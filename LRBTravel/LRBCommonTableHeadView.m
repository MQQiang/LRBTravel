//
//  LRBFillFormTableHeadView.m
//  LRBTravel
//
//  Created by LiuZhiqi on 14-12-26.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBCommonTableHeadView.h"

@implementation LRBCommonTableHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)del:(id)sender {
    NSLog(@"aaaa");
    [self.delegate deleteSectionAt:self.sectionId];
}
@end
