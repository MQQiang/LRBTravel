//
//  LRBSearchViewController.h
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBSearchViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
- (IBAction)hotPathButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *hotTagView;
@property (strong, nonatomic) IBOutlet UITableView *resultTableView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *hotPathButtons;
@end
