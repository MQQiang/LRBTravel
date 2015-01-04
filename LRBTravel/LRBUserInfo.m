//
//  LRBUserInfo.m
//  LRBTravel
//
//  Created by mq on 14/11/16.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

@interface NSDictionary(usrinfo)
-(id)objectForKeyNotNSNULL:(id)aKey;


@end
@implementation NSDictionary(usrinfo)

-(id)objectForKeyNotNSNULL:(id)aKey
{
    id temp= [self objectForKey:aKey];
    if (temp==[NSNull null]) {
        temp=nil;
    }
    return temp;
    
}

@end


#import "LRBUserInfo.h"
@interface LRBUserInfo()


@property (nonatomic,strong)NSString * userName;
@property (nonatomic,strong)NSString *profile;
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
