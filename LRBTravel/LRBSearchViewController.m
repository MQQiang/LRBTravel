//
//  LRBSearchViewController.m
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBSearchViewController.h"
#import "LRBIndexViewTableViewCell.h"
#define kResultTableViewCellID @"kResultTableViewCellID"

@interface LRBSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray*  _guideImageArray;
}

@end

@implementation LRBSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.delegate = self;
    _resultTableView.delegate = self;
    _resultTableView.dataSource = self;
    _guideImageArray = [[NSMutableArray  alloc] init];
    
    [_resultTableView registerNib:[UINib nibWithNibName:@"LRBIndexViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kResultTableViewCellID];
    
    self.title = @"搜索";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    
    [self requestHotPathTags];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)search {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *parameters = @{@"type":@"search",@"keyword":_searchBar.text};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

}
-(void)refreshView:(NSDictionary *)dic{
    

    _hotTagView.hidden = YES;
    [_guideImageArray addObjectsFromArray:[dic objectForKey:@"paths"] ];
    [_resultTableView reloadData];
    
    if (!_guideImageArray.count) {
        [[[UIAlertView alloc] initWithTitle:@"没有找到结果" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show ];
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRBIndexViewTableViewCell *cell = [_resultTableView dequeueReusableCellWithIdentifier:kResultTableViewCellID];
    
    [cell setupCellWith:[_guideImageArray objectAtIndex:indexPath.row]];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [_guideImageArray count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    [self EScrollerViewDidClicked:1];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self search];
}// called when keyboard search button pressed


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}// return NO to not become first responder

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{          // called when text starts editing
    [searchBar setShowsCancelButton:YES animated:YES];   //  动画显示取消按钮
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    return YES;
}// return NO to not resign first responder

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}// called when text ends editing

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{   // called when text changes (including clear)
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{           // called when cancel button pressed
    [searchBar setShowsCancelButton:NO animated:NO];    // 取消按钮回收
    [searchBar resignFirstResponder];
    
    _hotTagView.hidden = FALSE;// 取消第一响应值,键盘回收,搜索结束
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)requestHotPathTags{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"getHotTag",@"num":@5};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshButton:responseObject];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSLog(@"Error: %@", error);
        
    }];
    
    
}

-(void)refreshButton:(NSDictionary *)dic{
    
    if ([dic[@"status" ] isEqual:@1]) {
        
        NSArray * tagArray = dic[@"tags"];
        
        for (int i =0; i < [tagArray count]; i++) {
            NSDictionary *dict = [tagArray objectAtIndex:i];
            UIButton *button = [_hotPathButtons objectAtIndex:i];
            [button setTitle:dict[@"name"] forState:UIControlStateNormal];
        }
        
        
    }
    
    
}
- (IBAction)hotPathButtonClick:(id)sender {
    
    
    UIButton *tapButton = (UIButton *)sender ;
    
    [_searchBar setText:tapButton.titleLabel.text];
    
    
    
}
@end
