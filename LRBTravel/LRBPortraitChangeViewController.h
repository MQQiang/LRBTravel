//
//  LRBPortraitChangeViewController.h
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-3.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBPortraitChangeViewController : UIViewController<UIActionSheetDelegate>
@property (strong,nonatomic)UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)changeImage:(id)sender;
@end
