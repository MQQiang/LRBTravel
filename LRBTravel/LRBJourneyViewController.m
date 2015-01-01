//
//  LRBJourneyViewController.m
//  
//
//  Created by mq on 14/11/8.
//
//

#import "LRBJourneyViewController.h"

@interface LRBJourneyViewController ()

@end

@implementation LRBJourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     _textField.text = _info;
    
    _textField.editable = false;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)refreshView:(NSDictionary *)dic{
    
    
    
}

-(void)setInfo:(NSString *)info{
    _info = info;
    
   
}

-(void)getJourneyInfo{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"shortIntro",@"id":[NSNumber numberWithUnsignedInteger:_journeyId ]};
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
