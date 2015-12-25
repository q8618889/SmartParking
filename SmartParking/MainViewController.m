//
//  MainViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopNav];

}
-(void)createTopNav
{
    
    

    
    
    _imageBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, RECT_W, 64)];
    _imageBG.userInteractionEnabled = YES;
    _imageBG.backgroundColor = [UIColor colorWithRed:10/255.0 green:74/255.0 blue:146/255.0 alpha:1];
    [self.view addSubview:_imageBG];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, RECT_W, 25)];
    _titleLabel.textColor  = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_imageBG addSubview:_titleLabel];
    
    _NAVImagae = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, RECT_W-40, 40)];
    _NAVImagae.userInteractionEnabled = YES;
    [self.view addSubview:_NAVImagae];
    
    
    _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0,15, 50,50)];
    [_backButton setImage:[UIImage imageNamed:@"backButton"] forState:0];
    [_backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    _backButton.hidden = YES;
    [self.view addSubview:_backButton];
    
    
    _logoimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 40, 30)];
    _logoimage.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_logoimage];
    
    //    标题
    _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(_logoimage.frame.size.width+_logoimage.frame.origin.x+5, 25, 130, 30)];
    _messageLabel.font = [UIFont systemFontOfSize:23.0f];
    _messageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_messageLabel];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)backButton:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
