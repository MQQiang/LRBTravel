//
//  LRBRegisterViewController.m
//  LRBTravel
//
//  Created by mq on 14/12/1.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBRegisterViewController.h"
#import "MBProgressHUD.h"

@interface LRBRegisterViewController (){
    MBProgressHUD *HUD;
}

@end

@implementation LRBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)exitKeyBoard:(UITextField *)sender {
    
    [sender resignFirstResponder];
}

- (IBAction)regiest:(id)sender {
    
    if([self checkParam]){
        
        [self registerMethod:nil];
    }
    else{
        
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"请检查输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    
}

-(BOOL)checkParam{
    
    if([_userNameTextField.text length] > 0 &&[_passwordTextField.text isEqualToString:_ensurePasswordTextField.text]&&[_passwordTextField.text length] >= 6&&[self validateEmail:_emailTextField.text])
        return true;
    
    return false;
}

-(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)registerMethod:(id)sender{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"login",@"name":_userNameTextField.text,@"email":_emailTextField.text,@"password":_passwordTextField.text};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        

        
    }];

}
-(void)refreshView:(NSDictionary *)sender{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if ([[sender objectForKey:@"status"] isEqual:@1]) {

        UIAlertController *aleryView = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        [aleryView addAction:action];
        
        [self presentViewController:aleryView animated:YES completion:nil];
    }
    else
    {
        
        
    }
    
}


@end
