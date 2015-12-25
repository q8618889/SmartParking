//
//  SurroundListViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "SurroundListViewController.h"
#import "SurroundTableViewCell.h"
#import "MapViewController.h"
#import "SurrpundView.h"
#import "SearchSurroundViewController.h"
#import "InfoMessageViewController.h"
@interface SurroundListViewController ()<UITableViewDataSource,UITableViewDelegate,mapZBMessageDelegate,BMKPoiSearchDelegate,GTTabBarControllerDelegate,BMKLocationServiceDelegate>
{
    UITableView * _myTableView;
    BOOL       _isUserloction;
    BOOL       _isTopRef;
    
    BMKPoiSearch* _poisearch;
    BMKLocationService * _locService;
    BMKNearbySearchOption * _option;

    NSMutableArray *_annotations;
    
    
    NSInteger curPage;
    NSString *_userChange;
    
    
    
    CGFloat  _userlatitude;
    CGFloat  _userlongitude;
    

    
}

@end

@implementation SurroundListViewController
-(void)viewWillAppear:(BOOL)animated {

    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    _poisearch.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {


    [super viewDidLoad];
    if (_poisearch == nil) {
        _poisearch = [[BMKPoiSearch alloc]init];
        _poisearch.delegate  = self;
    }
    curPage =0;

   _userChange = @"美食";
   _option = [[BMKNearbySearchOption alloc]init];
    _annotations = [NSMutableArray array];


    self.messageLabel.text = @"周边业务";

    self.navigationController.navigationBarHidden = YES;


    self.view.backgroundColor = [UIColor whiteColor];
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H-118) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 70;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    
 
    [MyTool RefreshingWithTableView:_myTableView target:(UIView *)self];
    [_myTableView.header beginRefreshing];

    
    
    // Do any additional setup after loading the view.
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
//    创建的view  内容 包含按钮 和  滑动按钮位置
    SurrpundView * surrpund = [[[NSBundle mainBundle]loadNibNamed:@"SurrpundView" owner:nil options:nil]objectAtIndex:0];
    [surrpund.searchButton addTarget:self action:@selector(searchButton:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.eating  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.come  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.mrButton  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.market  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.spot  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.hotel  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.bank  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    [surrpund.supermarket  addTarget:self action:@selector(tools:) forControlEvents:BUTTONTOUCHUP];
    for (UIButton * btn in surrpund.myScrollView.buttonArrays)
    {
        [btn addTarget:self action:@selector(scrollViewSubbtnClick:) forControlEvents:BUTTONTOUCHUP];
    }
    
    return surrpund;
}
-(void)searchButton:(UIButton *)btn
{
    SurrpundView * surrpund = (SurrpundView *)[btn superview];
    if ([surrpund.searchTextField.text isEqualToString:@""])
    {
        return;
    }
    _userChange = surrpund.searchTextField.text;
    [_myTableView.header beginRefreshing];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (isRetina||iPhone5)
    {
        return 230;
    }else{
    return 270;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return _annotations.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    SurroundTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCell"];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SurroundTableViewCell" owner:nil options:nil]objectAtIndex:0];
    }
    BMKPoiInfo* poi = _annotations[indexPath.row];
    cell.topic.text = poi.name;//名称
    if (poi.phone.length < 1)
    {
        poi.phone = @"暂无电话!";//电话 判断是否有电话
    }
    cell.phone .text = [NSString stringWithFormat:@"电话:%@",poi.phone];
   
   
    NSString *number  = [NSString stringWithFormat:@"%0.2f",[self distanceBetweenOrderBy:_userlatitude :poi.pt.latitude :_userlongitude :poi.pt.longitude]/1000];
    number = [NSString stringWithFormat:@"%@km",number];
    
    cell.number.text =number;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo* poi = _annotations[indexPath.row];
 
    InfoMessageViewController * info = [[InfoMessageViewController alloc]init];
    info.uid =poi.uid;
    info.poiTopic = poi.name;
    info.poiPhone = poi.phone;
    info.poiAddress = poi.address;
    info.poiNumber = [NSString stringWithFormat:@"%0.2f",[self distanceBetweenOrderBy:_userlatitude :poi.pt.latitude :_userlongitude :poi.pt.longitude]/1000];
    
        NSString * latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"];
        NSString * longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"];
    
    info.userlatitude = latitude.doubleValue;
    info.userlongitude = longitude.doubleValue;
    
    info.poilatitude = poi.pt.latitude;
    info.poilongitude = poi.pt.longitude;
    [self.navigationController pushViewController:info animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getloctionWithlatitude:(NSString *)latitude longitude:(NSString *)longitude;
{
    if (_poisearch == nil) {
        _poisearch = [[BMKPoiSearch alloc]init];
        _poisearch.delegate  = self;
    }
       _isUserloction = NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
//    citySearchOption.pageIndex = curPage;
//    citySearchOption.pageCapacity = 10;
//    citySearchOption.city= @"南京";
//    citySearchOption.keyword = @"餐厅";
//    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
//    if (flag)
//    {
//         NSLog(@"城市内检索发送成功");
//    }else{
//         NSLog(@"城市内检索发送失败");
//    }
    [self netWorkingPOIWithlatitude:latitude longitude:longitude];

    

    
    NSLog(@"%@-----%@",latitude,longitude);
}
-(void)netWorkingPOIWithlatitude:(NSString *)latitude longitude:(NSString *)longitude
{
  
    NSLog(@"%@-----%@",latitude,longitude);

    CLLocationCoordinate2D  clocation = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    
    _userlatitude = latitude.floatValue;
    _userlongitude = longitude.floatValue;
    
    if (_isUserloction == YES)
    {
        
        NSString * latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"];
        NSString * longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"];
        
        _userlatitude = latitude.floatValue;
        _userlongitude = longitude.floatValue;
        clocation = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    }
    _option.pageCapacity = 10;
    _option.pageIndex= (int)curPage++;
    _option.location = clocation;
    _option.radius = 10000;
    _option.keyword = _userChange;
    
    BOOL flag = [_poisearch poiSearchNearBy:_option];
    if (flag)
    {
        NSLog(@"城市内检索发送成功");
    }else{
        NSLog(@"城市内检索发送失败");
    }
    
}
-(void)getDelegate
{
    GTTabBarController * gtt = (GTTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    MapViewController * map =(MapViewController *) [gtt getViewcontrollerWithIndex:2];
   
    map.delegate =self;
    gtt.delegate = self;
    [self createLocService];

    

    
}
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        if (_isTopRef == YES)
        {
            [_annotations removeAllObjects];
            for (int i = 0; i < result.poiInfoList.count; i++) {
                BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
                
                [_annotations addObject:poi];
            }
            [_myTableView reloadData];
            [_myTableView.header endRefreshing];
        }else{
            for (int i = 0; i < result.poiInfoList.count; i++) {
                BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
                
                [_annotations addObject:poi];
            }
            [_myTableView reloadData];
            [_myTableView.footer endRefreshing];
        }
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];
        NSLog(@"起始点有歧义");
    } else {
        [_myTableView.header endRefreshing];
        [_myTableView.footer endRefreshing];


        // 各种情况的判断。。。
    }


}

