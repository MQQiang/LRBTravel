//
//  LRBAcceptedOrderViewController.m
//  LRBTravel
//
//  Created by LiuZhiqi on 14-12-29.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBAcceptedOrderViewController.h"
#import "LRBCommonTableHeadView.h"
@interface LRBAcceptedOrderViewController ()
{
    NSArray * _cellTitle;
   // NSArray *_contentTitleArray;

}
@end

@implementation LRBAcceptedOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title=@"报名成功";
    self.title=@"报名成功0.0";

    
    UIView *headView=[ [UIView alloc]initWithFrame:CGRectMake(0.0f ,0.0f, 320, 50.0f) ];
    UILabel *headlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    headlabel.text=@"恭喜您报名成功";
    headlabel.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:headlabel];
    headlabel.hidden=NO;
    [self.tableView setTableHeaderView: headView];
    
    UIView *footView=[ [UIView alloc]initWithFrame:CGRectMake(0.0f ,10.0f, 320, 100.0f) ];
    UILabel *footlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    footlabel.text=@"您的申请已经成功\n我们会和您进行电话确认";
    footlabel.numberOfLines=2;
    footlabel.textAlignment=NSTextAlignmentCenter;
    [footView addSubview:footlabel];
    footlabel.hidden=NO;
    [self.tableView setTableFooterView: footView];
    
    
    
    self.tableView.tableHeaderView.hidden=NO;
    _cellTitle=@[@"订单名称:",@"订单编号:",@"订单日期:",@"订单价格:"];
    //self.tableView.tableHeaderView.
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AcceptOrder"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AcceptOrder" ] ;
    }
    

    cell.textLabel.text=_cellTitle[indexPath.row];
    cell.detailTextLabel.text=@"12222";
    cell.detailTextLabel.contentMode=UIViewContentModeLeft;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LRBCommonTableHeadView *titleView=[[[NSBundle mainBundle] loadNibNamed:@"LRBCommonTableHeadView" owner:nil options:nil] lastObject];
        titleView.title.text=@"订单信息";
    
    
    return titleView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
