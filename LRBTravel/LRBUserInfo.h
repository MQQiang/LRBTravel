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
@property (nonatomic,strong,readonly)NSString * userName;
@property (nonatomic,strong,readonly)UIImage *profile;
@property (nonatomic,strong,readonly)NSString *nickName;
@property (nonatomic,strong,readonly)NSString *phoneNumber;
@property (nonatomic,strong,readonly)NSString *nickWeiXin;
@property (nonatomic,strong,readonly)NSString *nickWeiBo;
@property (nonatomic,strong,readonly)NSString *updateTime;
@property (nonatomic,strong,readonly)NSString *createTime;
@property (nonatomic,assign,readonly)NSUInteger cash;
@property (nonatomic,strong,readonly)NSString *selfDescription;
@property (nonatomic,strong,readonly)NSString *qqNumber;
@property (nonatomic,assign,readonly)NSUInteger userLevel;
@property (nonatomic,strong,readonly)NSString *email;
@property (nonatomic,strong,readonly)NSNumber *userId;
-(void)setupUserInfo:(NSDictionary *)indoDic;
-(void)setImagePrefix:(NSDictionary *)dic;

@end
