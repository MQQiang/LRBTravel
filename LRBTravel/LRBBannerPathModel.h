//
//  LRBBannerPathModel.h
//  LRBTravel
//
//  Created by mq on 14/12/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRBBannerPathModel : NSObject

@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSNumber *pathId;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *updateTime;
-(void)setModelWithDic:(NSDictionary *)dic;

@end
