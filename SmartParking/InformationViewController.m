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
    [self.nickName addTarget:self action:@selector(textFiledEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.nickName.placeholder = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    
    NSString *toBeString = self.nickName.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self.nickName markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self.nickName positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 8) {
                self.nickName.text = [toBeString substringToIndex:8];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > 8) {
            self.nickName.text = [toBeString substringToIndex:8];
        }
    }
}

//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.nickName) {
//        if (textField.text.length > 12) {
//            textField.text = [textField.text substringToIndex:8];
//        }
//    }
//}

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
