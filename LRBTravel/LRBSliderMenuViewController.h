//
//  LRBSliderMenuViewController.h
//  
//
//  Created by mq on 14/11/7.
//
//

#import <UIKit/UIKit.h>

@interface LRBSliderMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UILabel *userMessageCountLabel;

@end
