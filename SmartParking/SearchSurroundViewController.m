//
//  SearchSurroundViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/21.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "SearchSurroundViewController.h"
#import "SurroundTableViewCell.h"
#import "MapViewController.h"
#import "InfoMessageViewController.h"

@interface SearchSurroundViewController ()<UITableViewDataSource,UITableViewDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate>
{
    UITableView * _myTableView;
     BOOL       _isTopRef;
    
    BMKPoiSearch* _poisearch;
    BMKLocationService * _locService;
    BMKNearbySearchOption * _option;
    
    NSInteger curPage;//标记搜索的内容页数
    
    NSMutableArray *_annotations;
    
    
    UITextField * _searchTextField;


    
}

@end

@implementation SearchSurroundViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _poisearch.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoimage.hidden = YES;
    self.backButton.hidden = NO;
    self.messageLabel.text = _userChange;
    if (_poisearch == nil) {
        _poisearch = [[BMKPoiSearch alloc]init];
        _poisearch.delegate  = self;
    }
    curPage =0;
    
    _option = [[BMKNearbySearchOption alloc]init];
    _annotations = [NSMutableArray array];
    
    
    _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H-118)style:UITableViewStyleGrouped];
    
    _myTableView.delegate =self;
    _myTableView.dataSource =self;
    _myTableView.rowHeight = 70;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    [MyTool RefreshingWithTableView:_myTableView target:(UIView *)self];
    [_myTableView.header beginRefreshing];
}
#pragma  mark-  TableViewDelegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, RECT_W, 40)];
    view.backgroundColor = [UIColor whiteColor];
    if (_searchTextField == nil)
    {
        _searchTextField  =[[UITextField alloc]initWithFrame:CGRectMake(5, 5, RECT_W-70, 30)];
    }
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(_searchTextField.frame.origin.x+_searchTextField.frame.size.width-5,5, 58, 30)];
    [btn setTitle:@"搜索" forState:0];
    [btn setBackgroundImage:[UIImage imageNamed:@"searchButton"] forState:0];
    [btn addTarget:self action:@selector(btnSearch:) forControlEvents:BUTTONTOUCHUP];
    
    _searchTextField.placeholder= _userChange;
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:_searchTextField];
    [view addSubview:btn];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
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
    cell.topic.text = poi.name;
    if (poi.phone.length < 1)
    {
        poi.phone = @"暂无电话!";
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
    
    info.userlatitude = latitude.floatValue;
    info.userlatitude = longitude.floatValue;
    
    info.poilatitude = poi.pt.latitude;
    info.poilatitude = poi.pt.longitude;
    [self.navigationController pushViewController:info animated:YES];
    
}




-(void)netWorkingPOIWithlatitude:(NSString *)latitude longitude:(NSString *)longitude
{
    
    NSLog(@"%@-----%@",latitude,longitude);
    
    CLLocationCoordinate2D  clocation = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    

    
//    if (_isUserloction == YES)
//    {
//        
//        NSString * latitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"];
//        NSString * longitude = [[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"];
//        
//        _userlatitude = latitude.floatValue;
//        _userlongitude = longitude.floatValue;
//        clocation = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
//    }
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
//计算路程
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
