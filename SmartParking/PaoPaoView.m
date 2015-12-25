//
//  PaoPaoView.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/10.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "PaoPaoView.h"

@implementation PaoPaoView
-(void)awakeFromNib
{
    self.closeButton.layer.borderWidth = 0.5;
    self.closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.closeButton.layer.cornerRadius = 3;
    
    self.zbywButton.layer.cornerRadius = 3;
    self.dhButton.layer.cornerRadius = 3;
    self.infoMessage.layer.cornerRadius = 3;

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
