//
//  LRBCostViewController.h
//  LRBTravel
//
//  Created by mq on 14/11/24.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBCostViewController : UIViewController
- (IBAction)close:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *costTextView;
@property(nonatomic,assign) NSInteger costId;
@property(nonatomic,copy)NSString *info;
@end
