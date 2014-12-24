//
//  LRBIndexViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBIndexViewController.h"
#import "REFrostedViewController.h"
#import "EScrollerView.h"
#import "LRBNavigationController.h"
#import "LRBSearchViewController.h"
#import "LRBRouteInfoViewController.h"
#import "LRBIndexViewTableViewCell.h"

#define kIndexTableViewCellID @"IndexTableViewCellID"


@interface LRBIndexViewController ()<EScrollerViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_guideImageArray;
}

@end

@implementation LRBIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _guideImageArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil];
    
    _indexTableView.dataSource = self;
    _indexTableView.delegate = self;
    [_indexTableView registerNib:[UINib nibWithNibName:@"LRBIndexViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kIndexTableViewCellID];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchViewController:)];
    
    self.title = @"旅人帮";
    
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 66, self.view.frame.size.width, 120)
                                                          ImageArray:[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"11",@"22",@"33", nil]];
    
    scroller.delegate=self;
    
    [self.view addSubview:scroller];
    
    [self requestDataFromServer];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{

  
}
-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
    NSLog(@"%lu",(unsigned long)index);
    LRBRouteInfoViewController  *routeInfoVC = [[LRBRouteInfoViewController alloc] init];
    
//    routeInfoVC = self.view.window.rootViewController;
    
    [self.navigationController pushViewController:routeInfoVC animated:YES];
    
    
}

#pragma mark - Table

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRBIndexViewTableViewCell *cell = [_indexTableView dequeueReusableCellWithIdentifier:kIndexTableViewCellID];
    
    [cell setupCell:[UIImage imageNamed:[_guideImageArray objectAtIndex:indexPath.row]]];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [_guideImageArray count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self EScrollerViewDidClicked:1];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edgePanGesture:(id)sender {
    
    [self.frostedViewController presentMenuViewController];
//    [self.frostedViewController panGestureRecognized:sender];
}

-(void)panGestureRecognized:(id)sender{
    
     [self.frostedViewController panGestureRecognized:sender];
    
}

-(void)showSearchViewController:(id)sender{
    
    LRBSearchViewController *searchVC = [[LRBSearchViewController alloc] init];
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

-(void)requestDataFromServer{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"index"};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

}

-(void)refreshView:(NSDictionary *)sender{
    
    NSLog(@"%@",sender);
    NSDictionary *dataDic = [sender objectForKey:@"result"];
    NSArray *banner = [dataDic objectForKey:@"banner"];
    NSArray *path = [dataDic objectForKey:@"path"];
    NSDictionary *theme = [dataDic objectForKey:@"theme"];
    
    
}

-(void)setBanner:(NSArray *)bannerData{
    
    
    
}
-(void)setPath:(NSArray *)pathData{
    
    
    
}
-(void)setTheme:(NSDictionary *)themeDic{
    
    
    
}

@end
