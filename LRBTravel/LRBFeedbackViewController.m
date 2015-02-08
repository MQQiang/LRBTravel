//
//  LRBFeedbackViewController.m
//  LRBTravel
//
//  Created by mq on 14/11/9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFeedbackViewController.h"
#import "LRBUserInfo.h"

@interface LRBFeedbackViewController ()<UITextViewDelegate>

@end

@implementation LRBFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    self.feedBackTextView.layer.borderWidth = 1.0f;
    self.feedBackTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.feedBackTextView.layer.cornerRadius = 1.0f;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Share"] style:UIBarButtonItemStylePlain target:self action:@selector(feedBack:)];
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
    
    
    if ([_contactTextField.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写联系方式" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if([_feedBackTextView.text isEqualToString: @""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写反馈内容" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
        
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *parameters = @{@"type":@"shortIntro",@"user_id":[LRBUserInfo shareUserInfo].userId,@"contact":_contactTextField.text,@"content":_feedBackTextView.text};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        [self refreshView:responseObject];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"反馈成功" message:@"我们会尽快与你联系" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
          [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

    
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
