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
    
    self.textField.delegate=self;
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didEditing:(id)sender {
    [self.delegate changeText:self];
}





#pragma mark - textViewDelegate



-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    UIScrollView* containView=self.superview.superview.superview;
    CGFloat moveDist=[self.delegate getLocationWithFrame:self.frame];
    if (containView.contentSize.height- containView.contentOffset.y<=containView.frame.size.height)
        moveDist=containView.contentSize.height-containView.frame.size.height;
    else{
        moveDist=containView.contentOffset.y+moveDist;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
//        self.superview.superview.transform = CGAffineTransformMakeTranslation(0, 0);
        [containView setContentOffset:CGPointMake(0, moveDist)];
        
        
    }];
    [textField resignFirstResponder];
    //    [textView resignFirstResponder];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillChangeFrameNotification object:self];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIScrollView* containView=self.superview.superview.superview;
    CGFloat moveDist=[self.delegate getLocationWithFrame:self.frame];
    if (moveDist<0) {
        [UIView animateWithDuration:0.5 animations:^{
            [containView setContentOffset:CGPointMake(0, containView.contentOffset.y-moveDist)];
          //  self.superview.superview.transform = CGAffineTransformMakeTranslation(0, moveDist);
        }];
    }

    //    [textView resignFirstResponder];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillChangeFrameNotification object:self];
    //return YES;
    
}
//
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
    
    
}






@end
