//
//  LRBShareViewController.h
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBShareViewController : UIViewController <UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate >
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIImage *image;


//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLable;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtm;
@property (weak, nonatomic) IBOutlet UITextField *imageTitle;

- (IBAction)UploadImg:(id)sender;

@end
