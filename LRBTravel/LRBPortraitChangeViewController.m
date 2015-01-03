//
//  LRBPortraitChangeViewController.m
//  LRBTravel
//
//  Created by LiuZhiqi on 15-1-3.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBPortraitChangeViewController.h"
#import "LRBUserInfo.h"
@interface LRBPortraitChangeViewController ()

@end

@implementation LRBPortraitChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self updateImageView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - 相册文件选取相关



// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}


// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
        
    }];
    return result;
}

// 检查摄像头是否支持录像
- (BOOL) doesCameraSupportShootingVideos{
    return [self cameraSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

// 检查摄像头是否支持拍照
- (BOOL) doesCameraSupportTakingPhotos{
    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}

// 是否可以在相册中选择视频
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self cameraSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

// 是否可以在相册中选择视频
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}


#pragma mark - actionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            if ([self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary]){
                [mediaTypes addObject:( NSString *)kUTTypeImage];
            }
            if ([self canUserPickVideosFromPhotoLibrary]){
                [mediaTypes addObject:( NSString *)kUTTypeMovie];
            }
    
            [controller setMediaTypes:mediaTypes];
            [controller setDelegate:self];// 设置代理
            [self.navigationController presentModalViewController:controller animated:YES];
            
        }
}




#pragma mark - UIImagePickerControllerDelegate 代理方法


// 保存图片后到相册后，调用的相关方法，查看是否保存成功
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}
// 当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@", info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image=nil;
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        image = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
        }
        image=[self reSizeImage:image toSize:self.imageView.frame.size];
        //self.imageView.image=self.image;
        [self sharePic:image];
        
        //self.scrollView.contentSize=CGSizeMake(self.bottomView.frame.origin.x+self.bottomView.frame.size.width, self.bottomView.frame.origin.y+self.bottomView.frame.size.height);
        // 保存图片到相册中
        
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        NSLog(@"禁止视频加载");
        
        
    }
    
    
    //[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}



// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 相片选取具体实现

- (IBAction)changeImage:(id)sender {
    
    
    UIActionSheet *chageImageSheet=[[UIActionSheet alloc] initWithTitle:@"更改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
    chageImageSheet.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    chageImageSheet.frame=CGRectMake(0, 0, 200, 200);
    
    [chageImageSheet showInView:self.view];
    
}


-(void)updateImageView
{
        if ([LRBUserInfo shareUserInfo].profile !=nil)
    [self.imageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[LRBUserInfo shareUserInfo].profile ]]];
    
    UIImage *text=self.imageView.image;
    CGSize testSize=text.size;

}


-(void)failUpload:(NSString*)message
{
    UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}
-(void)updateImageWithUrl:(NSString*)imageURL
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //  NSLog(@"aaa=%@",[[LRBUserInfo shareUserInfo].userId ]);
    NSDictionary *parameters = @{@"type":@"updateImage",@"id":[LRBUserInfo shareUserInfo].userId,@"image":imageURL};
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
 
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result=responseObject;
        //NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding  ];
        NSLog(@"%@",responseObject);
        if ([[result objectForKey:@"status"] isEqualToNumber:[NSNumber numberWithLong:1]]) {
           
            
             [[LRBUserInfo shareUserInfo] uploadPrefix: imageURL];
            [self updateImageView];
            
            
            
        }else
        {
           [self failUpload:@"user info error"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self failUpload:@"requeset error"];
        NSLog(@"Error: %@", error);
           }];
   

}

-(void)sharePic:(UIImage*)image
{
    NSDictionary *dic =@{};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    CGSize size= image.size;
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager POST:[kHTTPServerAddress stringByAppendingString:@"php/api/ImageApi.php"] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
         [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1) name:@"image" fileName:@"test.jpg" mimeType:@"image/jpg"];
         
     }success:^(AFHTTPRequestOperation *operation,id responseObject) {
         
         
         NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding  ];
         NSError * error;
         NSDictionary *result = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding]  options: NSJSONReadingMutableContainers  error: &error];
         NSLog(@"%@",result);
         
         [ self updateImageWithUrl:[result objectForKey:@"pic_path"]];
       
         
         NSLog(@"%@",result);
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
         
         NSLog(@"%ld  %@",(long)error.code,error.domain);
         
     }];
    
    
}







#pragma mark - 工具方法

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}


@end
