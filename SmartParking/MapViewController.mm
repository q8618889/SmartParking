//
//  MapViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MapViewController.h"
#import "ChooseView.h"
#import "PaoPaoView.h"
#import "SurroundListViewController.h"
#import "BNCoreServices.h"
#import "DetailedViewController.h"

@interface MapViewController ()<BMKLocationServiceDelegate,UIScrollViewDelegate,BNNaviRoutePlanDelegate,BNNaviUIManagerDelegate>
{
    BMKLocationService * _locService;
    ChooseView  * _choose;
    UIButton * liftButton;
    BMKUserLocation * _userLocation;
    AnnPoinBaseClass * _bc;
    BMKAnnotationView *selectedAV;
    BOOL   _isOpenPaopao;
    
    BOOL   _isChoose;
    
    BOOL   _mooen;
    NSMutableArray  * _annArray;
    
}


@end

@implementation MapViewController
//创建地图的单例页面方便所有的页面进行跳转
//+ (MapViewController *)sharedManager
//{
//    static MapViewController *sharedAccountManagerInstance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        sharedAccountManagerInstance = [[MapViewController alloc]init];
//        
//    });
//    return sharedAccountManagerInstance;
//}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.messageLabel.text = @"智慧停车场";

    [self createMBKView];
    [self createLocService];
  

  

    //[self addCustomGestures];//添加自定义的手势
}
#pragma mark- 创建地图以及周边控件

-(void)createMBKView
{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H-117)];
    _mapView.delegate =self;

    _mapView.isSelectedAnnotationViewFront = YES;
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    
    
    
    BMKLocationViewDisplayParam * displayParam = [[BMKLocationViewDisplayParam alloc]init];
    _mapView.showMapScaleBar = YES;
    displayParam.isAccuracyCircleShow = NO;//取消精度圈
    
    _mapView.zoomLevel = 18;
    displayParam.isRotateAngleValid = YES;
    //displayParam.locationViewImgName = @"bnavi_icon_location_fixed";
    [_mapView updateLocationViewWithParam:displayParam];
    [self.view addSubview:_mapView];
    
    if (TARGET_IPHONE_SIMULATOR)
    {
    CLLocationCoordinate2D  cllocation = CLLocationCoordinate2DMake(31.992287, 118.803212);
        [_mapView setCenterCoordinate:cllocation];

    }
    
    
    
    
    

    
//    创建定位按钮
    UIButton * userLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    userLocation.frame = CGRectMake(10, RECT_H-64-95, 40, 40);
    [userLocation setBackgroundImage:[UIImage imageNamed:@"userLoction"] forState:UIControlStateNormal];
    [userLocation addTarget:self action:@selector(userLocationButton:) forControlEvents:BUTTONTOUCHUP];
    [self.view addSubview:userLocation];
    
    
    
    UIButton * roadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    roadButton.frame = CGRectMake(RECT_W-50, 84, 40, 40);
    [roadButton setBackgroundImage:[UIImage imageNamed:@"roadkuang"] forState:UIControlStateNormal];
     [roadButton setBackgroundImage:[UIImage imageNamed:@"roadkuang-on"] forState:UIControlStateSelected];
    [roadButton addTarget:self action:@selector(roadButtonButton:) forControlEvents:BUTTONTOUCHUP];
    [self.view addSubview:roadButton];
    
    
    UIButton * cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cutButton.frame = CGRectMake(RECT_W-50, roadButton.frame.origin.y+roadButton.frame.size.height+5, 40, 40);
    [cutButton setBackgroundImage:[UIImage imageNamed:@"cutMaps"] forState:UIControlStateNormal];
    [cutButton setBackgroundImage:[UIImage imageNamed:@"cutMaps-on"] forState:UIControlStateSelected];
    [cutButton addTarget:self action:@selector(cutButtonButton:) forControlEvents:BUTTONTOUCHUP];
    [self.view addSubview:cutButton];
    
    
 //创建筛选按钮
    
    liftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    liftButton.frame  = CGRectMake(RECT_W-40, 25, 30, 30);
    [liftButton setImage:[UIImage imageNamed:@"choose"] forState:0];
    [liftButton addTarget:self action:@selector(choose:) forControlEvents:BUTTONTOUCHUP];
    liftButton.selected = YES;
    [self.view addSubview:liftButton];

    

}
//创建筛选框
-(void)choose:(UIButton *)btn
{
    
    if (_choose.alpha == 0)
    {
        if (_choose == nil)
        {
            _choose = [[ChooseView alloc]initWithFrame:CGRectMake(RECT_W-60-250,84, 250, 200)];
            _choose.layer.borderWidth = 0.3;
            _choose.layer.borderColor = RGBACOLOR(113, 114, 115, 1).CGColor;
            _choose.backgroundColor = [UIColor whiteColor];
            
            [_choose.sendButton addTarget:self action:@selector(sendNetWorking:) forControlEvents:BUTTONTOUCHUP];
            
            [_choose.clearButton addTarget:self action:@selector(clearNetWorking:) forControlEvents:BUTTONTOUCHUP];
            [self.view addSubview:_choose];
         
        }
        _choose.alpha = 1;
    }else{
        _choose.alpha = 0;
     
    }
    }

