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


@end
