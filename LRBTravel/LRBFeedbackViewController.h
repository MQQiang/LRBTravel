//
//  LRBFeedbackViewController.h
//  LRBTravel
//
//  Created by mq on 14/11/9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBFeedbackViewController : LRBFirstLayerBaseViewController

@property (strong, nonatomic) IBOutlet UITextField *contactTextField;
@property (strong, nonatomic) IBOutlet UITextView *feedBackTextView;

@property (strong, nonatomic) IBOutlet UILabel *backGroundLabel;
@property (strong, nonatomic) IBOutlet UILabel *wordNumberLabel;

@end
