//
//  MyMesaageViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MyMesaageViewController.h"
#import "MyTabCell.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "InformationViewController.h"
#import "ChangePasswordViewController.h"
#import "AboutUsViewController.h"

@interface MyMesaageViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    UIView          *topView;
    UIButton        *logInBtn;
    UIButton        *regist;
    UITableView     *myTab;
    BOOL  automaticLogin;
    
}

@end
 
@implementation MyMesaageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"YES"]&&[[[NSUserDefaults standardUserDefaults]objectForKey:@"automaticLogin"]isEqualToString:@"YES"])
    {
        automaticLogin = YES;
        [myTab reloadData];

    }else{
        automaticLogin = NO;
        [myTab reloadData];

    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLabel.text = @"我的";
    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor whiteColor];
  
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H - 118)];
    myTab.delegate = self;
    myTab.rowHeight = 55;
    myTab.tableFooterView = [[UIView alloc] init];
    myTab.dataSource = self;
    [self.view addSubview:myTab];
    
    
  
    
}

#pragma - mark UItableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return RECT_H / 4 - 20;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RECT_W, RECT_H / 4 - 20 )];
    
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:topView.bounds];
    topImg.image = [UIImage imageNamed:@"bg_1@2x"];
    topImg.backgroundColor = [UIColor whiteColor];
    
    

    [topView addSubview:topImg];
    
    if (automaticLogin == YES)
    {
        
        UIButton * userhearder = [UIButton buttonWithType:UIButtonTypeCustom];
        userhearder.frame = CGRectMake(20 , 5, RECT_H / 4 - 50, RECT_H / 4 - 50);
        userhearder.backgroundColor = [UIColor redColor];
        [topView addSubview:userhearder];
        
        
        UILabel * userName = [[UILabel alloc]initWithFrame:CGRectMake(userhearder.frame.origin.y+userhearder.frame.size.width+20, userhearder.frame.origin.y+20, RECT_W-userhearder.frame.size.width-30, 30)];
        userName.font = [UIFont systemFontOfSize:30.0f];
       // userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        userName.text  = @"昵   称";
        [topView addSubview:userName];
        
        UILabel * userPhone = [[UILabel alloc]initWithFrame:CGRectMake(userName.frame.origin.x, userName.frame.origin.y+40, RECT_W-userhearder.frame.size.width-30, 30)];
        userPhone.text = [NSString stringWithFormat:@"手机:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"number"]];
        userPhone.font = [UIFont systemFontOfSize:14.0f];
        [topView addSubview:userPhone];
        
        topImg.image = [UIImage imageNamed:@""];
                               
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, topImg.frame.size.height-10, RECT_W, 10)];
        view.backgroundColor = [UIColor lightGrayColor];
        [topImg addSubview:view];
                               
        
        
        return topView;
    }
    logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.layer.cornerRadius = 3;
    logInBtn.frame = CGRectMake(25, topView.bounds.size.height / 2 - 15, 75, 30);
    logInBtn.backgroundColor = [UIColor colorWithRed:10/255.0 green:74/255.0 blue:146/255.0 alpha:1];
    logInBtn.layer.shadowOffset = CGSizeMake(0, 3);
    logInBtn.layer.shadowColor = [UIColor whiteColor].CGColor;
    logInBtn.layer.shadowRadius = 20;
    logInBtn.layer.shadowOpacity = 0.9;
    [logInBtn setTitle:@"登陆" forState:UIControlStateNormal];
    logInBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [logInBtn addTarget:self action:@selector(logInBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:logInBtn];
    
    regist = [UIButton buttonWithType:UIButtonTypeCustom];
    regist.frame = CGRectMake(120, topView.bounds.size.height / 2 - 15, 75, 30);
    regist.backgroundColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:12/255.0 alpha:1];
    regist.layer.cornerRadius = 3;
    regist.layer.shadowOffset = CGSizeMake(0,3);
    regist.layer.shadowColor = [UIColor whiteColor].CGColor;
    regist.layer.shadowRadius = 20;
    regist.layer.shadowOpacity = 0.9;
    [regist setTitle:@"注册" forState:UIControlStateNormal];
    regist.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [regist addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:regist];
    return topView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"NO"]) {
        return 4;
    }
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTabCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCell"];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyTabCell" owner:nil options:nil]objectAtIndex:0];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.titleLab.text = @"基本信息";
            cell.leftImg.image = [UIImage imageNamed:@"icon_1@2x"];
            break;
        case 1:
            cell.titleLab.text = @"修改密码";
            cell.leftImg.image = [UIImage imageNamed:@"icon_2@2x"];
            break;
//        case 2:
//            cell.titleLab.text = @"我的预约";
//            cell.leftImg.image = [UIImage imageNamed:@"icon_3@2x"];
//            break;
        case 2:
            cell.titleLab.text = @"意见反馈";
            cell.leftImg.image = [UIImage imageNamed:@"icon_4@2x"];
            break;

        case 3:
            cell.titleLab.text = @"关于我们";
            cell.leftImg.image = [UIImage imageNamed:@"icon_6@2x"];
            break;
        case 4:
            cell.titleLab.text = @"退出登陆";
            cell.titleLab.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor colorWithRed:10/255.0 green:74/255.0 blue:146/255.0 alpha:1];
            cell.titleLab.font = [UIFont systemFontOfSize:16.0f];
            cell.titleLab.textAlignment = NSTextAlignmentCenter;
            cell.accessoryType=UITableViewCellAccessoryNone;

            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (automaticLogin == NO)
    {
        [self logInBtnClick:nil];
        return;
    }
    if (indexPath.row == 0) {
        InformationViewController *inf = [InformationViewController new];
        [self.navigationController pushViewController:inf animated:YES];
    }else if(indexPath.row == 1) {
        ChangePasswordViewController *cha = [ChangePasswordViewController new];
        [self.navigationController pushViewController:cha animated:YES];
    }else if(indexPath.row == 3) {
        AboutUsViewController *abo = [AboutUsViewController new];
        [self.navigationController pushViewController:abo animated:YES];
    }else if (indexPath.row == 4){
       
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"login"];
        automaticLogin = NO;
        [myTab reloadData];
    }
    
    
    
}

#pragma - mark Btn按钮代理方法
- (void)logInBtnClick:(UIButton *)log {
    
    LoginViewController *login = [LoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
    
    
}

- (void)registBtnClick:(UIButton *)reg {
    
    RegisterViewController *regis = [RegisterViewController new];
    [self.navigationController pushViewController:regis animated:YES];
    
    
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
