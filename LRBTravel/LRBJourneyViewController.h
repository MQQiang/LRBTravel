//
//  LRBJourneyViewController.h
//  
//
//  Created by mq on 14/11/8.
//
//

#import <UIKit/UIKit.h>

@interface LRBJourneyViewController : UIViewController

@property(nonatomic,assign) NSInteger journeyId;

@property (strong, nonatomic) IBOutlet UITextView *textField;

@property(nonatomic,copy)NSString *info;
- (IBAction)close:(id)sender;

@end
