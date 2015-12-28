//
//  DetailedViewController.m
//  SmartParking
//
//  Created by SCMac on 15/12/25.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "DetailedViewController.h"
#import "DetailedTopTableViewCell.h"
#import "DetailedDropTableViewCell.h"
#import "SurroundListViewController.h"
#import "BNCoreServices.h"
@interface DetailedViewController () <UITableViewDataSource,UITableViewDelegate,BNNaviRoutePlanDelegate,BNNaviUIManagerDelegate> {
    
    
    UITableView        *_tabView;
    NSString           *_type;
    float              _labelHeight;
}

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoimage.hidden = YES;
    self.backButton.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H - 64 - 64)];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.tableFooterView = [[UIView alloc]init];

    [self.view addSubview:_tabView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        DetailedTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCl"];
        if (cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailedTopTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        [cell.leftImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_ann.pictureUri]]placeholderImage:[UIImage imageNamed:@"bg_1"]];
        cell.titLab.text = [NSString stringWithFormat:@"总 车 位:%.0f个",_ann.portCount];
        cell.twoLab.text = [NSString stringWithFormat:@"空 车 位:%.0f个",_ann.portLeftCount];
        if (_ann.number == nil) {
            _ann.number = [NSString stringWithFormat:@"暂无联系方式"];
        }
        cell.threeLab.text = [NSString stringWithFormat:@"电    话:%@",_ann.number];
        if (_ann.type == 0) {
            _type = [NSString stringWithFormat:@"室内停车场"];
        }else if(_ann.type == 1) {
            _type = [NSString stringWithFormat:@"室外停车场"];
        }else {
            _type = [NSString stringWithFormat:@"立体车库或者其他"];
        }
        cell.fourLab.text = [NSString stringWithFormat:@"车场类型:%@",_type];
        cell.fiveLab.text = [NSString stringWithFormat:@"价    格:%.0f",_ann.charge];
        
        return cell;
        
    }else {
        
        DetailedDropTableViewCell * dropCell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCell"];
        if (dropCell == nil){
            dropCell = [[[NSBundle mainBundle]loadNibNamed:@"DetailedDropTableViewCell" owner:nil options:nil]objectAtIndex:0];
          
        }
        NSString * addressStr= _ann.position;
        if ([addressStr isEqualToString:@""])
        {
            addressStr = @"暂无信息";
        }
        
        dropCell.addressLab.text = addressStr;
        NSString * str = _ann.bodyDescription;
        if ([str isEqualToString:@""] || str == nil)
        {
            str = @"暂无信息";
        }
        dropCell.contentLab.text = str;
        [self resetContent:dropCell.contentLab];
        
        [dropCell.zbywBtn addTarget:self action:@selector(zbywBtn:) forControlEvents:BUTTONTOUCHUP];
        [dropCell.navigationBtn addTarget:self action:@selector(dhButton:) forControlEvents:BUTTONTOUCHUP];
        return dropCell;
        
    }
    
}
//导航button
-(void)dhButton:(UIButton *)btn
{
    
    [self startNaviWithLongitude:_ann.longitude latitude:_ann.latitude];
}
//发起导航
- (void)startNaviWithLongitude:(double)longitude latitude:(double)latitude;
{
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
-(void)zbywBtn:(UIButton *)btn
{
    GTTabBarController * gtt = (GTTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UINavigationController * nav =(UINavigationController *) [gtt getViewcontrollerWithIndex:3];
    gtt.selectedIndex =3;
    SurroundListViewController * sur = nav.viewControllers[0];
    [sur getloctionWithlatitude:[NSString stringWithFormat:@"%f",_ann.latitude] longitude:[NSString stringWithFormat:@"%f",_ann.longitude]];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 140.0f;
    }else {
        return _labelHeight+230;
    }
    
}

- (void)resetContent:(UILabel *)lab{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:lab.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lab.text.length)];
    lab.attributedText = attributedString;
    //调节高度
    CGSize size = CGSizeMake(RECT_W-34, MAXFLOAT);
    
    CGSize labelSize = [lab sizeThatFits:size];
    _labelHeight = ceilf(labelSize.height);
}


@end
