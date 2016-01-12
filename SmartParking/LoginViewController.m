//
//  LoginViewController.m
//  JiangDuStateTax
//
//  Created by MAXMFJ on 15/11/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "LoginViewController.h"
#import "UserLoginBody.h"
@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
     self.messageLabel.text = @"登录";
    self.logoimage.hidden = YES;
    self.backButton.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f / 255.0f green:234.0f / 255.0f blue:235.0f / 255.0f alpha:1];
    
    [[self.BgView layer]setCornerRadius:5.0];//圆角
    [[self.loginButton layer]setCornerRadius:4.0f];
    
    [self.rememberPasswords setImage:[UIImage imageNamed:@"btn_2_selected333"] forState:UIControlStateSelected];
    [self.automaticlogin setImage:[UIImage imageNamed:@"btn_2_selected333"] forState:UIControlStateSelected];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"rememberPasswords"] isEqualToString:@"YES"]) {
        _userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        _Password.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwd"];
        _rememberPasswords.selected = YES;
    }
  
    _automaticlogin.selected = YES;
    
    
    
}
-(void)animationTopic
{
    [UIView animateWithDuration:3 animations:^{
    }];
}

- (IBAction)LoginButton:(UIButton *)sender {
    [SVProgressHUD show];
    [ScNewWorking getLoginWithUserName:_userName.text Password:_Password.text block:^(NSMutableDictionary *dictionary, NSString *error) {
        if ([error isEqualToString:@"error"])
        {
            [SVProgressHUD dismissWithError:@"网络错误请稍后再试!"];
            return ;
        }
        if ([[dictionary objectForKey:@"message"]isEqualToString:@"password is incorrect"])
        {
            [SVProgressHUD dismissWithError:@"密码错误!"];
            return;
        }else if ([[dictionary objectForKey:@"message"]isEqualToString:@"no this user"])
        {
            [SVProgressHUD dismissWithError:@"账户不存在!"];
            return;
        }else if ([[dictionary objectForKey:@"message"]isEqualToString:@"login successfully"]){
            [SVProgressHUD dismissWithSuccess:@"登录成功!"];
            UserLoginBody * body = [[UserLoginBody alloc]initWithDictionary:[dictionary objectForKey:@"body"]];
            
            [[NSUserDefaults standardUserDefaults] setObject:body.userName forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:body.passwd forKey:@"passwd"];
            [[NSUserDefaults standardUserDefaults] setObject:body.number forKey:@"number"];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%0.f",body.bodyIdentifier] forKey:@"id"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"login"];
            [[NSUserDefaults standardUserDefaults] setObject:body.headerUri forKey:@"uploadPicture"];
            
            
            
            
            
            if (body.nickname == nil) {
                NSLog(@"nickNime == nill");
                [[NSUserDefaults  standardUserDefaults] setObject:@"昵称" forKey:@"nickName"];
            }else {
                [[NSUserDefaults standardUserDefaults] setObject:body.nickname forKey:@"nickName"];
            }
       
            if (_rememberPasswords.selected == NO)
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"rememberPasswords"];
            }else{
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"rememberPasswords"];
                
            }
            
            
            if (_automaticlogin.selected == NO)
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"automaticLogin"];
            }else{
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"automaticLogin"];
                
            }
            
            [self.delegate loginReloadData];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
   
    
    
}

#pragma mark- PassageChange
- (IBAction)rememberPasswords:(UIButton *)sender {
    if (sender.selected == YES)
    {
        sender.selected = NO;
    }else{

        sender.selected = YES;
    }
}
- (IBAction)automaticLogin:(UIButton *)sender {
    if (sender.selected == YES)
    {
        sender.selected = NO;
    }else{

        sender.selected = YES;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