-(void)sendNetWorking:(UIButton *)btn
{
    [self.view endEditing:YES];

    _isChoose = YES;
    if (btn != nil)
    {
        _mooen = YES;

    }
    _choose.alpha = 0;
    
    CGFloat centerLongitude = _mapView.region.center.longitude;
    CGFloat  centerLatitude  = _mapView.region.center.latitude;
    [MyNewWorking searchParkingMessageWithLongitude:[NSString stringWithFormat:@"%f",centerLongitude] latitude:[NSString stringWithFormat:@"%f",centerLatitude] portLeftCount:_choose.firstTextField.text distance:_choose.secondTextField.text parkingName:_choose.thirdTextField.text block:^(NSMutableArray *array, NSString *error) {
        if ([error isEqualToString:@"error"])
        {
            [SVProgressHUD show];
            [SVProgressHUD dismissWithError:@"网络错误,请稍后重试!"];
            return ;
        }else if ([error isEqualToString:@"count"])
        {
            [SVProgressHUD show];
            [SVProgressHUD dismissWithError:@"没有搜索到结果!"];
            return ;
        }
        _bc = array[0];
        
        [self createAnn:_bc];
        if (_mooen == YES)
        {
            [_mapView showAnnotations:_annArray animated:YES];
            _mooen = NO;
        }


        
    }];
}
-(void)clearNetWorking:(UIButton *)btn
{
    [self.view endEditing:YES];
    [SVProgressHUD show];
    [SVProgressHUD dismissWithSuccess:@"重置成功"];
    _isChoose = NO;
    
    _choose.alpha = 0;
    [self.view endEditing:YES];
    
    _choose.firstTextField.text = @"";
    _choose.secondTextField.text =@"";
    _choose.thirdTextField.text = @"";
    
    [self netWorking];
}
//用户定位
-(void)userLocationButton:(UIButton *)btn
{
    
    [self didUpdateBMKUserLocation:_locService.userLocation];
    
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    CLLocationCoordinate2D  cllocation = CLLocationCoordinate2DMake(_locService.userLocation.location.coordinate.latitude, _locService.userLocation.location.coordinate.longitude);
        [_mapView setCenterCoordinate:cllocation];
    _mapView.zoomLevel = 18;


}
-(void)cutButtonButton:(UIButton *)btn
{
    if (btn.selected == NO)
    {
        _mapView.mapType = BMKMapTypeSatellite;
        btn.selected = YES;
        
    }else{
        _mapView.mapType = BMKMapTypeStandard;
        btn.selected = NO;
        
    }

}
-(void)roadButtonButton:(UIButton *)btn
{
    if (btn.selected == YES)
    {
        _mapView.trafficEnabled = NO;
        btn.selected = NO;

    }else{
        _mapView.trafficEnabled = YES;
        btn.selected = YES;

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
-(void)createLocService
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;



}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
     _locService.delegate = nil;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    // Add code to clean up any of your own resources that are no longer necessary.
    
//    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidLoad
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}


