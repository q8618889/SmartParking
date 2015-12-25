//
//  AppDelegate.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "GTTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate, GTTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ViewController *loadingViewController;
@property (nonatomic, strong) GTTabBarController *mainTabBarController;

- (void)loadMainView;
- (void)loadingViewAnimation;
@end

