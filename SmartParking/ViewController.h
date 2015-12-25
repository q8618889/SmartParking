//
//  ViewController.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTabBarController.h"
@interface ViewController : UIViewController
{
    UIActivityIndicatorView     *_activityIndicatorView;
}

@property (nonatomic, strong) GTTabBarController *mainTabBarController;


@property (nonatomic, strong)     UIImageView *bgImageView1;
@property (nonatomic, strong)     UIImageView *bgImageView2;
@end

