//
//  LRBRouteInfoViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBRouteInfoViewController.h"
#import "EScrollerView.h"
#import "LRBFillFormViewController.h"
#import "LRBLeaderInfoViewController.h"
#import "UIImage+ImageEffects.h"
#import "UIViewController+Blur.h"
#import "LRBJourneyViewController.h"
#import "LRBCostViewController.h"
#import "LRBBannerPathModel.h"
#import "LRBUserInfo.h"
#import "MQDatePickView.h"
#import "THDatePickerViewController.h"

@interface LRBRouteInfoViewController ()<EScrollerViewDelegate,MQDatePickViewDelegate,THDatePickerDelegate,UIAlertViewDelegate>{
    
    UIBarButtonItem *_favouriteButton;
    NSDictionary *_infoDic;
    NSMutableArray *_bannerDArray;
    
    NSDate *_pickDate;
}
@property(nonatomic,strong)UIDatePicker *picker;
@property(nonatomic,strong)MQDatePickView *mqPicker;
@property(nonatomic,strong)THDatePickerViewController *datePicker;
@end

@implementation LRBRouteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _bannerDArray = [NSMutableArray new];
    _blurBlackView.alpha = 0;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = @"路线详情";
    
      self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    
    _favouriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorite_w"]style:UIBarButtonItemStylePlain target:self action:@selector(addThisToMyFavourite:)];
//
    self.navigationItem.rightBarButtonItem = _favouriteButton;
    
    [self requestViewInfo];
//    [self getBannerInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
}
-(void)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
         [LRBUtil makePhoneCall:@"13656678405"];
        
    }
    
}


- (IBAction)touchedButton:(id)sender {
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = [NSDate new];
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}

-(void)presentDataSelector:(id)sender{
    
//      [self.mqPicker show];
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = [NSDate new];
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
//    [self.view addSubview:self.picker];
}
-(UIDatePicker *)picker{
    
    if(_picker == nil){
        
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)];
        
        _picker.datePickerMode = UIDatePickerModeDate;
        
//        [self.view addSubview:_picker];
        
//        NSDate* minDate = [[NSDate alloc]initWithString:@"1900-01-01 00:00:00 -0500"];
//        NSDate* maxDate = [[NSDate alloc]initWithString:@"2099-01-01 00:00:00 -0500"];
//        
//        _picker.minimumDate = minDate;
//        _picker .maximumDate = maxDate;
    }
    
    return _picker;
    
}
-(MQDatePickView *)mqPicker{
    
    if(_mqPicker == nil){
        
        _mqPicker = [[MQDatePickView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200)];

        
        _mqPicker.delegate = self;
        
        [self.view addSubview:_mqPicker];
  
        [self.view bringSubviewToFront:_mqPicker];
    }
    
    return _mqPicker;
    
}

-(void)didClickConfirmButton{
    
    [_mqPicker hide];
    
}
-(void)didClickCancelButton{
    
    
    [_mqPicker  hide];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Button Method

-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
//    [self.mqPicker show];
    
}
- (IBAction)presentPathInfo:(id)sender {
    LRBCostViewController *vc = [[LRBCostViewController alloc] init];
    
    vc.info =_infoDic[@"short_intro"];
    
    vc.titleString = @"路线简介";
    
    [self loadSubView:vc];
}

- (IBAction)presentArrangeMemt:(id)sender {
    
    LRBLeaderinfoViewController * leaderInfoVC = [[LRBLeaderinfoViewController alloc] init];
    
    _blurBlackView.alpha = 0.7;
    leaderInfoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    leaderInfoVC.type = 1;
    
    leaderInfoVC.dicArrayString =_infoDic[@"path_arrangement"];
    
    [self loadSubView:leaderInfoVC];
    
    
}

- (IBAction)presentEquipmentRequire:(id)sender {
    
    
    LRBCostViewController *vc = [[LRBCostViewController alloc] init];
    if ([_infoDic objectForKeyNotNSNULL:@"device_requirement"]) {
        
        vc.info =_infoDic[@"device_requirement"];
    }
    
    vc.titleString = @"装备要求";
    
    [self loadSubView:vc];
    
}

- (IBAction)presentCostInfo:(id)sender {
    LRBCostViewController *vc = [[LRBCostViewController alloc] init];
    vc.info =_infoDic[@"charge_announcement"];
    
     vc.titleString = @"费用说明";
    
    [self loadSubView:vc];
    
   
}

