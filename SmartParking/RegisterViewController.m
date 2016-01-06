//
//  RegisterViewController.m
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoimage.hidden = YES;
     self.messageLabel.text = @"注册";
    self.backButton.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f / 255.0f green:234.0f / 255.0f blue:235.0f / 255.0f alpha:1];
    [[self.bgView layer]setCornerRadius:5.0];//圆角
    [[self.zhuCe layer]setCornerRadius:4.0f];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registButton:(id)sender {
    
    if ([_telephoneTfd.text isEqualToString:@""]||[_passworldTfd.text isEqualToString:@""]||[_telephoneTfd.text isEqualToString:@""]) {
        UIAlertView *aleat = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                       message:@"手机号/密码/用户名  不能为空!"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
        [aleat show];
    }else {
        [SVProgressHUD show];
        [ScNewWorking getRegistWithUserName:_telephoneTfd.text Password:_passworldTfd.text Number:_telephoneTfd.text block:^(NSMutableDictionary *dictionary, NSString *error) {
            if ([error isEqualToString:@"error"])
            {
                [SVProgressHUD dismissWithError:@"网络错误请稍后再试!"];
                return ;
            }else if ([[dictionary objectForKey:@"message"] isEqualToString:@"user exists"]){
                
                 [SVProgressHUD dismissWithError:@"用户已存在!"];
            }else if ([[dictionary objectForKey:@"message"] isEqualToString:@"register success"]){
            [SVProgressHUD dismissWithSuccess:@"注册成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }
    
    
    
}
@end
