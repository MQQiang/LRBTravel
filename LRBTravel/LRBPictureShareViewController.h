//
//  LRBPictureShareViewController.h
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"

@interface LRBPictureShareViewController : LRBFirstLayerBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>

@property(nonatomic,strong) IBOutlet UICollectionView *collectionView;

@end
