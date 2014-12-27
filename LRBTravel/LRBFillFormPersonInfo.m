//
//  LRBFillFormPersonInfo.m
//  LRBTravel
//
//  Created by LiuZhiqi on 14-12-26.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFillFormPersonInfo.h"

@implementation LRBFillFormPersonInfo
-(void)setInfo:(NSString *)info at:(NSUInteger)idx
{
    switch (idx) {
        case 0:
            _userName=info;
            break;
        case 1:
            _phoneNumber=info;
            break;
        case 2:
            _email=info;
            break;
        default:
            break;
    }
}
-(NSString *)InfoAt:(NSUInteger)idx
{
    switch (idx) {
        case 0:
           return _userName;
        case 1:
            return _phoneNumber ;
        case 2:
            return _email ;
        default:
            break;
    }
    return nil;
}
@end
