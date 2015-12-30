//
//  MyScrollView.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/18.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView
-(void)awakeFromNib
{
    _buttonArrays = [NSMutableArray array];
    NSArray * titleArray = [NSArray arrayWithObjects:@"美食",@"加油站",@"汽车美容",@"商场",@"景点",@"酒店",@"银行",@"超市",nil];
    self.contentSize = CGSizeMake(70*8, 30);
    for (NSInteger i = 0; i< 8; i++)
    {
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(70*i, 0, 70, 30)];
        [btn setTitle:titleArray[i] forState:0];
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        btn.layer.borderWidth =0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.tag = i+50;
        [self addSubview:btn];
        [_buttonArrays addObject:btn];

    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
