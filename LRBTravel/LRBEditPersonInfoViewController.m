//
//  LRBEditPersonInfoViewController.m
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBEditPersonInfoViewController.h"
#import "LRBCommonTableHeadView.h"
#import "LRBUserInfo.h"
#import "LRBAlterPersonInfoViewController.h"


@interface LRBEditPersonInfoViewController ()

@end

@implementation LRBEditPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableTitle=@[@[@"修改头像",@"修改密码",@"修改邮箱",@"修改电话"],@[@"推送通知设置",@"检查更新"]];
    self.sectionTitle=@[@"个人资料",@"系统设置"];
    [self.navigationController setNavigationBarHidden:NO];
    self.tableView.delegate=self;
    NSLog(@"tablev=%@,view=%@",self.tableView,self.view);
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.alterViewModels=[[NSMutableArray alloc]init];
    [self setAlterViewModels];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setAlterViewModels
{
   LRBUserInfo *userInfo= [LRBUserInfo shareUserInfo];
    LRBAlterInfoViewModel *text=[[LRBAlterInfoViewModel alloc] initWithFirstLine:@"原昵称:" secondline:@"新昵称:" enableLine1:NO firstFieldText: userInfo.userName ];
    [self.alterViewModels addObject:text];
    
    [self.alterViewModels addObject:[[LRBAlterInfoViewModel alloc] initWithFirstLine:@"修改密码:" secondline:@"确认密码:" enableLine1:YES firstFieldText:@""]];
    
    [self.alterViewModels addObject:[[LRBAlterInfoViewModel alloc] initWithFirstLine:@"原邮箱:" secondline:@"修改邮箱:" enableLine1:NO firstFieldText:userInfo.email]];
    
    [self.alterViewModels addObject:[[LRBAlterInfoViewModel alloc] initWithFirstLine:@"原电话:" secondline:@"修改电话:" enableLine1:NO firstFieldText:userInfo.phoneNumber]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.sectionTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self.tableTitle objectAtIndex:section] count];
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LRBCommonTableHeadView *headView=[[[NSBundle mainBundle] loadNibNamed:@"LRBCommonTableHeadView" owner:nil options:nil] lastObject];
    headView.title.text=[self.sectionTitle objectAtIndex:section];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 40;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LRBEditPersonInfoViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]init];
    }
    NSString *title=[[self.tableTitle objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row];
    if ([title isEqual:@"修改头像"]) {
        LRBUserInfo* userInfo=[LRBUserInfo shareUserInfo];
        title=userInfo.userName;
        //cell setAccessoryType:(UITableViewCellAccessoryType)
        [cell.imageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[LRBUserInfo shareUserInfo].profile ]]];
        
#warning 修改image样子
        CGSize itemSize = CGSizeMake(40, 40);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        
        
//        
//        cell.imageView.frame=CGRectMake(0, 0, 50, 50);
    }
    cell.textLabel.text=title;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 90;
        
    }else
        return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRBAlterPersonInfoViewController *alterView=[[LRBAlterPersonInfoViewController alloc] init];
    alterView.viewStyle=[self.alterViewModels objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:alterView animated:nil];



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
