//
//  LRBFillFormTableViewCell.h
//  LRBTravel
//
//  Created by mq on 14/11/9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LRBFillFormTableViewCellandHeadDelegate;


@interface LRBFillFormTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic,assign) id<LRBFillFormTableViewCellandHeadDelegate> delegate;


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)didEditing:(id)sender;

@end
@protocol LRBFillFormTableViewCellandHeadDelegate<NSObject>
@optional
-(void)changeText:(LRBFillFormTableViewCell *)cell;
-(void)deleteSectionAt:(NSUInteger)idx;
-(CGFloat)getLocationWithFrame:(CGRect)cellFrame;
@end