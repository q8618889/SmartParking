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
    float              _labelHeight;
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
    [self.view addSubview:_tabView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnPoinBody *ann = _bc[indexPath.row];
    if (indexPath.row == 0) {
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
