//
//  LRBLeaderinfoViewController.m
//  
//
//  Created by mq on 14/11/9.
//
//

#import "LRBLeaderinfoViewController.h"
#import "UIImage+ImageEffects.h"

@interface LRBLeaderinfoViewController ()

@end

@implementation LRBLeaderinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [LRBUtil drawCircleImage: self.bgImageView ];
//        [self.bgImageView.image applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
//    self.bgImageView.alpha = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    self.bgImageView.alpha = 1;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backtoForward:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
