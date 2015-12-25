//
//  ViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
//    _bgImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 160, 460+88)];
//    _bgImageView1.backgroundColor = [UIColor clearColor];
//    _bgImageView1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading_01" ofType:@"png"]];
//    [self.view addSubview:_bgImageView1];
//    _bgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(160, -20, 160, 460+88)];
//    _bgImageView2.backgroundColor = [UIColor clearColor];
//    _bgImageView2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading_02" ofType:@"png"]];
//    [self.view addSubview:_bgImageView2];
//    
//    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 400, 20, 20)];
//    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//    _activityIndicatorView.hidesWhenStopped = YES;
//    [_activityIndicatorView startAnimating];
//    [self.view addSubview:_activityIndicatorView];
    
    [self performSelector:@selector(loadingDone) withObject:nil afterDelay:0.0];    // 假设加载3秒中
    
    [super viewDidLoad];
}

- (void)loadingDone
{
   // [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [(AppDelegate *)[UIApplication sharedApplication].delegate loadingViewAnimation];
    //[_activityIndicatorView stopAnimating];
}

@end
