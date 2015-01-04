//
//  LRBPersonInfoViewController.h
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBPersonInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)backtoForward:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *gradientView;
@property (strong, nonatomic) IBOutlet UIButton *settingButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *notificationButton;
@property (strong, nonatomic) IBOutlet UILabel *notifiacationNumberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UITableView *infoTabelView;
- (IBAction)showNotification:(id)sender;
- (IBAction)editInfo:(id)sender;
@end
