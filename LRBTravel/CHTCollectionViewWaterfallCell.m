//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"

@implementation CHTCollectionViewWaterfallCell


#pragma mark - Accessors
- (UILabel *)displayLabel {
  if (!_displayLabel) {
    _displayLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    _displayLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _displayLabel.backgroundColor = [UIColor lightGrayColor];
    _displayLabel.textColor = [UIColor whiteColor];
    _displayLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _displayLabel;
}

- (void)setDisplayString:(NSString *)displayString {
  if (![_displayString isEqualToString:displayString]) {
    _displayString = [displayString copy];
    self.displayLabel.text = _displayString;
  }
}

#pragma mark - Life Cycle
- (void)dealloc {
  [_displayLabel removeFromSuperview];
  _displayLabel = nil;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

    _displayImageView = [[UIImageView alloc] init];
    // Scale with fill for contents when we resize.
    _displayImageView.contentMode = UIViewContentModeScaleAspectFill;

    // Scale the imageview to fit inside the contentView with the image centered:
    CGRect imageViewFrame = CGRectMake(0.f, 0.f, CGRectGetMaxX(self.contentView.bounds), CGRectGetMaxY(self.contentView.bounds));
    _displayImageView.frame = imageViewFrame;
    _displayImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _displayImageView.clipsToBounds = YES;
    [self.contentView addSubview:_displayImageView];
  }
  return self;
}

-(void)setupCellWithDic:(NSDictionary *)dic{
    
    [_displayImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"share_image"]]]];
    self.displayLabel.text = dic[@"share_title"];
    
}

@end
