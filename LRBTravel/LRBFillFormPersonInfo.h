//
//  LRBFillFormPersonInfo.h
//  LRBTravel
//
//  Created by LiuZhiqi on 14-12-26.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRBFillFormPersonInfo : NSObject

@property (nonatomic,strong)NSString * userName;
@property (nonatomic,strong)NSString *phoneNumber;
@property (nonatomic,strong)NSString *email;
-(void)setInfo:(NSString *)info at:(NSUInteger)idx;
-(NSString *)InfoAt:(NSUInteger)idx;

@end
