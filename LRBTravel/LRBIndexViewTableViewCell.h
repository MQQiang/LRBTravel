//
//  LRBIndexViewTableViewCell.h
//  LRBTravel
//
//  Created by mq on 14/11/8.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBIndexViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *guideImageView;
-(void)setupCell:(UIImage *)guideImage;
@end
