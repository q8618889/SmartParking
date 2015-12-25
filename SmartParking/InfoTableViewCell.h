//
//  InfoTableViewCell.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/24.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *topic;
@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UIButton *dhButton;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *phone;

@end