#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
   
    
    NSLog(@"BMKMapView控件初始化完成");
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    _choose.alpha = 0;
    _isOpenPaopao = NO;
    [self.view endEditing:YES];
    NSLog(@"map view: click blank");
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
{
    if (_isOpenPaopao == YES)
{
    return;
    }
  
    [self netWorking];

    //   迸发进行搜索 比避免阻塞主线程地图
  
}
-(void)netWorking
{
//
    if (_isChoose == YES)
    {
        [self sendNetWorking:nil];
        return;
    }
    CGFloat centerLongitude = _mapView.region.center.longitude;
    CGFloat  centerLatitude  = _mapView.region.center.latitude;
    [MyNewWorking getParkingMessageWithLongitude:[NSString stringWithFormat:@"%f",centerLongitude] latitude:[NSString stringWithFormat:@"%f",centerLatitude] radius:[NSString stringWithFormat:@"%f",[self mapViewZoomLevel:_mapView.zoomLevel]] block:^(NSMutableArray *array, NSString *error) {
        
        _bc = array[0];
        if (_bc.body.count < 1)
        {
            return ;
        }
     
    [self createAnn:_bc];

        
        
        
        
        
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

#pragma mark - 创建气泡
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];


     
        // 设置重天上掉下的效果(annotation)
       // ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }

    [self createMorePopView:annotationView annotation:annotation];
    //创建大头针的样式
    [self createActionPaopaoView:annotationView annotation:annotation];
    
    //    判断颜色
    if (annotation.title.integerValue>300)
    {
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorGreen;
        
    }else if (annotation.title.integerValue<300&&annotation.title.integerValue > 100)
    {
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorPurple;
    }else{
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
-(void)createMorePopView:(BMKAnnotationView *)annotationView annotation:(id<BMKAnnotation>)annotation
{
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(-10, -30, 60, 40)];
    //设置弹出气泡图片
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftbox"]];
    image.frame = CGRectMake(0, 0, 60, 30);
    [popView addSubview:image];
    //自定义显示的内容
    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 60, 20)];
    driverName.text = annotation.title;
    driverName.backgroundColor = [UIColor clearColor];
    driverName.font = [UIFont systemFontOfSize:14];
    driverName.textColor = [UIColor blackColor];
    driverName.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:driverName];
    [annotationView addSubview:popView];
    

}
-(void)createActionPaopaoView:(BMKAnnotationView *)annotationView  annotation:(id<BMKAnnotation>)annotation
{
    NSArray * array = [annotation.subtitle componentsSeparatedByString:@","];
    
    PaoPaoView * paopao = [[[NSBundle mainBundle]loadNibNamed:@"PaopaoView" owner:nil options:nil]objectAtIndex:0];
    [paopao.dhButton addTarget:self action:@selector(dhButton:) forControlEvents:BUTTONTOUCHUP];
    NSString * number1 = [NSString stringWithFormat:@"%@",array[7]];
    [paopao.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:BUTTONTOUCHUP];
    paopao.closeButton.tag =number1.integerValue;
    paopao.zbywButton.tag =number1.integerValue;
    
    
    [paopao.infoMessage addTarget:self action:@selector(infoMessage:) forControlEvents:BUTTONTOUCHUP];
    paopao.infoMessage.tag =number1.integerValue;

    [paopao.zbywButton addTarget:self action:@selector(zbywButton:) forControlEvents:BUTTONTOUCHUP];
    NSString * number = [NSString stringWithFormat:@"%@",array[7]];
    paopao.dhButton.tag =number.integerValue;
    paopao.title.text = array[0];
    
    NSString * type = array[4];
    if (type.integerValue == 0)
    {
        type = @"室内停车场";
    }else if (type.integerValue == 1){
        type = @"室外停车场";
    }else{
        type = @"立体车库或者其他";
    }
    
    paopao.address.text         = [NSString stringWithFormat:@"地址:%@",array[3]];
    paopao.parkType.text        = [NSString stringWithFormat:@"类型:%@",type];
    paopao.total.text           = [NSString stringWithFormat:@"总车位:%@",array[1]];
    paopao.syLabel.text           = [NSString stringWithFormat:@"剩余车位:%@",array[2]];

    
   // paopao.frame = CGRectMake(0,0, 300, 220);
    
    
    
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:paopao];
    pView.frame = CGRectMake(0, 0, 300, 220);
    if (isRetina)
    {
        pView.frame = CGRectMake(0, 0, 250, 150);
    }
    annotationView.paopaoView = pView;
}
-(void)infoMessage:(UIButton *)btn
{
    AnnPoinBody *ann = _bc.body[btn.tag];
    DetailedViewController *de = [[DetailedViewController alloc]init];
    de.ann = ann;
    de.userlatitude = _locService.userLocation.location.coordinate.latitude;
    de.userlongitude = _locService.userLocation.location.coordinate.longitude;
    [self.navigationController pushViewController:de animated:YES];
//    [self presentViewController:de animated:YES completion:^{
//        
//    }];
}
-(void)closeButton:(UIButton *)btn
{
    [self createAnn:_bc];
}
//导航button
-(void)dhButton:(UIButton *)btn
{
    AnnPoinBody * body = _bc.body[btn.tag];
    [self startNaviWithLongitude:body.longitude latitude:body.latitude];
}
-(void)zbywButton:(UIButton *)btn
{
    GTTabBarController * gtt = (GTTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    AnnPoinBody * body = _bc.body[btn.tag];
    gtt.selectedIndex = 3;
   // SurroundListViewController *vc =gtt.viewControllers[3];
  //  vc.isParking = YES;
    [self.delegate getloctionWithlatitude:[NSString stringWithFormat:@"%f",body.latitude] longitude:[NSString stringWithFormat:@"%f",body.longitude]];
    
    
    [_mapView viewWillDisappear];
    
    
    
    
    
}
//发起导航
- (void)startNaviWithLongitude:(double)longitude latitude:(double)latitude;
{
    //节点数组
    NSMutableArray *nodesArray = [[NSMutableArray alloc]    initWithCapacity:2];
    
    //起点
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = _locService.userLocation.location.coordinate.longitude;
    startNode.pos.y = _locService.userLocation.location.coordinate.latitude;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];
    [_mapView viewWillDisappear];

    //终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = longitude;
    endNode.pos.y = latitude;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:endNode];
    //发起路径规划
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
}
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    
    //路径规划成功，开始导航
    [BNCoreServices_UI showNaviUI: BN_NaviTypeReal delegete:self isNeedLandscape:YES];
    [_mapView viewWillDisappear];
}
-(void)onExitNaviUI:(NSDictionary*)extraInfo;
{
    [_mapView viewWillAppear];
    [BNCoreServices ReleaseInstance];
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    _isOpenPaopao = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _isOpenPaopao = NO;
    });
