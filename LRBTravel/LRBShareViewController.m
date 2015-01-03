//
//  LRBShareViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBShareViewController.h"
#define MAXTEXTINPUT 120
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "LRBUserInfo.h"



@interface LRBShareViewController ()
{
    
    int responderId;

}
@end

@implementation LRBShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sharePic:)];
    self.descriptionField.delegate=self;
    self.imageTitle.delegate=self;
    
    
    self.imageView=[[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    // Do any additional setup after loading the view from its nib.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    responderId=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//
//- (void)keyboardWillChangeFrame:(NSNotification *)note
//{
//    // 设置窗口的颜色
// //  self.view.window.backgroundColor = self.tableView.backgroundColor;
//    
//    if (responderId) {
//        
//    NSLog(@"%@",note);
//    // 0.取出键盘动画的时间
//    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    // 1.取得键盘最后的frame
//    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    //CGRect keyboardOriginFrame = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    if (keyboardFrame.size.width==0) {
//            return;
//    }
//    // 2.计算控制器的view需要平移的距离
//    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
//    
//    // 3.执行动画
//    [UIView animateWithDuration:duration animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
//    }];
//        
//    }
//}




//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
}





//(TextView) 当键盘开始输入前。时行计算与动画加载
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    NSLog(@"gegin animation");
//  //  sendMsgTextView =textView;
//  //  resultCommunityTableview.frame = CGRectMake(0, 36, 320, 150);
//    //动画加载
// //   [self begainMoveUpAnimation:0.0 ];
//    
//}

//
////关闭键盘(TextView) 换行时。隐藏键盘
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//  //  resultCommunityTableview.frame = CGRectMake(0, 36, 320, 376);
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
//






-(void)sharePicWithURL:(NSString*) imageURL{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //  NSLog(@"aaa=%@",[[LRBUserInfo shareUserInfo].userId ]);
    NSDictionary *parameters = @{@"type":@"postShare",@"user_id":[LRBUserInfo shareUserInfo].userId,@"title":self.imageTitle.text,@"content":self.descriptionField.text,@"image":imageURL};
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/ShareApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result=responseObject;
        if ([result objectForKey:@"status"]) {
            [self alertInfoWithTitle:@"上传成功" message:nil ];
        }else
            [self alertInfoWithTitle:@"上传失败" message:@"用户信息错误" ];
        
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self alertInfoWithTitle:@"上传失败" message:@"网络问题" ];
        
        NSLog(@"Error: %@", error);
        
    }];

}

-(void)sharePic:(id)sender
{
    NSDictionary *dic =@{};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];

   manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [manager POST:[kHTTPServerAddress stringByAppendingString:@"php/api/ImageApi.php"] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(_image, 0.05) name:@"image" fileName:@"test.jpg" mimeType:@"image/jpg"];
        
    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
        

        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSASCIIStringEncoding  ];
        NSError * error;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding]  options: NSJSONReadingMutableContainers  error: &error];
                NSLog(@"%@",result);
       [ self sharePicWithURL:[result objectForKey:@"pic_path"]];
        
        NSLog(@"%@",result);
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        
        NSLog(@"%ld  %@",(long)error.code,error.domain);
        
    }];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

#pragma mark - 相册文件选取相关
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


- (IBAction)UploadImg:(id)sender {
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

        
    }}


-(CGSize)getImageViewSizeFrom:(UIImage*)initImage maxSize:(CGSize)maxSize
{
#warning 两个都大于而且巨长。。会导致按钮超出边框
    if (initImage.size.height<maxSize.height&&initImage.size.width<maxSize.width) {
        return initImage.size;
    }
    else if(initImage.size.width>maxSize.width)
        return CGSizeMake(maxSize.width, maxSize.width*initImage.size.height/initImage.size.width);
    else{
        return CGSizeMake(initImage.size.width * maxSize.height/initImage.size.height, maxSize.height);
    
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
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        _image = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            _image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            _image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
        }
        self.imageView.image=self.image;
        
        CGSize frameSize=[self getImageViewSizeFrom:_image maxSize:CGSizeMake(self.imageTitle.frame.size.width, 300.0f)];
        NSLog(@"%f,%f",frameSize.width,frameSize.height);
        
        self.imageView.frame=CGRectMake(self.uploadBtm.frame.origin.x,self.uploadBtm.frame.origin.y+self.uploadBtm.frame.size.height+10.0f, frameSize.width, frameSize.height);
        self.imageView.backgroundColor=[UIColor blackColor];
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        CGRect tframe= self.bottomView.frame;
        tframe.origin.y= self.imageView.frame.origin.y+ self.imageView.frame.size.height+10.0f;
        self.bottomView.frame=tframe;
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

//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    responderId=1;
//    [textView becomeFirstResponder];	
//
//
//}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    responderId=1;
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillChangeFrameNotification object:self];    //[self.descriptionField becomeFirstResponder];
    
        [UIView animateWithDuration:0.5 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -90);
        }];
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{

    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
//    [textView resignFirstResponder];
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillChangeFrameNotification object:self];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    responderId=0;
    return YES;
}
//

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
     NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (toBeString.length<=120) {
        self.wordCountLable.text=[NSString stringWithFormat:@"字数：%lu/120",(unsigned long)toBeString.length];
        return YES;
    }else return NO;
    

}


-(void)alertInfoWithTitle:(NSString*)string message:(NSString*)message
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:string message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}



@end
