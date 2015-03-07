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
#import "LRBThemeTabelViewCell.h"

#define kIndexTableViewCellID @"IndexTableViewCellID"
#define kThemeTabelViewCellID @"ThemeTabelViewCellID"

@interface LRBIndexViewController ()<EScrollerViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_guideImageArray;
    NSMutableArray *_pathImageArray;
    int _guideImageIndex;
    int _pathImageIndex;
    NSMutableArray *_dataArray;
    
    EScrollerView *scrollerView;
}
@property (nonatomic,strong)UIScrollView *m_sc;
@property (nonatomic,strong)UIPageControl *m_pageC;
@property (nonatomic,strong)NSMutableArray *bannerDataArray;
@end

@implementation LRBIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"旅人帮";
    
    _bannerDataArray = [[NSMutableArray alloc] init];
    _dataArray = [NSMutableArray new];
    _pathImageArray  = [[NSMutableArray alloc] init];
    _guideImageArray = [NSMutableArray new];
    
    _indexTableView.dataSource = self;
    _indexTableView.delegate = self;
    
    [_indexTableView registerNib:[UINib nibWithNibName:@"LRBIndexViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kIndexTableViewCellID  ];
    
     [_indexTableView registerNib:[UINib nibWithNibName:@"LRBThemeTabelViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kThemeTabelViewCellID];
    
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
    
    if(image.count ==0)
        return;
    
    scrollerView=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/4)
                                                          ImageArray:image
                                                          TitleArray:nil];
    
    scrollerView.delegate=self;
    
//    [self.view addSubview:scrollerView];
    _guideImageIndex = 0;
    _pathImageIndex = 0;
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
//    routeInfoVC.routeInfo=_guideImageArray[index];
//    routeInfoVC = self.view.window.rootViewController;
    routeInfoVC.journeyId = [[_bannerDataArray objectAtIndex:index][@"id"] intValue];
    
    [self.navigationController pushViewController:routeInfoVC animated:YES];
    
    
}

#pragma mark - Table

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UITableViewCell  *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Spe"];
        
        [cell addSubview:scrollerView];
//        cell addSubview:self.
        return cell;
    }
    
    
    
    if ([_dataArray[indexPath.row-1][@"type"] isEqualToString:@"Theme"]) {
        
        LRBThemeTabelViewCell *cell = [_indexTableView dequeueReusableCellWithIdentifier:kThemeTabelViewCellID];
        [cell setupViewWithDic:_dataArray[indexPath.row-1]];
        //             _guideImageIndex++;
                    return cell;
        
    }
        
        LRBIndexViewTableViewCell *cell = [ _indexTableView dequeueReusableCellWithIdentifier:kIndexTableViewCellID];
                    [cell setupCellWith:_dataArray[indexPath.row-1]];
    
                    return  cell;
        


//    if (indexPath.row%2 ==0) {
//        if (_guideImageIndex < [_guideImageArray count]) {
//            
//            
//            LRBThemeTabelViewCell *cell = [_indexTableView dequeueReusableCellWithIdentifier:kThemeTabelViewCellID];
//             _guideImageIndex++;
//            return cell;
//           
//           
//        }
//        else{
//            
//            LRBIndexViewTableViewCell *cell = [ _indexTableView dequeueReusableCellWithIdentifier:kIndexTableViewCellID];
//            [cell setupCellWith:_pathImageArray[_pathImageIndex]];
//            _pathImageIndex++;
//            return  cell;
//            
//        }
//        
//    }
//    else{
//        
//        if (_pathImageIndex < [_pathImageArray count]) {
//            
//            LRBIndexViewTableViewCell *cell = [ _indexTableView dequeueReusableCellWithIdentifier:kIndexTableViewCellID];
//            [cell setupCellWith:_pathImageArray[_pathImageIndex]];
//            _pathImageIndex++;
//            return cell;
//        }
//        else{
//            LRBThemeTabelViewCell *cell = [_indexTableView dequeueReusableCellWithIdentifier:kThemeTabelViewCellID];
//            _guideImageIndex++;
//            return cell;
//            
//        }
//        
//    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [_guideImageArray count]+[_pathImageArray count]+1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    
    
   LRBRouteInfoViewController  *routeInfoVC = [[LRBRouteInfoViewController alloc] init];
    
    if ([_dataArray[indexPath.row-1][@"type"] isEqualToString:@"Theme"]) {
        
        NSArray *array = _dataArray[indexPath.row-1][@"paths"];
        if([array count] == 0){
            
            return;
        }
         routeInfoVC.journeyId = [[array objectAtIndex:0][@"id"] intValue];
        
        
        
    }else{
        
        routeInfoVC.journeyId = [[_dataArray objectAtIndex:indexPath.row-1][@"id"] intValue];
        routeInfoVC.routeInfo = [_dataArray objectAtIndex:indexPath.row-1];
        
    }


    
    [self.navigationController pushViewController:routeInfoVC animated:YES];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (indexPath.row == 0) {
        
        return 150;
    }
    
    
    if ([_dataArray[indexPath.row-1][@"type"] isEqualToString:@"Path"]) {
        
        return  250.0f;
    }
    return 220.0f;
    
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
//     UINavigationController *nav =   [[UINavigationController alloc] initWithRootViewController:self];
    
//    [nav pushViewController:searchVC animated:YES];
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

-(void)requestDataFromServer{
    
    [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"index"};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        
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

//    NSDictionary *theme = [dataDic objectForKey:@"theme"];
    NSArray *theme = [dataDic objectForKey:@"theme"];
    [self setBanner:banner];

    [self setPath:path];
    [self setTheme:theme];
}

-(void)setBanner:(NSArray *)bannerData{
    
    [_bannerDataArray addObjectsFromArray:bannerData];
    
    NSMutableArray* imageArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in bannerData) {
        
        LRBBannerPathModel *model = [[LRBBannerPathModel alloc]init];
        [model setModelWithDic:dic];
        
        if(model.image)
        [imageArray addObject:model.image];
        
    }
    [self addBannerViewWithUrlArray:imageArray];
    
}
-(void)setPath:(NSArray *)pathData{
    
    [_pathImageArray addObjectsFromArray: pathData];
//    [_indexTableView reloadData];
    
    
}
-(void)setTheme:(NSArray *)themeDic{
    
    [_guideImageArray addObjectsFromArray: themeDic];
    
    [self mixArray];
    [_indexTableView reloadData];
    
}
-(void)mixArray{
    
    NSInteger maxIndex = [_guideImageArray count]> [_pathImageArray count]?[_guideImageArray count]:[_pathImageArray count];
    
    for (NSInteger i = 0; i < maxIndex; i++) {
        
        if(i < [_guideImageArray count]){
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_guideImageArray[i]];
            dic[@"type"] = @"Theme";
            [_dataArray addObject:dic];
        }
        if (i < [_pathImageArray count]) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_pathImageArray[i]];
            dic[@"type"] = @"Path";
          
            [_dataArray addObject:dic];
        }
        
    }
    
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
