//
//  CusScrollView.m
//  Hqpp
//
//  Created by MAXMFJ on 15/7/29.
//  Copyright (c) 2015年 ddzn. All rights reserved.
//

#import "CusScrollView.h"

@implementation CusScrollView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[self superview] superview] endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
