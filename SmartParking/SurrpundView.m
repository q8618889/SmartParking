//
//  SurrpundView.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/18.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "SurrpundView.h"

@implementation SurrpundView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
