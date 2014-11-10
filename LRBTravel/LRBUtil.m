//
//  LRBUtil.m
//  LRBTravel
//
//  Created by mq on 14/10/30.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBUtil.h"

@implementation LRBUtil


+(void)drawCircleImage:(UIImageView *)imageView{

    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGAffineTransform transform =   CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0f, -1.0f));
    
    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(0, imageView.frame.size.height));
    
    CGContextConcatCTM(ctx, transform);
    
    CGContextBeginPath(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, imageView.frame.size.width, imageView.frame.size.height ));
    
    CGContextClip(ctx);
    
    CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, imageView.frame.size.width, imageView.frame.size.height), imageView.image.CGImage);
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    imageView.image = finalImage;
    
}


+(void)makePhoneCall:(NSString *)phoneNumber{
    
    UIWebView *phoneCallWebView = [[UIWebView alloc] init];
  
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
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
@end
