//
//  LRBAlterPersonInfoViewController.h
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRBAlterInfoViewModel.h"
@interface LRBAlterPersonInfoViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

- (IBAction)update:(id)sender;

@property  (strong,nonatomic) LRBAlterInfoViewModel* viewStyle;

@end
