//
//  LRBAlterPersonInfoViewController.m
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBAlterPersonInfoViewController.h"
#import "LRBUserInfo.h"
@interface LRBAlterPersonInfoViewController ()<UIAlertViewDelegate>

@end

@implementation LRBAlterPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lable1.text= self.viewStyle.line1;
    self.lable2.text=self.viewStyle.line2;
    self.textField1.enabled=self.viewStyle.EnableLine1;
    self.textField1.text=self.viewStyle.field1Text;
    //self.automaticallyAdjustsScrollViewInsets
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated
{

    if ([self.viewStyle.type isEqual:@"原昵称"]) {
       self.textField1.text= [LRBUserInfo shareUserInfo].userName;
    }
    if ([self.viewStyle.type isEqual:@"Phone"]) {
      self.textField1.text = [LRBUserInfo shareUserInfo].phoneNumber;
    }
    if ([self.viewStyle.type isEqual:@"Email"]) {
        self.textField1.text=[LRBUserInfo shareUserInfo].email;
    }



}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([string isEqualToString:@"\n"]) {
        
        return NO;
    }
    if (toBeString.length<=120) {
        return YES;
    }else return NO;
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if ([alertView.title isEqual:@"修改成功"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)alertInfoWithTitle:(NSString*)string message:(NSString*)message
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:string message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}

-(void)nullInfoAlert{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请填写完整信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
}

- (IBAction)update:(id)sender {
    NSString *s1= self.textField1.text;
    NSString *s2= self.textField2.text;
    if (s2.length==0) {
        [self nullInfoAlert];
        return;
    }
    if (self.textField1.text!=nil&&self.textField2.text!=nil) {
        if ([self.viewStyle.type isEqual:@"Password"]) {
#warning 暂时不允许改密码
            if ([self.textField1.text isEqualToString:self.textField2.text]) {
                [self alertInfoWithTitle:nil message:@"两次密码输入不一致"];
                return;
            }
        }
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSDictionary *parameters = @{@"type":[@"update" stringByAppendingString:self.viewStyle.type],@"id":[NSString stringWithFormat:@"%@",[LRBUserInfo shareUserInfo].userId],self.viewStyle.type.lowercaseString:self.textField2.text};
        
        // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *result=responseObject;
            if ([[result objectForKey:@"status"] isEqual:@1]) {
               
                
                
                if ([self.viewStyle.type isEqual:@"Nickname"]) {
                    [LRBUserInfo shareUserInfo].nickName=self.textField2.text;
                }
                if ([self.viewStyle.type isEqual:@"Phone"]) {
                    [LRBUserInfo shareUserInfo].phoneNumber=self.textField2.text;
                }
                if ([self.viewStyle.type isEqual:@"Email"]) {
                    [LRBUserInfo shareUserInfo].email=self.textField2.text;
                }
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                 [self alertInfoWithTitle:@"修改成功" message:nil];
            }else
            {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self alertInfoWithTitle:@"失败" message:@"用户信息有误"];
            }
            
            NSLog(@"%@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self alertInfoWithTitle:@"失败" message:@"网络链接出错"];
            NSLog(@"Error: %@", error);
            
        }];
        
        
        
    }
    
}
@end
