//
//  LRBUserInfo.h
//  LRBTravel
//
//  Created by mq on 14/11/16.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRBUserInfo : NSObject

+(LRBUserInfo *)shareUserInfo;
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
-(void)setupUserInfo:(NSDictionary *)indoDic;
-(void)setImagePrefix:(NSDictionary *)dic;
#warning ?????????用户信息改变如何修改这保存都信息
-(void)uploadPrefix:(NSString *)url;
@end
