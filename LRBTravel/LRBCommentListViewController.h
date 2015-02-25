//
//  LRBCommentListViewController.h
//  LRBTravel
//
//  Created by Macintosh on 15-2-24.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBCommentListViewController : UIViewController
@property(assign,nonatomic)NSString *shareId;
@property(strong,nonatomic)NSDictionary *shareData;
@property(strong,nonatomic)NSArray *data_Comments;
@property(strong,nonatomic)UIImage * imageShared;

@property (weak, nonatomic) IBOutlet UITableView *tableView_comments;

@end
