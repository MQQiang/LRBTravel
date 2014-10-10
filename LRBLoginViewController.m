//
//  LRBLoginViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBLoginViewController.h"

@interface LRBLoginViewController ()

@end

@implementation LRBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(_headImage.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGAffineTransform transform =   CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0f, -1.0f));
    
    transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(0, _headImage.frame.size.height));
    
    CGContextConcatCTM(ctx, transform);
    
    CGContextBeginPath(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, _headImage.frame.size.width, _headImage.frame.size.height ));
    
    CGContextClip(ctx);
    
    CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, _headImage.frame.size.width, _headImage.frame.size.height), _headImage.image.CGImage);
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    _headImage.image = finalImage;
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
