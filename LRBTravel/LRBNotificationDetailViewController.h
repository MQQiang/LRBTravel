//
//  LRBNotificationDetailViewController.h
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBNotificationDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *notificationTitleLabel;
@property (strong, nonatomic) IBOutletCollection(UITextView) NSArray *notificationTextView;

-(void)setupViewWithDic:(NSDictionary *)dic;

@end
