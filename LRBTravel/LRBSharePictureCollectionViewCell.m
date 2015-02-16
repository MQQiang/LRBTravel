//
//  LRBSharePictureCollectionViewCell.m
//  LRBTravel
//
//  Created by mq on 14/12/28.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBSharePictureCollectionViewCell.h"
#import "LRBPhotoBrowserViewController.h"
#import "LRBUserInfo.h"
#import "XHImageViewer.h"
@implementation LRBSharePictureCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
   [ self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
}

- (IBAction)upThisPicture:(id)sender {
    
     [self.upButton setEnabled:false];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"addShareFavor",@"share_id":_dataDic[@"share_id"],@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.upButton setImage:[UIImage imageNamed:@"like_r"] forState:UIControlStateNormal];
        //
        NSLog(@"%@",responseObject);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"点赞成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        [self.upButton setEnabled:false];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
    
}

-(void)setupCellWithDic:(NSDictionary *)dic superVc:(UIViewController *)vc{
    _superVC = vc;
    _dataDic = dic;
    
    [LRBUtil drawCircleImage:_headImage];
    _titleLabel.text = dic[@"share_title"];
    [_sharedPictureView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"share_image"]]]];
    
    _nameLabel.text = dic[@"user_name"];
    
    if ([dic objectForKeyNotNSNULL:@"user_image"]) {
        
            [_headImage setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:dic[@"user_image"]]]];
        
        //    NSLog(@"%@",[[LRBUtil imageProfix] stringByAppendingString:dic[@"user_image"]]);
        
    }
    if([dic objectForKeyNotNSNULL:@"collect_num"]){
    
        _upNumLabel.text = dic[@"collect_num"] ;
    }


    
    NSLog(@"%f",self.bounds.size.height);
    [self setNeedsDisplay ];
}
-(void)panGestureRecognized:(id)sender{
    
    // Create array of MWPhoto objects
    self.photos = [NSMutableArray array];
    LRBPhotoBrowserViewController *pushView=[[LRBPhotoBrowserViewController alloc] init];
   
    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:_dataDic[@"share_image"]]]];
    photo.caption = _dataDic[@"share_title"];
    
     [_photos addObject:photo];
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
//    browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:0];
    
    // Present
    self.superVC.navigationController.navigationBar.tintColor=[UIColor blackColor];

    [self.superVC.navigationController pushViewController:pushView animated:YES];
    
    // Manipulate
//    [browser showNextPhotoAnimated:YES];
//    [browser showPreviousPhotoAnimated:YES];
//    [browser setCurrentPhotoIndex:10];
    
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
    // Do your thing!
    
   UIActionSheet *sheet =[ [UIActionSheet alloc] initWithTitle:@"详情" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"评论" otherButtonTitles:@"分享", nil];
    [sheet showFromBarButtonItem:photoBrowser.actionButton animated:YES];
    
}

@end
