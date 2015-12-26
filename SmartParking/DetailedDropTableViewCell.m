//
//  DetailedDropTableViewCell.m
//  SmartParking
//
//  Created by SCMac on 15/12/25.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "DetailedDropTableViewCell.h"

@implementation DetailedDropTableViewCell

- (void)awakeFromNib {
    self.navigationBtn.layer.cornerRadius = 3;
    self.zbywBtn.layer.cornerRadius = 3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)navigationBtn:(id)sender {
}

- (IBAction)zbywBtn:(id)sender {
    
    
}
@end
