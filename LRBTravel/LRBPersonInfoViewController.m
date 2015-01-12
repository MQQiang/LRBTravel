//
//  LRBPersonInfoViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBPersonInfoViewController.h"
#import "LRBUserInfo.h"
#include "UIImageView+Circle.h"
#import "LRBPathTabelViewCell.h"
#import "LRBEditPersonInfoViewController.h"
#import "LRBNoticeViewController.h"
#import "LRBPictureShareViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "LRBSharePictureCollectionViewCell.h"

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface LRBPersonInfoViewController ()<CHTCollectionViewDelegateWaterfallLayout>{

    NSMutableArray * _collectionArray;
    NSMutableArray * _myOrderArray;
    NSMutableArray * _myShareArray;
    NSMutableArray *_dataArray;

    
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *shareTabBar;
@property(nonatomic,strong)NSMutableArray *cellSizes;

@end

@implementation LRBPersonInfoViewController



#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.headerHeight = 0;
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 20;
        layout.minimumInteritemSpacing = 30;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+330, self.view.frame.size.width, self.view.frame.size.height-330)collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
                _collectionView.backgroundColor = [UIColor whiteColor];
        //        [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
        //            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        
        
        [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        [_collectionView registerNib:[UINib nibWithNibName:@"LRBSharePictureCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:CELL_IDENTIFIER];
        
        [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:HEADER_IDENTIFIER];
        [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:FOOTER_IDENTIFIER];
    }
    [_collectionView setHidden:true];
    return _collectionView;
}

- (NSMutableArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = [NSMutableArray array];
        for (NSInteger i = 0; i < CELL_COUNT; i++) {
            CGSize size = CGSizeMake(arc4random() % 20 + 140, arc4random() % 20 + 246);
            _cellSizes[i] = [NSValue valueWithCGSize:size];
        }
    }
    return _cellSizes;
}

#pragma mark - Life Cycle

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _myShareArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //
    //    CHTCollectionViewWaterfallCell *cell =
    //    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
    //                                                                                forIndexPath:indexPath];
    
    LRBSharePictureCollectionViewCell  *cell = (LRBSharePictureCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    //    cell.displayString = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    [cell setupCellWithDic:[_myShareArray objectAtIndex:indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%f",[self.cellSizes[indexPath.item] CGSizeValue].height);
    return [self.cellSizes[indexPath.item] CGSizeValue];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    _shareTabBar.hidden = YES;
    NSLog(@"%@",_profileImageView);
     [_profileImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[LRBUserInfo shareUserInfo].profile ]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPathData) name:@"RefreshCollectionView" object:nil];
    
      [_profileImageView drawCircleImage];
    
    _nameLabel.text = [LRBUserInfo shareUserInfo].nickName;
    
    _infoTabelView.delegate = self;
    _infoTabelView.dataSource = self;
    _infoTabelView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    [_segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    
    
    [_shareTabBar addTarget:self action:@selector(shareTabAction:)forControlEvents:UIControlEventValueChanged];
    
    [_infoTabelView registerNib:[UINib nibWithNibName:@"LRBPathTabelViewCell" bundle:nil] forCellReuseIdentifier:@"PathTableViewId"];
    [self initData];
    [self requestUserMessageCount];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
}
-(void)initData{
    _myOrderArray = [[NSMutableArray alloc] init];
    _myShareArray = [[NSMutableArray alloc] init];
    _collectionArray = [[NSMutableArray alloc] init];
    
    _dataArray = [NSMutableArray arrayWithObjects:_myOrderArray,_collectionArray,_myOrderArray, nil];
}
// [segmentedControl setEnabled:NO forSegmentAtIndex:4];//设置指定索引选项不可选

// BOOL enableFlag = [segmentedControl isEnabledForSegmentAtIndex:4];//判断指定索引选项是否可选
//具体委托方法实例

-(void)shareTabAction:(UISegmentedControl *)Seg{
    
     NSInteger Index = Seg.selectedSegmentIndex;
    
    if(Index){
        [self requestShareFavouriteData];
    }
    else{
        [self requestShareData];
    }
    
}


