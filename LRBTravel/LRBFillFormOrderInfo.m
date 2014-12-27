//
//  LRBFillFormOrderInfo.m
//  LRBTravel
//
//  Created by LiuZhiqi on 14-12-27.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFillFormOrderInfo.h"

@implementation LRBFillFormOrderInfo
-(void)setInfo:(NSString *)info at:(NSUInteger)idx
{
    switch (idx) {
        case 0:
            _data=info;
            break;
        case 1:
            _numPerson=info;
            break;
        case 2:
            _price=info;
            break;
        default:
            break;
    }
}
-(NSString *)InfoAt:(NSUInteger)idx
{
    switch (idx) {
        case 0:
            return _data;
        case 1:
            return _numPerson ;
        case 2:
            return _price ;
        default:
            break;
    }
    return nil;
}@end
