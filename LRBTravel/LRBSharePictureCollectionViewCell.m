//
//  LRBSharePictureCollectionViewCell.m
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBSharePictureCollectionViewCell.h"
#import "LRBUserInfo.h"

@implementation LRBSharePictureCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    
}

- (IBAction)upThisPicture:(id)sender {
    
     [self.upButton setEnabled:false];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"addShareFavor",@"share_id":_dataDic[@"share_id"],@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.upButton setImage:[UIImage imageNamed:@"like_r"] forState:UIControlStateNormal];
        //
        NSLog(@"%@",responseObject);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"点赞成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        [self.upButton setEnabled:false];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
    
}

-(void)setupCellWithDic:(NSDictionary *)dic{
    
    _dataDic = dic;
    
    [LRBUtil drawCircleImage:_headImage];
    _titleLabel.text = dic[@"share_title"];
    [_sharedPictureView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"share_image"]]]];
    
    _nameLabel.text = dic[@"user_name"];
    
    if ([dic objectForKeyNotNSNULL:@"user_image"]) {
        
            [_headImage setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"user_image"]]]];
        
        //    NSLog(@"%@",[[LRBUtil imageProfix] stringByAppendingString:dic[@"user_image"]]);
        
    }
    if([dic objectForKeyNotNSNULL:@"collect_num"]){
    
        _upNumLabel.text = dic[@"collect_num"] ;
    }


    
    NSLog(@"%f",self.bounds.size.height);
    [self setNeedsDisplay ];
}

@end