- (IBAction)presentNotice:(id)sender {
    
    LRBCostViewController *vc = [[LRBCostViewController alloc] init];
    if ([_infoDic objectForKeyNotNSNULL:@"notify"]) {
        
        vc.info =_infoDic[@"notify"];
    }
    
    vc.titleString = @"预定须知";
    
    [self loadSubView:vc];
    
    
}
- (IBAction)connectPhoneNumber:(id)sender {
    
    UIAlertView *alert =[ [UIAlertView alloc] initWithTitle:@"是否拨打此电话" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
    [alert show];
    
   
}

- (IBAction)enrollForJourney:(id)sender {
    //Tuotuo
    LRBFillFormViewController *fillFormVC=[[LRBFillFormViewController alloc]init];
    fillFormVC.routeInfo=_infoDic;
    
    if(_pickDate){
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat : @"yyyy-MM-dd"];
        
        fillFormVC.dateString   =[formatter stringFromDate:_pickDate];
    
        
    }
    [self.navigationController pushViewController:fillFormVC animated:YES];
    
    
    
}

- (IBAction)presentLeaderInfo:(id)sender {
    
    LRBLeaderinfoViewController * leaderInfoVC = [[LRBLeaderinfoViewController alloc] init];
    
    _blurBlackView.alpha = 0.7;
    leaderInfoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    leaderInfoVC.type = 0;
    
    leaderInfoVC.dicArrayString =_infoDic[@"leader"];
    
    [self loadSubView:leaderInfoVC];
    
////    leaderInfoVC.modalPresentationStyle = UIModalPresentationFormSheet;
////    
////    [self presentViewController:leaderInfoVC animated:YES completion:^(){
////       
////        leaderInfoVC.view.backgroundColor = [UIColor clearColor];
////        
////    }];
//    
////    leaderInfoVC.view.backgroundColor = [UIColor clearColor];
////    
////    [leaderInfoVC.bgImageView setImage:[LRBUtil fullScreenShots]];
////    
//
//
//    
//    leaderInfoVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    
//        [self presentViewController:leaderInfoVC animated:YES completion:^(){
//    
////            leaderInfoVC.view.superview.backgroundColor = [UIColor clearColor];
//    
//        }];
//    
    
}
-(void)loadSubView:(UIViewController *)vc{
    
    
    _blurBlackView.alpha = 0.7;
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewControllerWithBlur:vc blurRedius:20 tintColor:[UIColor clearColor] saturationDeltaFactor:0.5];
    
    _blurBlackView.alpha = 0;
    
}

#pragma mark - selector
-(void)addThisToMyFavourite:(id)sender{
    
    [_favouriteButton setImage:[UIImage imageNamed:@"favorite"]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    NSDictionary *parameters = @{@"type":@"collectPath",@"journey":[NSNumber numberWithUnsignedInteger:_journeyId ],@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [self refreshView:responseObject];
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorite"] style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"Error: %@", error);
        
    }];

    
    
    
}

-(void)requestViewInfo{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getPath",@"id":[NSNumber numberWithUnsignedInteger:_journeyId ]};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
}
-(void)refreshView:(NSDictionary *)dic{
    
    _infoDic = dic[@"paths"];
    
    _locationLabel.text = dic[@"paths"][@"address"];
    _datanumLabel.text =[ dic[@"paths"][@"day"] stringByAppendingString:@"天"];
    NSMutableString *dataString = [NSMutableString stringWithString: @"出发日期："];
    _routeDespretionLabel.text = dic[@"paths"][@"title"];
   _titileLabel.text = [dataString stringByAppendingString: [dic[@"paths"][@"start_time"] substringToIndex:10]];
    
   NSString * imageUrl = [[LRBUtil imageProfix] stringByAppendingString:[_infoDic objectForKey:@"image"]];

    [self addBannerViewWithUrlArray:[NSArray arrayWithObject:imageUrl]];
    
    
}
-(void)getBannerInfo{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    NSDictionary *parameters = @{@"type":@"banner"};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self setBanner:[responseObject objectForKey:@"banner"]];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
    
}
-(void)setBanner:(NSArray *)bannerData{
    
    [_bannerDArray addObjectsFromArray:bannerData];
    
    NSMutableArray* imageArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in bannerData) {
        
        LRBBannerPathModel *model = [[LRBBannerPathModel alloc]init];
        [model setModelWithDic:dic];
        
        if(model.image)
            [imageArray addObject:model.image];
        
    }
    [self addBannerViewWithUrlArray:imageArray];
    
}

-(void)addBannerViewWithUrlArray:(NSArray *)image{
    
    if(image.count == 0)
        return;
    
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 64, self.view.frame.size.width,140)
                                                          ImageArray:image
                                                          TitleArray:nil];
    
    scroller.delegate=self;
    
    [self.view addSubview:scroller];
    [self.view sendSubviewToBack:scroller];
}


-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker{
    
    [_datePicker dismissSemiModalView];
}
-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker{
    
    [_datePicker dismissSemiModalView];
}


-(void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate{
    
    _pickDate = selectedDate;
    
//    [_datePicker dismissSemiModalView];
    
}
-(void)datePickerDidHide:(THDatePickerViewController *)datePicker{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-MM-dd"];
    

    _titileLabel.text= [@"出发时间：" stringByAppendingString:[formatter stringFromDate:_pickDate] ];
    

    
//   [_datePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