-(void)getUserLoction;
{
    _isUserloction = YES;
    
    
    
    
    
    [self didUpdateBMKUserLocation:_locService.userLocation];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f,",_locService.userLocation.location.coordinate.latitude] forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f,",_locService.userLocation.location.coordinate.longitude] forKey:@"longitude"];
    
    
    
//    
//    NSString * latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"];
//    NSString * longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"];
    
    

    
    //    CLLocationCoordinate2D  clocation = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    [_myTableView.header beginRefreshing];
}
-(void)createLocService
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
}


-(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    return   distance;
    
}
#pragma mark TopButton
-(void)tools:(UIButton *)btn
{
    NSArray * titleArray = [NSArray arrayWithObjects:@"美食",@"加油站",@"汽车美容",@"商场",@"景点",@"酒店",@"银行",@"超市",nil];
    SearchSurroundViewController * search = [[SearchSurroundViewController alloc]init];
    search.userChange =titleArray[btn.tag-100];
    search.userlatitude = _userlatitude;
    search.userlongitude = _userlongitude;
    [self.navigationController pushViewController:search animated:YES];
    
}
-(void)scrollViewSubbtnClick:(UIButton *)btn
{
    _userChange = btn.titleLabel.text;
    [_myTableView.header beginRefreshing];
}
#pragma mark  用户位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;
{
    
}
-(void)loadData
{
    curPage = 0;
    _isTopRef  = YES;
    [self netWorkingPOIWithlatitude:[NSString stringWithFormat:@"%f",_userlatitude] longitude:[NSString stringWithFormat:@"%f",_userlongitude]];
}
-(void)loadMoreData
{
    curPage++;
    _isTopRef  = NO;
       [self netWorkingPOIWithlatitude:[NSString stringWithFormat:@"%f",_userlatitude] longitude:[NSString stringWithFormat:@"%f",_userlongitude]];


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
