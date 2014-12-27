//
//  LRBUserInfo.m
//  LRBTravel
//
//  Created by mq on 14/11/16.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBUserInfo.h"
@interface LRBUserInfo()


@property (nonatomic,strong)NSString * userName;
@property (nonatomic,strong)UIImage *profile;
@property (nonatomic,strong)NSString *nickName;
@property (nonatomic,strong)NSString *phoneNumber;
@property (nonatomic,strong)NSString *nickWeiXin;
@property (nonatomic,strong)NSString *nickWeiBo;
@property (nonatomic,strong)NSString *updateTime;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,assign)NSUInteger cash;
@property (nonatomic,strong)NSString *selfDescription;
@property (nonatomic,strong)NSString *qqNumber;
@property (nonatomic,assign)NSUInteger userLevel;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSNumber *userId;
@end


@implementation LRBUserInfo
static LRBUserInfo * shareInfo;



+(LRBUserInfo *)shareUserInfo{
    

    
    static dispatch_once_t userInfoOnceToken;
    
    dispatch_once(&userInfoOnceToken, ^{
    
        shareInfo = [LRBUserInfo new];
    });
    
    return shareInfo;
}


-(void)setupUserInfo:(NSDictionary *)indoDic{
    
    _userName = [indoDic objectForKey:@"name"];
    _nickName = [indoDic objectForKey:@"nick"];
    _updateTime = [indoDic objectForKey:@"update_time"];
    _userLevel = [[indoDic objectForKey:@"user_level"] integerValue  ];
    
    _nickWeiBo = [indoDic objectForKey:@"weibo_nick"];
    _nickWeiXin = [indoDic objectForKey:@"weixin_nick"];
    _qqNumber = [indoDic objectForKey:@"qq"];
    _phoneNumber = [indoDic objectForKey:@"phone"];
//    _cash = [[indoDic objectForKey:@"cash"] integerValue];
    _createTime = [indoDic objectForKey:@"create_time"];
    _email = [indoDic objectForKey:@"email"];
    _selfDescription   = [indoDic objectForKey:@"description"];
    _userId = [indoDic objectForKey:@"id"];
    
}

-(void)setImagePrefix:(NSDictionary *)dic{
    
    
}
@end