-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    [_infoTabelView reloadData];
    
    switch (Index) {
        case 1:
            _shareTabBar.hidden = YES;
            _collectionView.hidden = YES;
             _infoTabelView.hidden = NO ;
            [self requestOrderData];
            break;
        case 2:
            _shareTabBar.hidden = YES;
            _collectionView.hidden = YES;
            _infoTabelView.hidden = NO ;
            [self requestPathData];
            break;
        case 3:
            _shareTabBar.hidden = NO ;
            _collectionView.hidden = YES;
            _infoTabelView.hidden = YES;
            [self requestShareData];
        default:
            break;
    }
    
    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_segmentedControl.selectedSegmentIndex != 0) {
        
      
        return [[_dataArray objectAtIndex:_segmentedControl.selectedSegmentIndex-1] count];
    }
    
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_segmentedControl.selectedSegmentIndex !=0) {
        
        if (_segmentedControl.selectedSegmentIndex ==1) {
            
            LRBPathTabelViewCell *cell = [_infoTabelView dequeueReusableCellWithIdentifier:@"PathTableViewId"];
            [cell setupTabelViewCellWith:[_dataArray[_segmentedControl.selectedSegmentIndex-1]objectAtIndex:indexPath.row] Type:TYPE_ORDER_UNPAY];
            
            return cell;
        }
        else if (_segmentedControl.selectedSegmentIndex ==2){
            
            LRBPathTabelViewCell *cell = [_infoTabelView dequeueReusableCellWithIdentifier:@"PathTableViewId"];
            [cell setupTabelViewCellWith:[_dataArray[_segmentedControl.selectedSegmentIndex-1]objectAtIndex:indexPath.row] Type:TYPE_COLLECTION];
            
            return cell;
            
            
        }
        else{
            
            
            LRBPathTabelViewCell *cell = [_infoTabelView dequeueReusableCellWithIdentifier:@"PathTableViewId"];
            [cell setupTabelViewCellWith:[_dataArray[_segmentedControl.selectedSegmentIndex-1]objectAtIndex:indexPath.row] Type:TYPE_COLLECTION];
            
            return cell;
        }

        
    }

    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString *text = @"";
    
    switch (indexPath.row) {
        case 0:
            text = [NSString stringWithFormat:@"姓名:%@",[LRBUserInfo shareUserInfo].nickName];
            break;
        case 1:
             text = [NSString stringWithFormat:@"邮箱:%@",[LRBUserInfo shareUserInfo].email ];
            break;
        case 2:
             text = [NSString stringWithFormat:@"电话:%@",[LRBUserInfo shareUserInfo].phoneNumber];
        default:
            break;
    }
    cell.textLabel.text = text;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_segmentedControl.selectedSegmentIndex) {
        
        return 80.0f;
    }
    
    
    return 60.0f;
}

- (IBAction)backtoForward:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showNotification:(id)sender{
    
    LRBNoticeViewController *vc = [[LRBNoticeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)requestOrderData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getParticipated",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self refreshView:responseObject];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        [_myOrderArray removeAllObjects];
        [_myOrderArray addObjectsFromArray:dic[@"path"]];
        
          [_infoTabelView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
}
-(void)requestPathData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getCollectedPath",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        [self refreshView:responseObject];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        [_collectionArray removeAllObjects];
        [_collectionArray addObjectsFromArray:dic[@"path"]];
          [_infoTabelView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];}
-(void)requestShareData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getMyShare",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        [self refreshView:responseObject];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        [_myShareArray removeAllObjects];
        [_myShareArray addObjectsFromArray:dic[@"share"]];
        _collectionView.hidden = false;
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
}


-(void)requestShareFavouriteData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getFavoriteShare",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        [self refreshView:responseObject];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        [_myShareArray removeAllObjects];
        [_myShareArray addObjectsFromArray:dic[@"share"]];
        _collectionView.hidden = false;
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
}

- (IBAction)editInfo:(id)sender {
    
    
    
    LRBEditPersonInfoViewController *newView=[[LRBEditPersonInfoViewController alloc] init];
    //
    //    [self presentViewController:newView animated:YES completion:^(){
    //
    //       // [self.frostedViewController hideMenuViewController];
    //    }];
    //
    
    [self.navigationController pushViewController:newView animated:YES];
    
    
}
-(void)requestUserMessageCount{
    
//    http://121.40.173.195/lvrenbang/php/api/UserApi.php?type=getMessageCount&user_id=1
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getMessageCount",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        [self refreshView:responseObject];
        
        NSDictionary *dic =(NSDictionary *)responseObject
        ;
        _notifiacationNumberLabel.text =[dic objectForKeyNotNSNULL:@"count"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}
@end
