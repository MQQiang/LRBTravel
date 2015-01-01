//
//  LRBAlterInfoView.m
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBAlterInfoViewModel.h"

@implementation LRBAlterInfoViewModel


-(instancetype)initWithFirstLine:(NSString*)l1 secondline:(NSString *) l2 enableLine1:(BOOL) enable firstFieldText:(NSString*) f1t
{
   if(self=[super init])
   {
       
       self.line1=l1;
       self.line2=l2;
       self.EnableLine1=enable;
       self.field1Text=f1t;
   }
    return self;
}






@end
