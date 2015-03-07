//
//  MQDatePickView.h
//  LRBTravel
//
//  Created by mq on 15/3/6.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQDatePickViewDelegate<NSObject>

@required

-(void)didClickCancelButton;

-(void)didClickConfirmButton;

@end


@interface MQDatePickView : UIView


@property(weak,nonatomic) id <MQDatePickViewDelegate> delegate;
-(void)show;
-(void)hide;

- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
