//
//  LRBShareToThirdPartyViewController.h
//  LRBTravel
//
//  Created by mq on 15/3/7.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBShareToThirdPartyViewController : UIViewController

@property(nonatomic,strong)UIImage *image;
- (IBAction)shareWeibo:(id)sender;
- (IBAction)shareFriendCircle:(id)sender;
- (IBAction)shareWeiFriend:(id)sender;
- (IBAction)shareTecentWeibo:(id)sender;
- (IBAction)shareQQZone:(id)sender;
@end
