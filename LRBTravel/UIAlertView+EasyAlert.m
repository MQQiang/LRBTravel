//
//  UIAlertView+EasyAlert.m
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-3.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "UIAlertView+EasyAlert.h"

@implementation UIAlertView(EasyAlert)

-(void)alertInfoWithTitle:(NSString*)string message:(NSString*)message
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:string message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}



@end
