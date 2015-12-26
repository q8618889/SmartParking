//
//  NewInfoViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/26.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "NewInfoViewController.h"
#import "CusScrollView.h"
#import "FTCoreTextView.h"
static const CGFloat kBasicTextSize = 12.0f;

@interface NewInfoViewController ()<FTCoreTextViewDelegate>
@property (nonatomic, strong) CusScrollView     *scrollView;
@property (nonatomic, strong) FTCoreTextView    *coreTextView;
@end

@implementation NewInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoimage.hidden = YES;
    self.backButton.hidden = NO;    // self.titleLabel.text = _titleName;
    
    
    
    [self createView];
    [self createText];
    

    
    // Do any additional setup after loading the view.
}
-(void)createView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    //  Create scroll view containing allowing to scroll the FTCoreText view
    self.scrollView = [[CusScrollView alloc] initWithFrame:CGRectMake(0,64, RECT_W,RECT_H-44-64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //  Create FTCoreTextView. Everything will be rendered within this view
    self.coreTextView = [[FTCoreTextView alloc] initWithFrame:CGRectInset(bounds, 20.0f, 0)];
    self.coreTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.coreTextView.alpha = 0;
    [self.scrollView addSubview:self.coreTextView];
    [self.view addSubview:self.scrollView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.coreTextView.alpha = 1;
    }];
}



-(void)createText

{
    
    
    UIImageView * imagesss = [[UIImageView alloc]init];
    imagesss.image = _WebImage;
    CGSize imagesize = imagesss.image.size;
    if (isRetina||iPhone5){
        imagesize.height =200;
        imagesize.width =270;
    }else{
        imagesize.height =200;
        
        imagesize.width = 300;
    }
    
    imagesss.image = [self imageWithImage:imagesss.image scaledToSize:imagesize];
    //    等比例压缩图片
    
    NSData *mydata=UIImageJPEGRepresentation(imagesss.image,1);
    
    NSString *pictureDataString=[mydata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    //NSCharacterSet*set = [NSCharacterSet characterSetWithCharactersInString:@"\r\n"];
    
    
    
    
    self.coreTextView.text = [NSString stringWithFormat:@"<h1>%@</h1>\n<h2>%@</h2>\n<img>base64:%@</img>\n<p>%@</p>",_topic,_date,pictureDataString,_content];
    //  Define styles
    //  Define styles
    
    FTCoreTextStyle *imgStyle = [FTCoreTextStyle styleWithName:FTCoreTextTagImage];
    imgStyle.name = @"img";
    imgStyle.textAlignment = FTCoreTextAlignementCenter;
    
    
    FTCoreTextStyle *defaultStyle = [[FTCoreTextStyle alloc] init];
    defaultStyle.name = FTCoreTextTagDefault;
    defaultStyle.textAlignment = FTCoreTextAlignementJustified;
    
    defaultStyle.font = [UIFont systemFontOfSize:kBasicTextSize];
    
    FTCoreTextStyle *linkStyle = [defaultStyle copy];
    linkStyle.name = FTCoreTextTagLink;
    linkStyle.color = [UIColor orangeColor];
    
    
    FTCoreTextStyle *h1Style = [defaultStyle copy];
    h1Style.name = @"h1";
    h1Style.paragraphInset = UIEdgeInsetsMake(10, 0, 1, 0);
    
    h1Style.font = [UIFont boldSystemFontOfSize:18];
    h1Style.textAlignment = FTCoreTextAlignementCenter;
    
    FTCoreTextStyle *h2Style = [h1Style copy];
    h2Style.name = @"h2";
    h2Style.color = [UIColor darkGrayColor];
    
    h2Style.paragraphInset = UIEdgeInsetsMake(3, 0, 1, 0);
    h2Style.font = [UIFont systemFontOfSize:kBasicTextSize];
    
    FTCoreTextStyle *pStyle = [defaultStyle copy];
    pStyle.leading = 5;
    pStyle.color = [UIColor darkTextColor];
    pStyle.font = [UIFont  systemFontOfSize:14.0f];
    pStyle.name = @"p";
    
    //  HTML list "li" style
    //  We first get default style for "_bullet" tag, rename it to "li"
    //  and then replace the default with new tag
    FTCoreTextStyle *liStyle = [FTCoreTextStyle styleWithName:FTCoreTextTagBullet];
    liStyle.name = @"li";
    liStyle.paragraphInset = UIEdgeInsetsMake(0, 14.0f, 0, 0);
    
    
    
    [self.coreTextView changeDefaultTag:FTCoreTextTagBullet toTag:@"li"];
    
    
    //  HTML image "img" style
    //  We first get default style for "_image" tag, rename it to "img"
    //  and then replace the default with new tag
    
    //[self.coreTextView addSubview:image];
    [self.coreTextView changeDefaultTag:FTCoreTextTagImage toTag:@"img"];
    
    
    //  HTML link anchor "a"
    //  We first get default style for "_link" tag, rename it to "a"
    //  and then replace the default with new tag
    //  Mind you still need to use "_link"-like format
    //  <a>http://url.com|Dislayed text</a> format, not the html "<a href..." format
    FTCoreTextStyle *aStyle = [FTCoreTextStyle styleWithName:FTCoreTextTagLink];
    aStyle.name = @"a";
    aStyle.underlined = YES;
    aStyle.color = [UIColor blueColor];
    
    [self.coreTextView changeDefaultTag:FTCoreTextTagLink toTag:@"a"];
    
    //  Apply styles
    [self.coreTextView addStyles:@[defaultStyle, imgStyle, h1Style, h2Style, pStyle, liStyle, aStyle,linkStyle]];
    
    //  Make self delegate so we receive links actions
    self.coreTextView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
