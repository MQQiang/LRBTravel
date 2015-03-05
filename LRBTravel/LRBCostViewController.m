//
//  LRBCostViewController.m
//  LRBTravel
//
//  Created by mq on 14/11/24.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBCostViewController.h"

@interface LRBCostViewController ()

@end

@implementation LRBCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _costTextView.text = self.info;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    if([self.info isEqualToString: @""]){
        
        _costTextView.text = @"暂无此项信息";
        
    }
    _titleLabel.text = self.titleString;
    
}

-(void)refreshView:(NSDictionary *)dic{
    
    
}


-(void)getCost {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"charge",@"id":[NSNumber numberWithUnsignedInteger:_costId ]};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
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

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
