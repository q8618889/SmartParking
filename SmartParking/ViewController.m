//
//  ViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
@interface ViewController ()<UINavigationControllerDelegate,UIAlertViewDelegate>
@property (nonatomic)Reachability * hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;
@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    
    

    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];

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
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
       // NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
        
        if (connectionRequired)
        {
            NSLog(@"蜂窝数据硬件不可用的！");
        }
        else
        {
            NSLog(@"蜂窝数据硬件可用的！");

        }
    }
    if (reachability == self.internetReachability)
    {
        [self otherNetWorking:reachability];
    }
    


}
-(void)otherNetWorking:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
     NSString* statusString = @"";
    switch (netStatus)
    {
        case NotReachable:        {
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            
            statusString =@"无网络状态";

            UIAlertView * notWorking = [[UIAlertView alloc]initWithTitle:@"网络提示" message:@"系统未检测到网络,会影响部分功能使用。" delegate:self cancelButtonTitle:@"设置" otherButtonTitles:@"取消", nil];
            notWorking.tag = 404;
            [notWorking show];
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            UIAlertView * WWANWorking = [[UIAlertView alloc]initWithTitle:@"网络提示" message:@"使用移动蜂窝数据网络，注意控制流量。" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [WWANWorking show];
            statusString =@"蜂窝数据";

            break;
        }
        case ReachableViaWiFi:        {
            NSLog(@"Reachable WiFi");
            break;
        }
    }
    
    if (connectionRequired)
    {
       // NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 404)
    {
        if (buttonIndex == 0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root"]];
        }
    }
  
}
- (void)loadingDone
{
   // [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [(AppDelegate *)[UIApplication sharedApplication].delegate loadingViewAnimation];
    //[_activityIndicatorView stopAnimating];
}

@end
