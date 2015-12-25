//
//  CSAnimation.h
//  HuiMai
//
//  Created by maia on 15/5/8.
//  Copyright (c) 2015年 JJworld(HangZhou)NetworkTechnologyCo.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSAnimation : NSObject
+(void)viewWillAppearWithView:(UIView * )view Style:(id)style Orientation:(id)orientation duration:(CGFloat)duration;
+(void)viewDisappearWithView:(UIView * )view Style:(id)style Orientation:(id)orientation duration:(CGFloat)duration;

@end
