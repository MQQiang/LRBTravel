//
//  LRBLeaderinfoViewController.h
//  
//
//  Created by mq on 14/11/9.
//
//

#import <UIKit/UIKit.h>
#import "LRBJourneyViewController.h"


@interface LRBLeaderinfoViewController : UIViewController
- (IBAction)backtoForward:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
@property (strong, nonatomic) IBOutlet UILabel *titelLabel;
@property (assign,nonatomic) NSInteger leaderId;
@property (strong, nonatomic) IBOutlet UITableView *infoTableView;

@property (strong,nonatomic)NSString *dicArrayString;
@property (strong,nonatomic)NSMutableArray *dicArray;
@property (assign,nonatomic)NSInteger type;
@end
