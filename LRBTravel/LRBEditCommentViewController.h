//
//  LRBEditCommentViewController.h
//  LRBTravel
//
//  Created by Macintosh on 15-2-24.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBEditCommentViewController : UIViewController
@property(assign,nonatomic)NSString *shareId;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;

@end
