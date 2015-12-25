//
//  SmartParkListViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "SmartParkListViewController.h"

@interface SmartParkListViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation SmartParkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLabel.text = @"停车场";

    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, RECT_W, RECT_H - 84 - 64)];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.rowHeight = 120.0f;
    [self.view addSubview:tabView];
    
}


#pragma - mark UItableView代理方法 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return nil;
    
}
@end
