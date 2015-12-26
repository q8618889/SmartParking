//
//  AppDelegate.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "AppDelegate.h"
#import "MyMesaageViewController.h"
#import "SurroundListViewController.h"
#import "MessageListViewController.h"
#import "SmartParkListViewController.h"
#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "BNCoreServices.h"
@interface AppDelegate ()<BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"DYC"];
    self.window.backgroundColor = [UIColor whiteColor];
    [self loadMainView];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"3ZdM0A2jkZ4UITtffoZIyGn5" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //初始化导航SDK
    [BNCoreServices_Instance initServices:@"3ZdM0A2jkZ4UITtffoZIyGn5"];
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil];
    
    self.loadingViewController = [[ViewController alloc] init];
    [self.mainTabBarController.view addSubview:self.loadingViewController.view];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark -
#pragma mark - Custom methods
- (void)loadMainView
{
    MessageListViewController *firstViewController = [[MessageListViewController alloc] init];
    UINavigationController *oneNavigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    oneNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    //oneNavigationController.navigationBar
    oneNavigationController.delegate = self;
    
    SmartParkListViewController *secondViewController = [[SmartParkListViewController alloc] init];
    UINavigationController *twoNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    twoNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    twoNavigationController.delegate = self;
    
    MapViewController *thirdViewController = [[MapViewController alloc]init];
    UINavigationController *threeNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
    threeNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    threeNavigationController.delegate = self;
    
    SurroundListViewController *fourthViewController= [[SurroundListViewController alloc] init];
    UINavigationController *fourNavigationController = [[UINavigationController alloc] initWithRootViewController:fourthViewController];
    fourNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    fourNavigationController.delegate = self;
    
    MyMesaageViewController *fifthViewController = [[MyMesaageViewController alloc] init];
    UINavigationController *fiveNavigationController = [[UINavigationController alloc] initWithRootViewController:fifthViewController];
    fiveNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    //fiveNavigationController.tabBarItem.title = @"one";
    fiveNavigationController.tabBarItem.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5" ofType:@"png"]];
    fiveNavigationController.delegate = self;    NSArray *ctrlArr = [NSArray arrayWithObjects:oneNavigationController,twoNavigationController,thirdViewController,fourNavigationController,fiveNavigationController,nil];
    
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic setObject:[UIImage imageNamed:@"home.png"] forKey:@"Default"];
    [imgDic setObject:[UIImage imageNamed:@"home.png"] forKey:@"Highlighted"];
    [imgDic setObject:[UIImage imageNamed:@"home-on.png"] forKey:@"Seleted"];
    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic2 setObject:[UIImage imageNamed:@"topic.png"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"topic.png"] forKey:@"Highlighted"];
    [imgDic2 setObject:[UIImage imageNamed:@"topic-on.png"] forKey:@"Seleted"];
    NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic3 setObject:[UIImage imageNamed:@"search.png"] forKey:@"Default"];
    [imgDic3 setObject:[UIImage imageNamed:@"search.png"] forKey:@"Highlighted"];
    [imgDic3 setObject:[UIImage imageNamed:@"search-on.png"] forKey:@"Seleted"];
    NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic4 setObject:[UIImage imageNamed:@"shoppping.png"] forKey:@"Default"];
    [imgDic4 setObject:[UIImage imageNamed:@"shoppping.png"] forKey:@"Highlighted"];
    [imgDic4 setObject:[UIImage imageNamed:@"shoppping-on.png"] forKey:@"Seleted"];
    NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic5 setObject:[UIImage imageNamed:@"my.png"] forKey:@"Default"];
    [imgDic5 setObject:[UIImage imageNamed:@"my.png"] forKey:@"Highlighted"];
    [imgDic5 setObject:[UIImage imageNamed:@"my-on.png"] forKey:@"Seleted"];
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,imgDic5,nil];
    
    self.mainTabBarController = [[GTTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
    [self.mainTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"bottom-bg.png"]];
    [self.mainTabBarController setTabBarTransparent:YES];
    self.mainTabBarController.delegate = self;
    self.mainTabBarController.animateDriect = 0;
    
    self.window.rootViewController = self.mainTabBarController;
    [fourthViewController getDelegate];
    [firstViewController getDelegate];
}

- (void)loadingViewAnimation {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loadingViewAnimationDone)];
    [UIView setAnimationDuration:0.5];
    self.loadingViewController.bgImageView1.frame = CGRectMake(self.loadingViewController.bgImageView1.frame.origin.x-160, self.loadingViewController.bgImageView1.frame.origin.y, self.loadingViewController.bgImageView1.frame.size.width, self.loadingViewController.bgImageView1.frame.size.height);
    self.loadingViewController.bgImageView2.frame = CGRectMake(self.loadingViewController.bgImageView2.frame.origin.x+160, self.loadingViewController.bgImageView2.frame.origin.y, self.loadingViewController.bgImageView2.frame.size.width, self.loadingViewController.bgImageView2.frame.size.height);
    [UIView commitAnimations];
}

- (void)loadingViewAnimationDone
{
    [self.loadingViewController.view removeFromSuperview];
    self.loadingViewController.view.alpha = 0;
}

#pragma mark NavigationDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.hidesBottomBarWhenPushed)
    {
        [self.mainTabBarController hidesTabBar:YES animated:YES];
    }
    else
    {
        [self.mainTabBarController hidesTabBar:NO animated:YES];
    }
}

#pragma mark -
#pragma mark GTTabBarControllerDelegate
- (BOOL)tabBarController:(GTTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(GTTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}
@end
