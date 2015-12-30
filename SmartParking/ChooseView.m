//
//  ChooseView.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/7.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "ChooseView.h"

@implementation ChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        UILabel * firstLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 30)];
        firstLabel.text = @"剩余停车位>=";
        firstLabel.textColor = RGBACOLOR(112, 113, 114, 1);
        firstLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:firstLabel];
        
        
        _firstTextField  = [[UITextField alloc]initWithFrame:CGRectMake(firstLabel.frame.origin.x+firstLabel.frame.size.width,23 , 80, 25)];
        _firstTextField.layer.borderWidth = 0.5;
        _firstTextField.layer.borderColor = RGBACOLOR(112, 113, 114, 1).CGColor;
        [self addSubview:_firstTextField];
        
        
        UILabel * firstA = [[UILabel alloc]initWithFrame:CGRectMake(_firstTextField.frame.origin.x+_firstTextField.frame.size.width+3, 20, 30, 30)];
        firstA.text = @"个";
        firstA.textColor = RGBACOLOR(112, 113, 114, 1);
        firstA.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:firstA];
        
        
        
        
        
        
        
        
        
        UILabel * secondLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 100, 30)];
        secondLabel.text = @"最近距离数<=";
        secondLabel.textColor = RGBACOLOR(112, 113, 114, 1);
        secondLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:secondLabel];
        
        
        _secondTextField  = [[UITextField alloc]initWithFrame:CGRectMake(secondLabel.frame.origin.x+secondLabel.frame.size.width,63 , 80, 25)];
        _secondTextField.layer.borderWidth = 0.5;
        _secondTextField.layer.borderColor = RGBACOLOR(112, 113, 114, 1).CGColor;
        [self addSubview:_secondTextField];
        
        
        UILabel * sencondA = [[UILabel alloc]initWithFrame:CGRectMake(_firstTextField.frame.origin.x+_firstTextField.frame.size.width+3, 65, 30, 30)];
        sencondA.text = @"公里";
        sencondA.textColor = RGBACOLOR(112, 113, 114, 1);
        sencondA.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:sencondA];
        
        
        
        
        UILabel * thirdLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 30)];
        thirdLabel.text = @"停车场名称";
        thirdLabel.textColor = RGBACOLOR(112, 113, 114, 1);
        thirdLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:thirdLabel];
        
        
        _thirdTextField  = [[UITextField alloc]initWithFrame:CGRectMake(secondLabel.frame.origin.x+secondLabel.frame.size.width,103 , 120, 25)];
        _thirdTextField.layer.borderWidth = 0.5;
        _thirdTextField.layer.borderColor = RGBACOLOR(112, 113, 114, 1).CGColor;
        [self addSubview:_thirdTextField];
        
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(20, _thirdTextField.frame.origin.y+_thirdTextField.frame.size.height+ 20, 100, 28);
    
        _sendButton.layer.cornerRadius = 5;
        [_sendButton setTitle:@"确定" forState:0];
        _sendButton.backgroundColor  = RGBACOLOR(10, 74, 146, 1);
        [self addSubview:_sendButton];
        
        _clearButton = [UIButton buttonWithType: UIButtonTypeCustom];
        _clearButton.frame = CGRectMake(_sendButton.frame.origin.x+_sendButton.frame.size.width+5, _sendButton.frame.origin.y, 100, 28);
        _clearButton.layer.cornerRadius = 5;
        [_clearButton setTitle:@"重置" forState:0];
        _clearButton.backgroundColor  = RGBACOLOR(10, 74, 146, 1);
        [self addSubview:_clearButton];
        
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
