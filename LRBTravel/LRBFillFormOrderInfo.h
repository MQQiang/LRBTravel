//
//  LRBFillFormOrderInfo.h
//  LRBTravel
//
//  Created by LiuZhiqi on 14-12-27.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRBFillFormOrderInfo : NSObject
@property (nonatomic,strong)NSString * data;
@property (nonatomic,strong)NSString *numPerson;
@property (nonatomic,strong)NSString *price;
-(void)setInfo:(NSString *)info at:(NSUInteger)idx;
-(NSString *)InfoAt:(NSUInteger)idx;
@end
