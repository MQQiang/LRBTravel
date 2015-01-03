//
//  LRBAlterPersonInfoViewController.m
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBAlterPersonInfoViewController.h"
#import "LRBUserInfo.h"
@interface LRBAlterPersonInfoViewController ()

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
-(void)alertInfoWithTitle:(NSString*)string message:(NSString*)message
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:string message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}

- (IBAction)update:(id)sender {
    NSString *s1= self.textField1.text;
    NSString *s2= self.textField2.text;
    
    if (self.textField1.text!=nil&&self.textField2.text!=nil) {
        if ([self.viewStyle.type isEqual:@"Password"]) {
#warning 暂时不允许改密码
            if ([self.textField1.text isEqualToString:self.textField2.text]) {
                [self alertInfoWithTitle:nil message:@"两次密码输入不一致"];
                return;
            }
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
       
        NSDictionary *parameters = @{@"type":[@"update" stringByAppendingString:self.viewStyle.type],@"id":[NSString stringWithFormat:@"%@",[LRBUserInfo shareUserInfo].userId],self.viewStyle.type.lowercaseString:self.textField2.text};
        
       // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *result=responseObject;
            if ([[result objectForKey:@"status"] isEqual:@1]) {
                [self alertInfoWithTitle:@"修改成功" message:nil];
                
            }else
             [self alertInfoWithTitle:@"失败" message:@"用户信息有误"];
            
            
            NSLog(@"%@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self alertInfoWithTitle:@"失败" message:@"网络链接出错"];
            NSLog(@"Error: %@", error);
            
        }];
        

    
    }
    
}
@end
