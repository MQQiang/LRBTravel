//
//  LRBBannerPathModel.m
//  LRBTravel
//
//  Created by mq on 14/12/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBBannerPathModel.h"

@implementation LRBBannerPathModel


-(void)setModelWithDic:(NSDictionary *)dic{
    
    _pathId = [dic objectForKey:@"path_id"];
    _image = [[LRBUtil imageProfix] stringByAppendingString:[dic objectForKey:@"image"]];
    
}
@end
