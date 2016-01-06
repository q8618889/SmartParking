//
//  InformationViewController.m
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()<UITextFieldDelegate>

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoimage.hidden = YES;
     self.messageLabel.text = @"基本信息";
    self.backButton.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f / 255.0f green:234.0f / 255.0f blue:235.0f / 255.0f alpha:1];
    self.userName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    self.passWorld.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"passwd"];
    self.userName.userInteractionEnabled = NO;
    self.passWorld.userInteractionEnabled = NO;
    [self.nickName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.nickName) {
        if (textField.text.length > 8) {
            textField.text = [textField.text substringToIndex:8];
        }
    }
}

- (IBAction)sendNerWorking:(UIButton *)sender {
    
    [SVProgressHUD show];
    [ScNewWorking getUpdateUserUserName:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"] nickname:self.nickName.text block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        
        if ([error isEqualToString:@"error"])
        {
            [SVProgressHUD dismissWithError:@"网络错误请稍后再试!"];
            return ;
        }else{
            [SVProgressHUD dismissWithSuccess:@"修改成功!"];
            [[NSUserDefaults standardUserDefaults] setObject:self.nickName.text forKey:@"nickName"];
            return ;
        }
        
        
    }];
    
}
@end
