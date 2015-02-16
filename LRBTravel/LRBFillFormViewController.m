		//
//  LRBFillFromViewController.m
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFillFormViewController.h"
#import "LRBFillFormTableViewCell.h"
#import "LRBFillFormPersonInfo.h"
#import "LRBCommonTableHeadView.h"
#import "LRBUserInfo.h"
#import "LRBAcceptedOrderViewController.h"


#define kFillFormTableViewCellID @"FillFormTableViewCellID"

@interface LRBFillFormViewController ()<UITableViewDelegate,UITableViewDataSource,LRBFillFormTableViewCellandHeadDelegate>
{
    NSArray * _headTitleArray;
    NSArray *_contentTitleArray;
    NSString *priceString;
    
}
- (IBAction)addPerson:(id)sender;
-(void)changeFrameyFor:(UIView*)view by:(UIView*)lastView;

@end

@implementation LRBFillFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名";
    _formTableView.dataSource = self;
    _formTableView.delegate  = self;
#warning budong
    [_formTableView registerNib:[UINib nibWithNibName:@"LRBFillFormTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kFillFormTableViewCellID];
   _headTitleArray = @[@"订单信息" , @"联系人信息", @"第%d位联系人"];
    
    //_formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    _contentTitleArray = @[@[@"出发日期：",@"报名人数：",@"价格："],@[@"姓名：",@"电话：",@"邮箱："]];
    // Do any additional setup after loading the view from its nib.
    self.formTableView.scrollEnabled=YES;
    //[self.formTableView.tableHeaderView setHidden:YES];
    self.formTableView.tableHeaderView.backgroundColor=[UIColor blackColor] ;
    
//    LRBFillFormTableHeadView *titleView=[[[NSBundle mainBundle] loadNibNamed:@"LRBFillFormTableHeadView" owner:nil options:nil] lastObject];
//    self.formTableView.tableHeaderView=titleView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.personInfo addObject:[[LRBFillFormPersonInfo alloc]init]];
        NSLog(@"count1=%lu",(unsigned long)self.personInfo.count);
    
    _priceLabel.text = priceString;
    _titleLabel.text = _routeInfo[@"title"];
    [self resize];
}
		
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)personInfo
{
    if (_personInfo == nil) {
        _personInfo = [NSMutableArray array];
    }
    return _personInfo;
}
-(void)setRouteInfo:(NSDictionary *)routeInfo{
    
   
    _routeInfo = routeInfo;
    
//     NSDictionary *dic = [_routeInfo[@"paths"] objectAtIndex:0];
    
    priceString = [_routeInfo[@"price"] stringByAppendingString:@"元"];
    
}

