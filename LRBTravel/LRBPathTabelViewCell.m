//
//  LRBPathTabelViewCell.m
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBPathTabelViewCell.h"
#import "LRBUserInfo.h"

@implementation LRBPathTabelViewCell

- (void)awakeFromNib {
    [_promptButton  setEnabled:false];
    // Initialization code
    _picImageView.layer.cornerRadius = 2.0f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupTabelViewCellWith:(NSDictionary *)dic Type:(LRBPathTabelViewCellType)type {
    
    _selfDic = dic;
    _timeLabel.text = [dic[@"create_time"] substringToIndex:10];
    
    if([dic[@"image"] containsString:@"|"]){
        
        NSArray *array = [dic[@"image"] componentsSeparatedByString:@"|"];
        
        [_picImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[array objectAtIndex:0]]]];
        
    }
    else{
    
    [_picImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"image"]]]];
        
    }
    _titleLabel.text = dic[@"title"];
    
    
    
    
    switch (type) {
        case TYPE_COLLECTION:{
            [_promptButton setEnabled:true];
           [_promptButton setTitle: @"取消收藏" forState: UIControlStateNormal];
            
               [_promptButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        }
            break;
        case TYPE_ORDER_PAYED:
            
             [_promptButton setTitle: @"已支付" forState: UIControlStateNormal];
            break;
        case TYPE_ORDER_UNPAY:
        {
            
            if([dic[@"pay_status"] isEqual:@"0"]){
                [_promptButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
              [_promptButton setTitle: @"未支付" forState:
               UIControlStateNormal];
            }
            else if([dic[@"pay_status"] isEqual:@"1"]){
                [_promptButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
                
                [_promptButton setTitle: @"已支付" forState: UIControlStateNormal];
            }
            else{
                [_promptButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                  [_promptButton setTitle: @"已取消" forState: UIControlStateNormal];
            }
        }
            
            break;
        case TYPE_ORDER_CANCEL:
            [_promptButton setTitle: @"订单取消" forState: UIControlStateNormal];
            break;
        default:
            break;
    }
    [self setNeedsLayout];
    
    
    
}

- (IBAction)cancelCollect:(id)sender {
    
    
//    http://121.40.173.195/lvrenbang/php/api/UserApi.php?type=collectPath&user_id=3&path_id=4
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"cancelCollectPath",@"path_id":_selfDic[@"id"],@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshCollectionView" object:nil];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
}
@end
