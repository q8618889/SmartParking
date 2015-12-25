//
//  CSAnimation.m
//  HuiMai
//
//  Created by maia on 15/5/8.
//  Copyright (c) 2015年 JJworld(HangZhou)NetworkTechnologyCo.LTD. All rights reserved.
//

#import "CSAnimation.h"

@implementation CSAnimation
+(void)viewWillAppearWithView:(UIView * )view Style:(id)style Orientation:(id)orientation duration:(CGFloat)duration{
    view.hidden = NO;
    CATransition * animation = [CATransition animation];
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = style;
    animation.subtype = orientation;
    [view.layer addAnimation:animation forKey:@"animationID"];
}

#pragma mark 点击动画隐藏
+(void)viewDisappearWithView:(UIView * )view Style:(id)style Orientation:(id)orientation duration:(CGFloat)duration{
    view.hidden = YES;
    CATransition * animation = [CATransition animation];
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = style;
    animation.subtype = orientation;
    [view.layer addAnimation:animation forKey:@"animationID"];
}

@end
