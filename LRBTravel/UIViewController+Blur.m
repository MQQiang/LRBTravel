//
//  UIViewController.m
//  LRBTravel
//
//  Created by mq on 14/11/10.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "UIViewController+Blur.h"
#import "UIImage+ImageEffects.h"



@implementation UIViewController(Blur)

-(void)presentViewControllerWithBlur:(UIViewController *)controller blurRedius:(float)blurRedius tintColor:(UIColor *)tintColor saturationDeltaFactor:(float)saturationDeltaFactor{
    
    [self presentViewControllerWithBlur:controller blurRedius:blurRedius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor Completion:nil];

    
}
-(void)presentViewControllerWithBlur:(UIViewController *)controller blurRedius:(float)blurRedius tintColor:(UIColor *)tintColor saturationDeltaFactor:(float)saturationDeltaFactor Completion:(void (^)(void))complection{
    
    
    if (true) {
        
        UIImage *background = [UIImage new];
        
        if ([self isKindOfClass:[UITableViewController class]]) {
            
            UIView *viewToRender = [(UITableViewController *)self tableView];
            CGPoint contentOffset = [[(UITableViewController *)self tableView]contentOffset];
            
            UIGraphicsBeginImageContext(viewToRender.bounds.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, 0, -contentOffset.y);
            [viewToRender.layer renderInContext:context];
            background = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        } else {
            
            UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [self.view.layer renderInContext:context];
            background = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        switch ([[UIApplication sharedApplication]statusBarOrientation]) {
            case UIInterfaceOrientationPortrait:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationUp];
                break;
                
            case UIInterfaceOrientationPortraitUpsideDown:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationDown];
                break;
                
            case UIInterfaceOrientationLandscapeLeft:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationLeft];
                break;
                
            case UIInterfaceOrientationLandscapeRight:
                background = [UIImage imageWithCGImage:background.CGImage scale:1 orientation:UIImageOrientationRight];
                break;
                
            default:
                break;
        }
        
        UIImageView *blurredBackground = [[UIImageView alloc]initWithImage:[background applyBlurWithRadius:blurRedius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:nil]];
        
        CGRect backgroundRect = [self.view convertRect:self.view.window.bounds fromView:Nil];
        
        if (controller.modalTransitionStyle == UIModalTransitionStyleCoverVertical) {
            blurredBackground.frame = CGRectMake(0, -backgroundRect.size.width, backgroundRect.size.width, backgroundRect.size.height);
        } else {
            blurredBackground.frame = CGRectMake(0, 0, backgroundRect.size.width, backgroundRect.size.height);
        }
        
        
        controller.view.backgroundColor = [UIColor clearColor];
        
        if ([controller isKindOfClass:[UITableViewController class]]) {
            [[(UITableViewController *)controller tableView]setBackgroundView:blurredBackground];
        } else {
            [controller.view addSubview:blurredBackground];
            [controller.view sendSubviewToBack:blurredBackground];
        }
        
        [self presentViewController:controller animated:YES completion:complection];
        
        [controller.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
            [UIView animateWithDuration:[context transitionDuration] animations:^{
                blurredBackground.frame = CGRectMake(0, 0, backgroundRect.size.width, backgroundRect.size.height);
            }];
        } completion:nil];
    } else {
        
        UIVisualEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
        
        blurView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [controller.view insertSubview:blurView atIndex:0];
        
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [blurView.superview addConstraint:[NSLayoutConstraint constraintWithItem:blurView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blurView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        controller.view.backgroundColor = [UIColor clearColor];
        controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
        [self presentViewController:controller animated:YES completion:^{
            if (!complection) {
                
                 complection;
            }
           
        }];
        
        [controller.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
        } completion:nil];
    }
}

@end
