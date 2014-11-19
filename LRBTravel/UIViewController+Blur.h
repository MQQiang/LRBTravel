//
//  UIViewController.h
//  LRBTravel
//
//  Created by mq on 14/11/10.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Blur)


-(void)presentViewControllerWithBlur:(UIViewController *)controller blurRedius:(float)blurRedius tintColor:(UIColor *)tintColor saturationDeltaFactor:(float)saturationDeltaFactor;

-(void)presentViewControllerWithBlur:(UIViewController *)controller blurRedius:(float)blurRedius tintColor:(UIColor *)tintColor saturationDeltaFactor:(float)saturationDeltaFactor Completion:(void (^)(void))completion ;

@end
