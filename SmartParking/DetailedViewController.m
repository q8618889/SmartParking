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
        
        return dropCell;
        
    }
    
}
-(void)zbywBtn:(UIButton *)btn
{

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