//    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
//#ifdef Debug
//        CGPoint point = [mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
//        //CGRect rect = selectedAV.frame;
//        DLog(@"annotationPoint:x=%.1f, y=%.1f", point.x, point.y);
//#endif
// 
//        //[self showBubble:YES];先移动地图，完成后再显示气泡
//    }
//    else {
//        selectedAV = nil;
//    }

    
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];

    
    
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
//- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//    NSLog(@"didAddAnnotationViews");
//}
//#pragma mark -
//#pragma mark implement BMKSearchDelegate
//- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
//{
//    // 清楚屏幕中所有的annotation
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
//    
//    if (error == BMK_SEARCH_NO_ERROR) {
//        NSMutableArray *annotations = [NSMutableArray array];
//        for (int i = 0; i < result.poiInfoList.count; i++) {
//            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
//            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//            item.coordinate = poi.pt;
//            item.title = poi.name;
//            [annotations addObject:item];
//        }
//        [_mapView addAnnotations:annotations];
//        [_mapView showAnnotations:annotations animated:YES];
//    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
//        NSLog(@"起始点有歧义");
//    } else {
//        // 各种情况的判断。。。
//    }
//}
#pragma mark - 添加自定义的手势

//- (void)addCustomGestures {
//    /*
//     *注意：
//     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
//     *否则影响地图内部的手势处理
//     */
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//    doubleTap.delegate = self;
//    doubleTap.numberOfTapsRequired = 2;
//    doubleTap.cancelsTouchesInView = NO;
//    doubleTap.delaysTouchesEnded = NO;
//    
//    [self.view addGestureRecognizer:doubleTap];
//    
//    /*
//     *注意：
//     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
//     *否则影响地图内部的手势处理
//     */
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    singleTap.delegate = self;
//    singleTap.cancelsTouchesInView = NO;
//    singleTap.delaysTouchesEnded = NO;
//    [singleTap requireGestureRecognizerToFail:doubleTap];
//    [self.view addGestureRecognizer:singleTap];
//}

//- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
//    /*
//     *do something
//     */
//    NSLog(@"my handleSingleTap");
//}
//
//- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
//    /*
//     *do something
//     */
//    NSLog(@"my handleDoubleTap");
//}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
    
    
    //    网络请求
   
  //  NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
   
}






@end
