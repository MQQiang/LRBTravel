//
//  PathDetailTableViewCell.h
//  LRBTravel
//
//  Created by mq on 15/1/13.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
-(void)setupCellWithDic:(NSDictionary *)dic Type:(NSInteger)type;
@end
