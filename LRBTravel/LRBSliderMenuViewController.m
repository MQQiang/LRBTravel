//
//  LRBSliderMenuViewController.m
//  
//
//  Created by mq on 14/11/7.
//
//

#import "LRBSliderMenuViewController.h"
#import "LRBUtil.h"

@interface LRBSliderMenuViewController ()
{
    NSArray* _menuNameArray ;
}



@end

@implementation LRBSliderMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [LRBUtil drawCircleImage:_headImageView];
     _menuNameArray = @[@"精品路线",@"旅图分享",@"分享APP",@"意见反馈",@"关于旅人帮",@"设置"];
    
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    
    // Do any additional setup after loading the view from its nib.
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_menuTableView dequeueReusableCellWithIdentifier:@"MenuTableViewCellId"];
    if(cell == nil){
        
        cell= [[UITableViewCell alloc] init];
        
       
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.text = _menuNameArray[indexPath.row];
    
    return cell;

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath   {
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _menuNameArray.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_menuTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
