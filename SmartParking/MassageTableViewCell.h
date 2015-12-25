//
//  MassageTableViewCell.h
//  JiangDuStateTax
//
//  Created by MAXMFJ on 15/11/11.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MassageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *infoMassage;
@property (weak, nonatomic) IBOutlet UILabel *numberLook;

@end
