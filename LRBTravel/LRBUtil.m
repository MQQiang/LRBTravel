//
//  LRBUtil.m
//  LRBTravel
//
//  Created by mq on 14/10/30.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBUtil.h"
#include "UIImageView+Circle.h"
@implementation LRBUtil

static NSString * imagePrefix;

+(void)drawCircleImage:(UIImageView *)imageView{

//    UIGraphicsBeginImageContext(imageView.frame.size);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGAffineTransform transform =   CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0f, -1.0f));
//    
//    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(0, imageView.frame.size.height));
//    
//    CGContextConcatCTM(ctx, transform);
//    
//    CGContextBeginPath(ctx);
//    
//    CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, imageView.frame.size.width, imageView.frame.size.height ));
//    
//    CGContextClip(ctx);
//    
//    CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, imageView.frame.size.width, imageView.frame.size.height), imageView.image.CGImage);
//    
//    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    imageView.image = finalImage;
    
    [imageView drawCircleImage];
    
}


+(void)makePhoneCall:(NSString *)phoneNumber{
    
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://15157181973"]];
    
    
       NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
    
    UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
  

    if ( !phoneCallWebView ) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的View 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    
}
+(UIImage *)fullScreenShots{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect size = CGRectMake(screenWindow.frame.origin.x, screenWindow.frame.origin.y+20, screenWindow.frame.size.width, screenWindow.frame.size.height-20);
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    return viewImage;
    
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

+(void)requestImagePrefix{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    NSDictionary *parameters = @{@"type":@"getImagePrefix"};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/OtherApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        
        imagePrefix = [dic objectForKey:@"prefix"];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

+(NSString *)imageProfix{
    return imagePrefix;
}

+(void)setImageProfix:(NSString *)profix{
    
    imagePrefix = profix;
    
     [[NSUserDefaults standardUserDefaults] setValue:[LRBUtil imageProfix] forKey:@"ImageProfix"];
}

+ (NSString*)intervalSinceNow:(NSString*)theDate
{
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d = [date dateFromString:theDate];
    NSTimeInterval late = [d timeIntervalSince1970] * 1;
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970] * 1;
    NSString *timeString = @"";
    NSTimeInterval cha = now-late;
    
    //发表在一小时之内
    if(cha / 3600 < 1) {
        if(cha / 60 < 1) {
            timeString = @"1";
        } else {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    
    //在一小时以上24小以内
    else if(cha / 3600 > 1 && cha / 86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    
    //发表在24以上10天以内
    else if(cha/86400>1&&cha/864000<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@天前", timeString];
    }
    
    //发表时间大于10天 显示几月-几号 eg：11-11
    else {
        //        timeString = [NSString stringWithFormat:@"%d-%"]
        NSArray*array = [theDate componentsSeparatedByString:@" "];
        //        return [array objectAtIndex:0];
        timeString = [array objectAtIndex:0];
        timeString = [timeString substringWithRange:NSMakeRange(5, [timeString length]-5)];
    }
    
    return timeString;
    
}


@end


@implementation NSDictionary(usrinfo)

-(id)objectForKeyNotNSNULL:(id)aKey
{
    id temp= [self objectForKey:aKey];
    if (temp==[NSNull null]) {
        temp=nil;
    }
    return temp;
    
}

@end