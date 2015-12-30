//
//  InfoMessageViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/22.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "InfoMessageViewController.h"
#import "MapViewController.h"
#import "CWStarRateView.h"
#import "InfoTableViewCell.h"
#import "BNCoreServices.h"

@interface InfoMessageViewController ()<BMKPoiSearchDelegate,UITableViewDataSource,UITableViewDelegate,BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>
{
  //  BMKShareURLSearch * _searcher;
    BMKPoiSearch   * _searcher;
    UITableView * _myTableView ;
    NSMutableArray *  _titleArray;
    NSMutableArray *  _numberArray;
    
    
    
}

@end

@implementation InfoMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _titleArray = [[NSMutableArray alloc]initWithObjects:@"综合评分",@"口味评分",@"服务评分" ,@"环境评分",nil];
    _numberArray = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0", nil];
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H - 118) style:UITableViewStylePlain];
    _myTableView.delegate =self;
    _myTableView.dataSource =self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    
    
    self.logoimage.hidden = YES;
    self.backButton.hidden = NO;
    self.messageLabel.text = self.poiTopic;
    //初始化检索对象
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    //发起短串搜索获取poi分享url
    BMKPoiDetailSearchOption *potion = [[BMKPoiDetailSearchOption alloc]init];
    //从poi检索得到的poi的uid
    potion.poiUid=_uid;
    BOOL flag = [_searcher poiDetailSearch:potion];
     if(flag)
    {
        NSLog(@"详情url检索发送成功");
    }
    else
    {
        NSLog(@"详情url检索发送失败");
    }
    
    
    
 
    
    
   
   
    // Do any additional setup after loading the view from its nib.
}
-(void)awakeFromNib
{

}
#pragma mark BMKShareURLSearch
//- (void)onGetPoiDetailShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error;
//{
//    if (error == BMK_SEARCH_NO_ERROR) {
//        //在此处理正常结果
//        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:result.url]];
//        [self.urlView loadRequest:request];
//        NSLog(@"%@",result.url);
//    }
//    else {
//        NSLog(@"抱歉，未找到结果");
//    }
//    
//}
-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR)
    {
        [_numberArray removeAllObjects];
        [_numberArray addObject:[NSString stringWithFormat:@"%f",poiDetailResult.overallRating]];
        [_numberArray addObject:[NSString stringWithFormat:@"%f",poiDetailResult.tasteRating]];
        [_numberArray addObject:[NSString stringWithFormat:@"%f",poiDetailResult.serviceRating]];
        [_numberArray addObject:[NSString stringWithFormat:@"%f",poiDetailResult.environmentRating]];
        [_myTableView reloadData];
        NSLog(@"%@",poiDetailResult.detailUrl);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0)
    {
        return 150;
    }else{
        return 40;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0)
    {
        InfoTableViewCell *  cell = [[[NSBundle mainBundle]loadNibNamed:@"InfoTableViewCell" owner:nil options:nil]objectAtIndex:0];
        cell.topic.text = _poiTopic;
        cell.address.text = _poiAddress;
        cell.phone.text = _poiPhone;
        cell.number.text = [NSString stringWithFormat:@"%@km",_poiNumber];
        [cell.dhButton addTarget:self action:@selector(dhButton:) forControlEvents:BUTTONTOUCHUP];
        return cell;

    }else if (indexPath.row == 1)
    {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSString * number = _numberArray[indexPath.row-1];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %0.1f",_titleArray[indexPath.row-1],number.floatValue];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(130, 8, 150, 20) numberOfStars:5];
        self.starRateView.scorePercent = number.floatValue*2*0.1;
        self.starRateView.allowIncompleteStar = YES;
        self.starRateView.hasAnimation = YES;
        [cell addSubview:self.starRateView];
        return cell;
        
    }else {
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
         NSString * number = _numberArray[indexPath.row - 1];
        cell.textLabel.text = [NSString stringWithFormat:@"%@:  %0.1f",_titleArray[indexPath.row - 1],number.floatValue];

        self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(130, 8, 150, 20) numberOfStars:5];
        self.starRateView.scorePercent = number.floatValue*2*0.1;
        self.starRateView.allowIncompleteStar = YES;
        self.starRateView.hasAnimation = YES;
        [cell addSubview:self.starRateView];
        return cell;

    }
}
-(void)dhButton:(UIButton *)btn
{
    [self startNaviWithLongitude:_poilongitude latitude:_poilatitude];
    
}
//发起导航
- (void)startNaviWithLongitude:(double)longitude latitude:(double)latitude;
{
    NSLog(@"%f-----%f",latitude,longitude);

    //节点数组
    NSMutableArray *nodesArray = [[NSMutableArray alloc]    initWithCapacity:2];
    
    //起点
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = _userlongitude;
    startNode.pos.y = _userlatitude;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];
    
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
}
-(void)onExitNaviUI:(NSDictionary*)extraInfo;
{
    [BNCoreServices ReleaseInstance];
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
