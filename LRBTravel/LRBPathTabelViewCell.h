//
//  LRBPathTabelViewCell.h
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LRBPathTabelViewCellType ) {
    
    TYPE_COLLECTION =0,
    TYPE_ORDER_CANCEL,
    TYPE_ORDER_PAYED,
    TYPE_ORDER_UNPAY

};



@interface LRBPathTabelViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *promptButton;
@property (strong, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (assign,nonatomic)LRBPathTabelViewCellType cellType;

-(void)setupTabelViewCellWith:(NSDictionary *)dic Type:(LRBPathTabelViewCellType) type;
- (IBAction)cancelCollect:(id)sender;

@property(nonatomic,strong)NSDictionary *selfDic;
@end
