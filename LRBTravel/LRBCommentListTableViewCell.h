//
//  LRBCommentListTableViewCell.h
//  LRBTravel
//
//  Created by Macintosh on 15-2-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBCommentListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView_head;
@property (weak, nonatomic) IBOutlet UILabel *label_userName;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_comment;
+(instancetype)initWithTableView:(UITableView*)tableView cellData:(NSDictionary*)data;
@end
