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

@interface DetailedViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    
    UITableView        *_tabView;
    NSString           *_type;
}

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H - 64 - 64)];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.rowHeight = 140.0f;
    [self.view addSubview:_tabView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnPoinBody *ann = _bc[indexPath.row];
    if (indexPath.section == 0) {
        DetailedTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCl"];
        if (cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailedTopTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        [cell.leftImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ann.pictureUri]]];
        cell.titLab.text = [NSString stringWithFormat:@"总 车 位:%.0f个",ann.portCount];
        cell.twoLab.text = [NSString stringWithFormat:@"空 车 位:%.0f个",ann.portLeftCount];
        if (ann.number == nil) {
            ann.number = [NSString stringWithFormat:@"暂无联系方式"];
        }
        cell.threeLab.text = [NSString stringWithFormat:@"电    话:%@",ann.number];
        if (ann.type == 0) {
            _type = [NSString stringWithFormat:@"室内停车场"];
        }else if(ann.type == 1) {
            _type = [NSString stringWithFormat:@"室外停车场"];
        }else {
            _type = [NSString stringWithFormat:@"立体车库或者其他"];
        }
        cell.fourLab.text = [NSString stringWithFormat:@"车场类型:%@",_type];
        cell.fiveLab.text = [NSString stringWithFormat:@"价    格:%.0f",ann.charge];
        
        return cell;
    }else {
        
        DetailedDropTableViewCell * dropCell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCell"];
        if (dropCell == nil){
            dropCell = [[[NSBundle mainBundle]loadNibNamed:@"DetailedDropTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        
        return dropCell;
        
    }
    
    
    
}
@end
