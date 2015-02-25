//
//  LRBCommentListTableViewCell.m
//  LRBTravel
//
//  Created by Macintosh on 15-2-25.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBCommentListTableViewCell.h"
#import "UIImageView+Circle.h"

@implementation LRBCommentListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    NSLog(@"awakeFromNib");
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)initWithTableView:(UITableView*)tableView cellData:(NSDictionary*)data{
    LRBCommentListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LRBCommentListTableViewCell"];

    
    NSString *text = [data objectForKey:@"content"];

    CGSize constraint = CGSizeMake(cell.label_comment.frame.size.width, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame=cell.label_comment.frame;
    cell.label_comment.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height+10);
    
    frame= cell.label_comment.frame;
    
    
    frame=cell.frame;
    cell.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+ size.height);
    
    cell.label_comment.text=[data objectForKey:@"content"];

    
    cell.label_userName.text=[data objectForKey:@"userName"];
    cell.label_time.text=[data objectForKey:@"update_time"];
    [cell.imageView_head setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[data objectForKey:@"userImage"]]]];
    [cell.imageView_head drawCircleImage];
    return cell;
    
    
}


@end
