//
//  LRBFillFormTableHeadView.h
//  LRBTravel
//
//  Created by LiuZhiqi on 14-12-26.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRBFillFormTableViewCell.h"
@protocol LRBFillFormTableViewCellandHeadDelegate;



@interface LRBFillFormTableHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (assign,nonatomic) NSUInteger sectionId;
@property (weak, nonatomic) IBOutlet UIButton *delBtm;
@property(nonatomic,assign) id<LRBFillFormTableViewCellandHeadDelegate> delegate;
- (IBAction)del:(id)sender;

@end
