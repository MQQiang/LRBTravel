//
//  LRBFeedbackViewController.m
//  LRBTravel
//
//  Created by mq on 14/11/9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFeedbackViewController.h"

@interface LRBFeedbackViewController ()<UITextViewDelegate>

@end

@implementation LRBFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    self.feedBackTextView.layer.borderWidth = 1.0f;
    self.feedBackTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.feedBackTextView.layer.cornerRadius = 1.0f;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(feedBack:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _backGroundLabel.hidden = YES;
}

-(void)textViewDidChange:(UITextView *)textView{

    _wordNumberLabel.text = [NSString stringWithFormat:@"字数（%lu/120)",(unsigned long)[textView.text length] ];
}
- (IBAction)hiddenKeyboard:(id)sender {
    
    
    [_contactTextField resignFirstResponder];
    [_feedBackTextView  resignFirstResponder];
}

-(void)feedBack:(id)sender{
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
