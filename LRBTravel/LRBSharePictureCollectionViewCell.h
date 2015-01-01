//
//  LRBSharePictureCollectionViewCell.h
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBSharePictureCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIImageView *sharedPictureView;
@property (strong, nonatomic) IBOutlet UILabel *upNumLabel;
@property (strong, nonatomic) IBOutlet UIButton *upButton;
-(void)setupCellWithDic:(NSDictionary *)dic;
@end
