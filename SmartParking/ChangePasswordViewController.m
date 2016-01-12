//
//  ChangePasswordViewController.m
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "MyMesaageViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoimage.hidden = YES;
    self.backButton.hidden = NO;
     self.messageLabel.text = @"修改密码";
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f / 255.0f green:234.0f / 255.0f blue:235.0f / 255.0f alpha:1];
}

- (IBAction)saveBtn:(id)sender {
    
    [SVProgressHUD show];

    if (![self.yanZhengMa.text isEqualToString:self.pooView.changeString]) {
        [SVProgressHUD dismissWithError:@"验证码错误"];
        return;
    }
    if (![_onePassword.text isEqualToString:_resumeLoad.text]) {
        [SVProgressHUD dismissWithError:@"两次密码不一致"];
        return;
    }
    if (![_password.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwd"]]) {
        [SVProgressHUD dismissWithError:@"旧密码错误!"];
        return;
    }
    [ScNewWorking getuserChangePasswordUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] NewPassword:_onePassword.text Number:_resumeLoad.text block:^(NSMutableDictionary *dictionary, NSString *error) {
        if ([error isEqualToString:@"error"])
        {
            [SVProgressHUD dismissWithError:@"网络错误请稍后再试!"];
            return ;
        }else{
            [SVProgressHUD dismissWithSuccess:@"修改成功请重新登陆!"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"login"];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
    }];
    
    
    
}
@end
