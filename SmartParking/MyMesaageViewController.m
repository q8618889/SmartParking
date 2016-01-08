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
#import "SDWebImage/UIButton+WebCache.h"
#import "FeedbackViewController.h"

@interface MyMesaageViewController () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LoginDelegate> {
    
    UIView          *topView;
    UIButton        *logInBtn;
    UIButton        *regist;
    UITableView     *myTab;
    NSString        *nikeName;
    BOOL  automaticLogin;
    UIButton * userhearder;
    UIView          *cellView;
    UILabel * _userName;
    
}

@end
 
@implementation MyMesaageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      nikeName = [NSString stringWithFormat:@"%@",[[NSUserDefaults  standardUserDefaults]objectForKey:@"nickName"]];
    _userName.text = nikeName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"login"] isEqualToString:@"YES"]&&[[[NSUserDefaults standardUserDefaults]objectForKey:@"automaticLogin"]isEqualToString:@"YES"])
    {
        automaticLogin = YES;
        [myTab reloadData];
        
    }else{
        automaticLogin = NO;
        [myTab reloadData];
        
    }
  
    self.messageLabel.text = @"我的";
    self.logoimage.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor whiteColor];
  
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H - 118) style:UITableViewStylePlain];
    myTab.delegate = self;
    myTab.rowHeight = 55;
    myTab.tableFooterView = [[UIView alloc] init];
    myTab.dataSource = self;
    [self.view addSubview:myTab];
    
    cellView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, RECT_W - 20, 40)];
    cellView.backgroundColor = [UIColor colorWithRed:10/255.0 green:74/255.0 blue:146/255.0 alpha:1];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"退出";
    label.textColor = [UIColor whiteColor];
    label.frame = cellView.bounds;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [cellView addSubview:label];
    
    
  
    
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
        //上传头像按钮
        userhearder = [UIButton buttonWithType:UIButtonTypeCustom];
        userhearder.frame = CGRectMake(20 , 5, RECT_H / 4 - 50, RECT_H / 4 - 50);
        [userhearder addTarget:self action:@selector(userhearderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
          [userhearder sd_setBackgroundImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"uploadPicture"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"pic_1@2x.png"]];
        [topView addSubview:userhearder];
        
        
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(userhearder.frame.origin.y+userhearder.frame.size.width+20, userhearder.frame.origin.y+20, RECT_W-userhearder.frame.size.width-30, 30)];
        _userName.font = [UIFont systemFontOfSize:30.0f];
        _userName.text  = nikeName;
        [topView addSubview:_userName];
        
        UILabel * userPhone = [[UILabel alloc]initWithFrame:CGRectMake(_userName.frame.origin.x, _userName.frame.origin.y+40, RECT_W-userhearder.frame.size.width-30, 30)];
        userPhone.text = [NSString stringWithFormat:@"用户名:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"number"]];
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
    [logInBtn setTitle:@"登录" forState:UIControlStateNormal];
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
    
    
    if (automaticLogin == NO) {
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
        case 2:
            cell.titleLab.text = @"清除缓存";
            cell.leftImg.image = [UIImage imageNamed:@"icon_4@2x"];
            [SDImageCache sharedImageCache];
            cell.detalLab.text = [NSString stringWithFormat:@"%0.2fM",[self checkTmpSize]];
            NSLog(@"%f",[self checkTmpSize]);
            break;

        case 3:
            cell.titleLab.text = @"关于我们";
            cell.leftImg.image = [UIImage imageNamed:@"icon_6@2x"];
            break;
        case 4:
            [cell addSubview:cellView];
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
    }else if(indexPath.row == 2) {
        [self clearTmpPics:indexPath];
    }else if(indexPath.row == 3) {
        AboutUsViewController *abo = [AboutUsViewController new];
        [self.navigationController pushViewController:abo animated:YES];
    }else if (indexPath.row == 4){
       
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"login"];
        automaticLogin = NO;
        [myTab reloadData];
    }
    
    
    
}

#pragma - mark 清除图片缓存
- (CGFloat)checkTmpSize {
    float totalSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:[self dirCache]];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [[self dirCache] stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        unsigned long long length = [attrs fileSize];
        totalSize += length / 1024.0 / 1024.0;
    } // NSLog(@"tmp size is %.2f",totalSize);
    return totalSize;
}
//获取Cache目录/////
-(NSString *)dirCache{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    return cachePath;
}
- (void)clearTmpPics:(NSIndexPath *)index
{
    [[SDImageCache sharedImageCache]clearDisk] ;
    [self clearCache];
    [[SDImageCache sharedImageCache] clearMemory];//可有可无
    
    UIAlertView * alv = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"清理完成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alv show];
    MyTabCell * cell = [myTab cellForRowAtIndexPath:index];
    cell.detalLab.text = @"0.00M";
    
}
//清除缓存
- (void)clearCache
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                   });
}
-(void)loginReloadData;
{
    automaticLogin = YES;
    [myTab reloadData];
}
#pragma - mark Btn按钮代理方法
- (void)logInBtnClick:(UIButton *)log {
    
    LoginViewController *login = [LoginViewController new];
    login.delegate =self;
    [self.navigationController pushViewController:login animated:YES];
    
    
}

- (void)registBtnClick:(UIButton *)reg {
    
    RegisterViewController *regis = [RegisterViewController new];
    [self.navigationController pushViewController:regis animated:YES];
    
    
}
//上传头像
- (void)userhearderBtnClick:(UIButton *)sender {
    
    UIActionSheet *act=[[UIActionSheet alloc]initWithTitle:@"温馨提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册",nil];
    [act showInView:self.view];

    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    if (buttonIndex == 0)
    {
        [self PZButton];
    }
    if (buttonIndex == 1)
    {
        [self XCButton];
    }
}

-(void)PZButton
{
    GTTabBarController * gt =  (GTTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
   // gt.tabBarHidden = NO;
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    //    imagePicker.view.frame=s
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    if([[[UIDevice
          currentDevice] systemVersion] floatValue]>=8.0) {
        
        imagePicker.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    imagePicker.allowsEditing=YES;
    [gt presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
    
    
    
    
}
-(void)XCButton
{
    
   
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    //    imagePicker.view.frame=s
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.allowsEditing=YES;
    //    [self.view addSubview:imagePicker.view];
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self netWorkIng:nil Image:image];
    [userhearder setImage:image forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)netWorkIng:(UIImagePickerController *)pick Image:(UIImage *)image {
    
    [SVProgressHUD show];
    [NetWorking addNetWorkingAddImage:nil imageFile:image url:[NSString stringWithFormat:@"%@/park/upload",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        if ([error isEqualToString:@"error"])
        {
            [SVProgressHUD dismissWithError:@"失败请重试!"];
        }else{
            
            [SVProgressHUD dismissWithSuccess:@"上传完成"];
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            dict = [dictionary objectForKey:@"body"];
            NSMutableArray *body = [dict objectForKey:@"uri"];
            NSString *st = body[0];
            [[NSUserDefaults standardUserDefaults] setObject:st forKey:@"uploadPicture"];
            [myTab reloadData];
            
            NSLog(@" %@",st);
            
            [ScNewWorking getUpdateHeaderuriUserName:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"] nickname:@"" headeruri:st block:^(NSMutableDictionary *dictionary, NSString *error) {
                
            }];
            
        }
        
    }];

}

@end
