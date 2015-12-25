//
//  ChangePasswordViewController.h
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PooCodeView.h"
@interface ChangePasswordViewController : MainViewController

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *onePassword;
@property (weak, nonatomic) IBOutlet UITextField *resumeLoad;
@property (weak, nonatomic) IBOutlet UITextField *yanZhengMa;
@property (strong, nonatomic) IBOutlet PooCodeView *pooView;





- (IBAction)saveBtn:(id)sender;


@end
