//
//  SmartParkListViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "SmartParkListViewController.h"
#import "SmartParkTableViewCell.h"
#import "MapViewController.h"
#import "DetailedViewController.h"


@interface SmartParkListViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    
    CGFloat             _userlatitude;
    CGFloat             _userlongitude;
    NSMutableArray     *_mutArry;
    
    AnnPoinBaseClass   *_bc;
    NSMutableArray     *_annArray;
    UITableView        *_tabView;
    NSMutableArray     *_dataArray;
    NSString           *_type;
    
    
}

@end

@implementation SmartParkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLabel.text = @"停车场";

    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 124, RECT_W, RECT_H - 124 - 64)];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.rowHeight = 120.0f;
    [self.view addSubview:_tabView];
    
    [MyTool RefreshingWithTableView:_tabView target:(UIView *)self];
    [_tabView.header beginRefreshing];
    
}


#pragma - mark UItableView代理方法 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _mutArry.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SmartParkTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCell"];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SmartParkTableViewCell" owner:nil options:nil]objectAtIndex:0];
    }
    
    AnnPoinBody *ann = _mutArry[indexPath.row];
    [cell.leftImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ann.pictureUri]]];
    cell.titLab.text = ann.name;
    cell.oneLab.text = [NSString stringWithFormat:@"总车位:%.0f,剩余:%.0f",ann.portCount,ann.portLeftCount];
    cell.twoLab.text = [NSString stringWithFormat:@"联系电话:%@",ann.number];
    if (ann.type == 0) {
        _type = [NSString stringWithFormat:@"室内停车场"];
    }else if(ann.type == 1) {
        _type = [NSString stringWithFormat:@"室外停车场"];
    }else {
        _type = [NSString stringWithFormat:@"立体车库或者其他"];
    }
    cell.theeLab.text = [NSString stringWithFormat:@"停车场类型:%@",_type];
    cell.fourLab.text = [NSString stringWithFormat:@"地址:%@",ann.position];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailedViewController *de = [DetailedViewController new];
    [self.navigationController pushViewController:de animated:YES];
    
}

#pragma  - mark 下拉刷新
-(void)loadData {
    
    
    CGFloat centerLongitude = _mapView.region.center.longitude;
    CGFloat  centerLatitude  = _mapView.region.center.latitude;
    [MyNewWorking getParkingMessageWithLongitude:[NSString stringWithFormat:@"%f",centerLongitude] latitude:[NSString stringWithFormat:@"%f",centerLatitude] radius:[NSString stringWithFormat:@"%f",[self mapViewZoomLevel:_mapView.zoomLevel]] block:^(NSMutableArray *array, NSString *error) {
        [_tabView.header endRefreshing];
        _mutArry =(NSMutableArray *)_bc.body;
        _bc = array[0];
        NSLog(@"___%@",_bc.body);
        
       
        if (_bc.body.count < 1)
        {
            return ;
        }
        [self createAnn:_bc];
        
        [_tabView reloadData];
        
        
    }];
    
}

-(void)createAnn:(AnnPoinBaseClass *)bc
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    _annArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < bc.body.count; i++)
    {
        
        AnnPoinBody * body = bc.body[i];
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = body.latitude;
        coor.longitude = body.longitude;
        annotation.coordinate = coor;
        annotation.title = [NSString stringWithFormat:@"%0.f",body.portLeftCount];
        annotation.subtitle =[NSString stringWithFormat:@"%@,%0.f,%0.f,%@,%0.f,%f,%f,%ld",body.name,body.portCount,body.portLeftCount,body.position,body.type,body.latitude,body.longitude,(long)i];
        [_annArray addObject:annotation];
        [_mapView addAnnotation:annotation];
        
        
    }
    
    
}

#pragma mark- 创建地图定位信息

-(CGFloat)mapViewZoomLevel:(CGFloat)level
{
    
    if (level <= 10) {
        return 20000;
    }
    if (level <= 11 )
    {
        return 16000;
    }
    if (level <= 12 )
    {
        return 14000;
    }
    if (level <= 13 )
    {
        return 12000;
    }
    if (level <= 14 )
    {
        return 10000;
    }
    if (level <= 15 )
    {
        return 8000;
    }
    if (level <= 16 )
    {
        return 6500;
    }
    if (level <= 17 )
    {
        return 5000;
    }
    if (level <= 18 )
    {
        return 4000;
    }
    if (level <= 19 )
    {
        return 2000;
    }
    if (level >= 20 )
    {
        return 1500;
    }
    return 1000;
    
}

-(void)loadMoreData {
    
    
    
    
}

@end
