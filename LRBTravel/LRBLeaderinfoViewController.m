//
//  LRBLeaderinfoViewController.m
//  
//
//  Created by mq on 14/11/9.
//
//

#import "LRBLeaderinfoViewController.h"
#import "UIImage+ImageEffects.h"
#import "PathDetailTableViewCell.h"
@interface LRBLeaderinfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LRBLeaderinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [LRBUtil drawCircleImage: self.bgImageView ];
//        [self.bgImageView.image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
//    self.bgImageView.alpha = 0;
    
    
    [_infoTableView registerNib:[UINib nibWithNibName:@"PathDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"InfoTabelViewId"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    self.bgImageView.alpha = 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [_dicArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PathDetailTableViewCell *cell = (PathDetailTableViewCell *)[_infoTableView dequeueReusableCellWithIdentifier:@"InfoTabelViewId"];
    
    [cell setupCellWithDic:[_dicArray objectAtIndex:indexPath.row] Type:0];
    
    
    return  cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backtoForward:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)refreshView:(NSDictionary *)dic{
    
    
    
}



-(void)getLeaderInfo{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"leader",@"id":[NSNumber numberWithUnsignedInteger:_leaderId ]};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}
@end
