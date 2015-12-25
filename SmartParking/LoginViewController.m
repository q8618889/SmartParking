//
//  LoginViewController.m
//  JiangDuStateTax
//
//  Created by MAXMFJ on 15/11/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f / 255.0f green:234.0f / 255.0f blue:235.0f / 255.0f alpha:1];
    
    [[self.BgView layer]setCornerRadius:5.0];//圆角
    [[self.loginButton layer]setCornerRadius:4.0f];
    
}
-(void)animationTopic
{
    [UIView animateWithDuration:3 animations:^{
    }];
}

- (IBAction)LoginButton:(UIButton *)sender {
    
    [ScNewWorking getLoginWithUserName:_userName.text Password:_Password.text block:^(NSMutableArray *array, NSString *error) {
        
        
        
        
        
    }];
   
    
    
}
-(void)animationButton:(UIButton *)sender {
    
    
}
-(void)LoginMassage:(UIButton *)sender {
    
    
    
   
}
-(void)errorLogin:(UIButton *)sender {
    
    
    
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
