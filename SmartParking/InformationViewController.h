//
//  InformationViewController.h
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationViewController : MainViewController
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passWorld;

@property (strong, nonatomic) IBOutlet UITextField *nickName;
- (IBAction)sendNerWorking:(UIButton *)sender;

@end
