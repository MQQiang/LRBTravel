//
//  LRBRouteInfoViewController.h
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRBRouteInfo.h"
@interface LRBRouteInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titileLabel;
- (IBAction)presentPathInfo:(id)sender;
- (IBAction)presentArrangeMemt:(id)sender;
- (IBAction)presentEquipmentRequire:(id)sender;
- (IBAction)presentCostInfo:(id)sender;
- (IBAction)presentNotice:(id)sender;
- (IBAction)connectPhoneNumber:(id)sender;
- (IBAction)enrollForJourney:(id)sender;
- (IBAction)presentLeaderInfo:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurBlackView;
@property (strong, nonatomic) IBOutlet UIView *fillFromViewView;
@property(nonatomic,assign) NSInteger journeyId;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *datanumLabel;
@property(nonatomic,assign) NSDictionary* routeInfo;
@end
