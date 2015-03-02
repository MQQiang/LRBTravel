//
//  LRBIndexViewTableViewCell.h
//  LRBTravel
//
//  Created by mq on 14/11/8.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBIndexViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *descreptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *guideImageView;
-(void)setupCell:(UIImage *)guideImage;
-(void)setupCellWith:(NSDictionary*)dic;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@end
