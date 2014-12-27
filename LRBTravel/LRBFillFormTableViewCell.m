//
//  LRBFillFormTableViewCell.m
//  LRBTravel
//
//  Created by mq on 14/11/9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFillFormTableViewCell.h"

@implementation LRBFillFormTableViewCell

- (void)awakeFromNib {
    
    _textField.layer.borderWidth = 0.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didEditing:(id)sender {
    [self.delegate changeText:self];
}
@end
