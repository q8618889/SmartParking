//
//  DetailedDropTableViewCell.h
//  SmartParking
//
//  Created by SCMac on 15/12/25.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedDropTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *addressLab;

- (IBAction)navigationBtn:(id)sender;

- (IBAction)zbywBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *zbywBtn;

@property (weak, nonatomic) IBOutlet UIButton *navigationBtn;

@end
