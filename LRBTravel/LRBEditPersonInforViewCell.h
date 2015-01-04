//
//  LRBEditPersonInforViewCell.h
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-3.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LRBEditPersonInfoViewCellDelegate;
@interface LRBEditPersonInforViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameTitle;

@property (weak,nonatomic) id<LRBEditPersonInfoViewCellDelegate>delegate;

- (IBAction)changeImage:(id)sender;

@end


@protocol LRBEditPersonInfoViewCellDelegate <NSObject>

-(void)changeView;

@end