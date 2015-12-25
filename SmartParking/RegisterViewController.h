//
//  RegisterViewController.h
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController



@property (weak, nonatomic) IBOutlet UITextField *telephoneTfd;
@property (weak, nonatomic) IBOutlet UITextField *passworldTfd;
@property (weak, nonatomic) IBOutlet UITextField *repeatTfd;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *zhuCe;

- (IBAction)registButton:(id)sender;


@end
