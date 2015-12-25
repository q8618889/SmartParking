//
//  PaoPaoView.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/10.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaoPaoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *parkType;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *syLabel;
@property (strong, nonatomic) IBOutlet UIButton *zbywButton;

@property (weak, nonatomic) IBOutlet UIButton *infoMessage;
@property (weak, nonatomic) IBOutlet UIButton *dhButton;


@end
