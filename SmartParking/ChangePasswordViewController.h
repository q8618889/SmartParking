//
//  ChangePasswordViewController.h
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *onePassword;
@property (weak, nonatomic) IBOutlet UITextField *resumeLoad;
@property (weak, nonatomic) IBOutlet UITextField *yanZhengMa;





- (IBAction)saveBtn:(id)sender;


@end
