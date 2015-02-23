//
//  LRBPhotoBrowserViewController.h
//  LRBTravel
//
//  Created by Macintosh on 15-2-17.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBPhotoBrowserViewController : UIViewController

@property(assign,nonatomic)NSString *shareId;
@property(strong,nonatomic)NSDictionary *shareData;
@property(strong,nonatomic)UIImage * imageShared;


@end
