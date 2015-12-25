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
    
}

@end
 
@implementation MyMesaageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RECT_W, RECT_H / 4 - 20 )];
    
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:topView.bounds];
    topImg.image = [UIImage imageNamed:@"bg_1@2x"];
    topImg.backgroundColor = [UIColor redColor];
    [topView addSubview:topImg];
    
    UITableView *myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H - 118)];
    myTab.delegate = self;
    myTab.rowHeight = 55;
    myTab.tableFooterView = [[UIView alloc] init];
    myTab.dataSource = self;
    [self.view addSubview:myTab];
    
    
    logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.frame = CGRectMake(25, topView.bounds.size.height / 2 - 15, 75, 30);
    logInBtn.backgroundColor = [UIColor blueColor];
    [logInBtn setTitle:@"登陆" forState:UIControlStateNormal];
    logInBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [logInBtn addTarget:self action:@selector(logInBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:logInBtn];
    
    regist = [UIButton buttonWithType:UIButtonTypeCustom];
    regist.frame = CGRectMake(120, topView.bounds.size.height / 2 - 15, 75, 30);
    regist.backgroundColor = [UIColor orangeColor];
    [regist setTitle:@"注册" forState:UIControlStateNormal];
    regist.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [regist addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:regist];
    
}

#pragma - mark UItableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return RECT_H / 4 - 20;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return topView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
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
        case 2:
            cell.titleLab.text = @"我的预约";
            cell.leftImg.image = [UIImage imageNamed:@"icon_3@2x"];
            break;
        case 3:
            cell.titleLab.text = @"意见反馈";
            cell.leftImg.image = [UIImage imageNamed:@"icon_4@2x"];
            break;
        case 4:
            cell.titleLab.text = @"版本升级(1.2.1)";
            cell.leftImg.image = [UIImage imageNamed:@"icon_5@2x"];
            break;
        case 5:
            cell.titleLab.text = @"关于我们";
            cell.leftImg.image = [UIImage imageNamed:@"icon_6@2x"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        InformationViewController *inf = [InformationViewController new];
        [self.navigationController pushViewController:inf animated:YES];
    }else if(indexPath.row == 1) {
        ChangePasswordViewController *cha = [ChangePasswordViewController new];
        [self.navigationController pushViewController:cha animated:YES];
    }else if(indexPath.row == 5) {
        AboutUsViewController *abo = [AboutUsViewController new];
        [self.navigationController pushViewController:abo animated:YES];
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