-(void)resize
{
    self.formTableView.frame=CGRectMake(self.formTableView.frame.origin.x, self.formTableView.frame.origin.y, self.formTableView.frame.size.width, self.formTableView.contentSize.height);
    
    [self changeFrameyFor:self.addPersonBtm by:self.formTableView];
    
    NSLog(@"sy=%f", self.formTableView.frame.origin.y);
    [self changeFrameyFor:self.noticeView by:self.addPersonBtm];
//    [self changeFrameyFor:self.noticeLabel by:self.addPersonBtm];
//    [self changeFrameyFor:self.warningLable by:self.noticeLabel];
    [self changeFrameyFor:self.confrimView by:self.noticeView];

    self.scrollview.contentSize=CGSizeMake(self.titleLabel.frame.size.width, self.confrimView.frame.origin.y+self.confrimView.frame.size.height);
    
    
}
-(void)changeFrameyFor:(UIView*)view by:(UIView*)lastView
{
    view.frame=CGRectMake(view.frame.origin.x, lastView.frame.origin.y+lastView.frame.size.height, view.frame.size.width, view.frame.size.height);
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"count=%d",self.personInfo.count);
    return self.personInfo.count+1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section<2)
        return _headTitleArray[section];
    else return [NSString stringWithFormat:_headTitleArray[2],section];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRBFillFormTableViewCell * cell = [_formTableView dequeueReusableCellWithIdentifier:kFillFormTableViewCellID];
    cell.delegate=self;
    if (indexPath.section==0) {
        cell.textField.userInteractionEnabled=NO;
        cell.titleLabel.text = [[_contentTitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        if (indexPath.row==0) {
            cell.textField.text=[self.routeInfo objectForKey:@"start_time"];
        }
        if (indexPath.row==1) {
            cell.textField.placeholder=@"请填写报名人数";
            cell.textField.userInteractionEnabled=YES;
        }
        if (indexPath.row==2) {
            NSString *price=[self.routeInfo objectForKey:@"price"];
            cell.textField.text=[NSString stringWithFormat:@"%lu",price.intValue*self.personInfo.count];
        }
        
       // cell.textField.text=[_orderInfo InfoAt:indexPath.row];
    }
    else{
        cell.titleLabel.text = [[_contentTitleArray objectAtIndex:1] objectAtIndex:indexPath.row];
        LRBFillFormPersonInfo *pinfo=self.personInfo[indexPath.section-1];
         cell.textField.userInteractionEnabled=YES;
        cell.textField.text=[pinfo InfoAt:indexPath.row];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

-(void)signUp{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"join"};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LRBCommonTableHeadView *titleView=[[[NSBundle mainBundle] loadNibNamed:@"LRBCommonTableHeadView" owner:nil options:nil] lastObject];
    titleView.delegate=self;
    [self resize];
    if(section<2)
    {
        titleView.title.text= _headTitleArray[section];
     
    }else{
        titleView.title.text= [NSString stringWithFormat:_headTitleArray[2],section];
        titleView.sectionId=section-1;
           titleView.delBtm.hidden=NO;
    }
    
    
    return titleView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}





-(void)changeText:(LRBFillFormTableViewCell *)cell
{
    NSIndexPath *idxPath=[self.formTableView indexPathForCell:cell];
    NSLog(@"section=%ld %ld",(long)idxPath.section,(long)idxPath.row);


    if (idxPath.section==0) {
        [_orderInfo setInfo:cell.textField.text at:idxPath.row];
        
    }
    else{
        LRBFillFormPersonInfo *person=self.personInfo[idxPath.section-1];
        [person setInfo:cell.textField.text at:idxPath.row];
        
    }
}

-(void)deleteSectionAt:(NSUInteger)idx
{
           NSLog(@"removeAt=%lu",(unsigned long)idx);
    [self.personInfo removeObjectAtIndex:idx];
        [self.formTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)addPerson:(id)sender {
    [self.personInfo addObject:[[LRBFillFormPersonInfo alloc]init]];
    [self.formTableView reloadData];
        [self resize];
}
-(void)nullInfoAlert{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请填写完整信息" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
}
-(void)requestDataFromServer
{
//    http://121.40.173.195/lvrenbang/php/api/PathApi.php?type=join&user_id=1&path_id=1&name=zhangsan&phone=15157181976&email=fpc_2011@sina.com
    
    LRBUserInfo *userInfo=[LRBUserInfo shareUserInfo];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    LRBFillFormPersonInfo *keyPerson=[_personInfo objectAtIndex:0];
    
    if (keyPerson.userName==nil||keyPerson.phoneNumber==nil||keyPerson.email==nil) {
        [self nullInfoAlert];
        return;
    }
    

    NSString *paraName=@"";
    NSString *paraPhone=@"";
    NSString *paraEmail=@"";
    paraName=[paraName stringByAppendingString:keyPerson.userName];
    paraPhone=[paraPhone stringByAppendingString:keyPerson.phoneNumber];
    paraEmail=[paraEmail stringByAppendingString:keyPerson.email];
    for (int i=1; i<_personInfo.count; i++) {
        keyPerson=[_personInfo objectAtIndex:i];
        if (keyPerson.userName==nil||keyPerson.phoneNumber==nil||keyPerson.email==nil) {
           [self nullInfoAlert];
            return;
        }
        
        

        paraName=[paraName stringByAppendingString:@"|"];
        paraPhone=[paraPhone stringByAppendingString:@"|"];
        paraEmail=[paraEmail stringByAppendingString:@"|"];
        paraName=[paraName stringByAppendingString:keyPerson.userName];
        paraPhone=[paraPhone stringByAppendingString:keyPerson.phoneNumber];
        paraEmail=[paraEmail stringByAppendingString:keyPerson.email];
        
        
    }
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *parameters = @{@"type":@"join",@"user_id":userInfo.userId,@"path_id":[_routeInfo objectForKey:@"id"],@"name":keyPerson.userName,@"phone":keyPerson.phoneNumber,@"email":keyPerson.email};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // [self refreshView:responseObject];
        NSDictionary* returnInfo =responseObject;
        if([returnInfo objectForKey:@"status"]){
        LRBAcceptedOrderViewController* pushView= [[LRBAcceptedOrderViewController alloc]init];
            pushView.orderInfo=[returnInfo objectForKey:@"order"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.navigationController pushViewController:pushView animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Error: %@", error);
        
    }];
    NSLog(@"");
    
}

- (IBAction)submit:(id)sender {
    [self requestDataFromServer];
}



#pragma marks - LRBFillFormTableViewCellandHeadDelegate
-(CGFloat)getLocationWithFrame:(CGRect)cellFrame
{
    CGRect rect = [self.formTableView convertRect:cellFrame toView:[self.view superview]];
    CGSize viewSize=self.view.frame.size;
    return  viewSize.height/2-rect.origin.y-80;

}




@end


