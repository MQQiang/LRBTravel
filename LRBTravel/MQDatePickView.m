
//  MQDatePickView.m
//  LRBTravel
//
//  Created by mq on 15/3/6.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "MQDatePickView.h"

@implementation MQDatePickView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"MQDatePickView"owner:self options:nil];
        UIView *backupSearchView = [nibView objectAtIndex:0];
        [backupSearchView setFrame:frame];
        [self addSubview:backupSearchView];
    }
    return self;
}

-(void)show{
    
    [UIView animateWithDuration:0.5f animations:^(){
        
        self.frame = CGRectMake(0, 368, 320, 200);
        
    }];
    
    
}

-(void)hide{
    
    [UIView animateWithDuration:0.5f animations:^(){
        
        self.frame = CGRectMake(0, 568, 320, 200);

        
    }];
}

- (IBAction)cancel:(id)sender {
    
    [self.delegate didClickCancelButton];
}

- (IBAction)confirm:(id)sender {
    
    [self.delegate didClickConfirmButton];
}
@end
