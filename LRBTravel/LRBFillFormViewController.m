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
#import "LRBFillFormTableHeadView.h"


#define kFillFormTableViewCellID @"FillFormTableViewCellID"

@interface LRBFillFormViewController ()<UITableViewDelegate,UITableViewDataSource,LRBFillFormTableViewCellandHeadDelegate>
{
    NSArray * _headTitleArray;
    NSArray *_contentTitleArray;
    
}
- (IBAction)addPerson:(id)sender;

@end

@implementation LRBFillFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名";
    _formTableView.dataSource = self;
    _formTableView.delegate  = self;
    [_formTableView registerNib:[UINib nibWithNibName:@"LRBFillFormTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kFillFormTableViewCellID];
   _headTitleArray = @[@"订单信息" , @"联系人信息", @"第%d位联系人"];
    
    _formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    _contentTitleArray = @[@[@"出发日期：",@"报名人数：",@"价格："],@[@"姓名：",@"电话：",@"邮箱："]];
    // Do any additional setup after loading the view from its nib.
    self.formTableView.scrollEnabled=YES;
    _orderInfo=[[LRBFillFormOrderInfo alloc]init];

    [self.personInfo addObject:[[LRBFillFormPersonInfo alloc]init]];
        NSLog(@"count1=%d",self.personInfo.count);
    self.numPerson=1;
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
        cell.titleLabel.text = [[_contentTitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textField.text=[_orderInfo InfoAt:indexPath.row];
    }
    else{
        cell.titleLabel.text = [[_contentTitleArray objectAtIndex:1] objectAtIndex:indexPath.row];
        LRBFillFormPersonInfo *pinfo=self.personInfo[indexPath.section-1];
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
    LRBFillFormTableHeadView *titleView=[[[NSBundle mainBundle] loadNibNamed:@"LRBFillFormTableHeadView" owner:nil options:nil] lastObject];
    titleView.delegate=self;
    if(section<2)
    {
        titleView.title.text= _headTitleArray[section];
        titleView.delBtm.hidden=YES;
    }else{
        titleView.title.text= [NSString stringWithFormat:_headTitleArray[2],section];
        titleView.sectionId=section-1;
    }
    
    
    return titleView;
}

-(void)changeText:(LRBFillFormTableViewCell *)cell
{
    NSIndexPath *idxPath=[self.formTableView indexPathForCell:cell];
    NSLog(@"section=%d %d",idxPath.section,idxPath.row);

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
           NSLog(@"removeAt=%d",idx);
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
}
@end
