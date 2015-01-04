//
//  LRBAlterInfoView.h
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-1.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRBAlterInfoViewModel : NSObject
@property(nonatomic,copy) NSString* line1;
@property(nonatomic,copy) NSString* line2;
@property(nonatomic,assign) BOOL EnableLine1;
@property(nonatomic,copy)NSString* field1Text;
@property(nonatomic,copy)NSString* type;
-(instancetype)initWithType:(NSString*)type FirstLine:(NSString*)l1 secondline:(NSString *) l2 enableLine1:(BOOL) enable firstFieldText:(NSString*) f1t;

@end
