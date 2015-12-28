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
    
    //此为找到plist文件中得版本号suo'dui所对应的键
    
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 1.从plist中取出版本号
    
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 2.从沙盒中取出上次存储的版本号
    
    NSString *saveVersion = [[NSUserDefaults  standardUserDefaults] objectForKey:key];
    NSLog(@"%@",saveVersion);
    if([saveVersion  isEqualToString:version]) {
        
        //不是第一次使用这个版本
        
        //不显示状态
        
    }else{
        
        //版本号不一样：第一次使用新版本
        
        //将新版本号写入沙盒
        //   [DatabaseTool createTable];
        [[NSUserDefaults  standardUserDefaults] setObject:version forKey:key];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"passwd"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"number"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"automaticLogin"];
        [[NSUserDefaults  standardUserDefaults] setObject:@"NO" forKey:@"login"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"uploadPicture"];
        [[NSUserDefaults  standardUserDefaults] setObject:@"昵称" forKey:@"nickName"];

        
    }

    
    
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
