//
//  LRBUserInfo.m
//  LRBTravel
//
//  Created by mq on 14/11/16.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//




#import "LRBUserInfo.h"
@interface LRBUserInfo()


//@property (nonatomic,strong,readonly)NSString * userName;
//@property (nonatomic,strong,readonly)NSString *profile;
//@property (nonatomic,strong,readonly)NSString *nickName;
//@property (nonatomic,strong,readonly)NSString *phoneNumber;
//@property (nonatomic,strong,readonly)NSString *nickWeiXin;
//@property (nonatomic,strong,readonly)NSString *nickWeiBo;
//@property (nonatomic,strong,readonly)NSString *updateTime;
//@property (nonatomic,strong,readonly)NSString *createTime;
//@property (nonatomic,assign,readonly)NSUInteger cash;
//@property (nonatomic,strong,readonly)NSString *selfDescription;
//@property (nonatomic,strong,readonly)NSString *qqNumber;
//@property (nonatomic,assign,readonly)NSUInteger userLevel;
//@property (nonatomic,strong,readonly)NSString *email;
//@property (nonatomic,strong,readwrite)NSNumber *userId;
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




-(void)setupUserInfo:(NSMutableDictionary *)indoDic{
    
    NSEnumerator *enumerator = [indoDic keyEnumerator];
    id key;
    
    
    _userName = [indoDic objectForKeyNotNSNULL:@"name"];
#warning 貌似不支持中文。。
    _nickName = [indoDic objectForKeyNotNSNULL:@"nick"];
    _updateTime = [indoDic objectForKeyNotNSNULL:@"update_time"];
    _userLevel = [[indoDic objectForKeyNotNSNULL:@"user_level"] integerValue  ];
    
    _nickWeiBo = [indoDic objectForKeyNotNSNULL:@"weibo_nick"];
    _nickWeiXin = [indoDic objectForKeyNotNSNULL:@"weixin_nick"];
    _qqNumber = [indoDic objectForKeyNotNSNULL:@"qq"];
    _phoneNumber = [indoDic objectForKeyNotNSNULL:@"phone"];
    //    _cash = [[indoDic objectForKey:@"cash"] integerValue];
    _createTime = [indoDic objectForKeyNotNSNULL:@"create_time"];
    _email = [indoDic objectForKeyNotNSNULL:@"email"];
    _selfDescription   = [indoDic objectForKeyNotNSNULL:@"description"];
    _userId = [indoDic objectForKeyNotNSNULL:@"id"];
    
    _profile = [indoDic objectForKeyNotNSNULL:@"image" ];
    
    
}

-(void)setImagePrefix:(NSDictionary *)dic{
    
    
}
-(void)uploadPrefix:(NSString *)url
{
    _profile=url;
}


@end
