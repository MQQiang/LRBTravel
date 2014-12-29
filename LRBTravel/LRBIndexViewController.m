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
#import "LRBBannerPathModel.h"


#define kIndexTableViewCellID @"IndexTableViewCellID"


@interface LRBIndexViewController ()<EScrollerViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_guideImageArray;
}
@property (nonatomic,strong)UIScrollView *m_sc;
@property (nonatomic,strong)UIPageControl *m_pageC;
@property (nonatomic,strong)NSMutableArray *bannerDataArray;
@end

@implementation LRBIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bannerDataArray = [[NSMutableArray alloc] init];
    
    
    _guideImageArray = [NSMutableArray new];
    
    _indexTableView.dataSource = self;
    _indexTableView.delegate = self;
    [_indexTableView registerNib:[UINib nibWithNibName:@"LRBIndexViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kIndexTableViewCellID];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchViewController:)];
    
    self.title = @"旅人帮";
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [self requestDataFromServer];
//    [self buildLayout];
    // Do any additional setup after loading the view from its nib.
}

-(void)addBannerViewWithUrlArray:(NSArray *)image{
    
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/4)
                                                          ImageArray:image
                                                          TitleArray:nil];
    
    scroller.delegate=self;
    
    [self.view addSubview:scroller];
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
    routeInfoVC.routeInfo=_guideImageArray[index];
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
    
    [cell setupCellWith:[_guideImageArray objectAtIndex:indexPath.row]];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [_guideImageArray count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self EScrollerViewDidClicked:1];
//    [self EScrollerViewDidClicked:indexPath.row];
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
    NSLog(@"");

}

-(void)refreshView:(NSDictionary *)sender{
    
    NSLog(@"%@",sender);
    NSDictionary *dataDic = [sender objectForKey:@"result"];
    NSArray *banner = [dataDic objectForKey:@"banner"];
    NSArray *path = [dataDic objectForKey:@"path"];
#warning NSDICTIONARY??为什么dic  array
//    NSDictionary *theme = [dataDic objectForKey:@"theme"];
    NSArray *theme = [dataDic objectForKey:@"theme"];
    [self setBanner:banner];
#warning theme????
    [self setPath:theme];
    
}

-(void)setBanner:(NSArray *)bannerData{
    
    NSMutableArray* imageArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in bannerData) {
        
        LRBBannerPathModel *model = [[LRBBannerPathModel alloc]init];
        [model setModelWithDic:dic];
        [imageArray addObject:model.image];
        
    }
    [self addBannerViewWithUrlArray:imageArray];
    
}
-(void)setPath:(NSArray *)pathData{
    
    [_guideImageArray addObjectsFromArray: pathData];
    [_indexTableView reloadData];
    
    
}
-(void)setTheme:(NSDictionary *)themeDic{
    
    
    
}

#pragma mark
#pragma mark build interface

-(void)buildLayout
{
    self.m_sc.delegate =self;
    [self.view addSubview:self.m_sc];
    [self.view addSubview:self.m_pageC];
}

-(UIScrollView *)m_sc
{
    if (!_m_sc)
    {
        _m_sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width,self.view.frame.size.height/4)];
        [_m_sc setContentSize:CGSizeMake(self.view.frame.size.width*4,self.view.frame.size.height)];
        for (int i=0; i<4; i++)
        {
            UIView *uv = [[UIView alloc]init];
            uv.frame =CGRectMake(self.view.bounds.size.width*i,0 , self.view.bounds.size.width,self.view.bounds.size.height) ;
            uv.backgroundColor = [UIColor colorWithRed:i*0.1+0.5 green:i*0.1+0.7 blue:i*0.1+0.1 alpha:1];
            UILabel *lab = [[UILabel alloc]init];
            lab.frame =CGRectMake(100,100, 200, 50);
            lab.backgroundColor = [UIColor clearColor];
            lab.text = [@"welcome"stringByAppendingFormat:@"%d",i+1 ];
            lab.textColor=[UIColor blackColor];
            [uv addSubview:lab];
            [_m_sc addSubview:uv];
        }
        _m_sc.showsHorizontalScrollIndicator =NO; //是否显示水平滚动条
        _m_sc.showsVerticalScrollIndicator =NO;//是否垂直水平滚动条
        _m_sc.pagingEnabled =YES;  //是否翻页
        _m_sc.scrollEnabled =YES;
    }
    return _m_sc;
}

-(UIPageControl *)m_pageC
{
    if (!_m_pageC)
    {
        _m_pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(60,100,200 ,30)];
        _m_pageC.backgroundColor = [UIColor clearColor];
        _m_pageC.currentPageIndicatorTintColor = [UIColor redColor];
        _m_pageC.pageIndicatorTintColor = [UIColor blackColor];
        _m_pageC.numberOfPages =4;
        
    }
    return _m_pageC;
}

#pragma mark
#pragma mark UIScrollViewDelegate method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int size  = self.view.frame.size.width;
    int page = self.m_sc.contentOffset.x/size;
    self.m_pageC.currentPage = page;
}

@end
