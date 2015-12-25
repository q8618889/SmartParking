//
//  MyTool.m
//  OrderDish
//
//  Created by 孙 化育 on 14-7-30.
//  Copyright (c) 2014年 孙 化育. All rights reserved.
//

#import "MyTool.h"

@implementation MyTool

+ (void)gotoViewController:(UIViewController *)vc{
   
    [UIView transitionWithView:[UIApplication sharedApplication].delegate.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil];

}


+ (void)flipView:(UIView *)view{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
    [UIView commitAnimations];
}
+(UIViewController *)viewControllerWithSubView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (void)RefreshingWithTableView:(UITableView *)myTableView target:(UIView *)tarhetView;
{
    
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    [myTableView addLegendHeaderWithRefreshingTarget:tarhetView refreshingAction:@selector(loadData)];
    [myTableView addLegendFooterWithRefreshingTarget:tarhetView refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [myTableView.footer setTitle:@"" forState:MJRefreshFooterStateIdle];
    [myTableView.footer setTitle:@"加载中请稍等" forState:MJRefreshFooterStateRefreshing];
    [myTableView.footer setTitle:@"No more data" forState:MJRefreshFooterStateNoMoreData];
    
    // 设置字体
    myTableView.footer.font = [UIFont systemFontOfSize:14];
    
    

    
    // 此时self.tableView.footer == self.tableView.legendFooter
}
+(NSMutableDictionary *)dictionaryWithdataArray:(NSArray *)dataArray Array:(NSArray *)array
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < array.count; i++)
    {
        [dict setObject:dataArray[i] forKey:array[i]];
    }
    return dict;
}






-(void)loadData
{
    
}
-(void)loadMoreData
{
    
}
//获取文件路径
+ (NSString *)getFilePathWithDirectoryName:(NSString *)directoryName fileName:(NSString *)fileName
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 拼接文件夹路径 判断 保证文件夹一定存在
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@",path,directoryName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 拼接一个完整的文件路径 返回
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",directoryPath,fileName];
    
    return filePath;
}



@end
