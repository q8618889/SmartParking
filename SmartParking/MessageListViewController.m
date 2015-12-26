//
//  MessageListViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MessageListViewController.h"
#import "MassageTableViewCell.h"
#import "MapViewController.h"
@interface MessageListViewController ()<UITableViewDataSource,UITableViewDelegate,BMKLocationServiceDelegate,GTTabBarControllerDelegate>
{
    UITableView * _myTableView;
    BMKLocationService * _locService;
    NSInteger page;
    
    NSMutableArray * _dataArray;
    
    
    CGFloat  _userlatitude;
    CGFloat  _userlongitude;
    
}

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.messageLabel.text = @"动态信息";

    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor redColor];
    [self createView];
    [self getUserLoction];
    // Do any additional setup after loading the view.
}
-(void)createView
{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H-108) style:UITableViewStylePlain];
    _myTableView.delegate =self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 140;
    
    [self.view addSubview:_myTableView];
    
    [MyTool RefreshingWithTableView:_myTableView target:(UIView *)self];
    [_myTableView.header beginRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MassageTableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"MassageTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MassageTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NewsMessageBody * body = _dataArray[indexPath.row];
    cell.title.text =body.header;
    cell.infoMassage.text = body.content;
    cell.numberLook.text =body.date;
    [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",body.pictureUri]] placeholderImage:[UIImage imageNamed:@"bg_1"]];
    
    
    //  NSString * imgUrl = [NSString stringWithFormat:@"%@/jdgs_bks%@",MAXURL,obj.fileUrl];
   // [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.fileUrl]]placeholderImage:[UIImage imageNamed:@"newimgemoren.jpg"]];
    return cell;

}
-(void)createLocService
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
}
-(void)getDelegate
{
    
    [self createLocService];
    
    
    
    
}
-(void)getUserLoction;
{
    
    
    
    
    
    [self didUpdateBMKUserLocation:_locService.userLocation];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f,",_locService.userLocation.location.coordinate.latitude] forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f,",_locService.userLocation.location.coordinate.longitude] forKey:@"longitude"];
    
    
    
    //
    //    NSString * latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"];
    //    NSString * longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"];
    
    
    
    
    //    CLLocationCoordinate2D  clocation = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    [_myTableView.header beginRefreshing];
}
-(void)loadData
{
    page = 1;
    
    [self netWorking];
}
-(void)loadMoreData
{
    page++;
     [self netWorking];
}

-(void)netWorking
{
  
//    [ScNewWorking getNewMessageWithPageSize:[NSString stringWithFormat:@"%d",page] longitude:[NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.longitude] latitude:[NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.latitude] radius:@"20000.00000" block:^(NSMutableArray *array, NSString *error) {
//        if (page == 0)
//        {
//            [_myTableView.header endRefreshing];
//        }else{
//            [_myTableView.footer endRefreshing];
//        }
//    }];
    [ScNewWorking getNewMessageWithPageSize:page longitude:_locService.userLocation.location.coordinate.longitude latitude:_locService.userLocation.location.coordinate.latitude radius:20000.0001 block:^(NSMutableArray *array, NSString *error) {
       
        if ([error isEqualToString:@"error"])
        {
            if (page == 1)
            {
                [_myTableView.header endRefreshing];

            }else{
                [_myTableView.footer endRefreshing];

            }

            [SVProgressHUD show];
            [SVProgressHUD dismissWithError:@"网络错误请稍后再试!"];
            
            return ;
        }
        if (page == 1)
        {
            [_myTableView.header endRefreshing];
            
            
            NewsMessageBaseClass * bc = array[0];
            _dataArray = (NSMutableArray *)bc.body;
            [_myTableView reloadData];
            
            
            
        }else{
            [_myTableView.footer endRefreshing];
            
            NewsMessageBaseClass * bc = array[0];
            _dataArray = (NSMutableArray *)[_dataArray arrayByAddingObjectsFromArray:bc.body];
            [_myTableView reloadData];
        }
    }];
}
#pragma mark  用户位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;
{
    
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
