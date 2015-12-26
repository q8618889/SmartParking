//
//  DetailedViewController.m
//  SmartParking
//
//  Created by SCMac on 15/12/25.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "DetailedViewController.h"
#import "DetailedTopTableViewCell.h"
#import "DetailedDropTableViewCell.h"

@interface DetailedViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    
    UITableView        *_tabView;
}

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 124, RECT_W, RECT_H - 124 - 64)];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.rowHeight = 120.0f;
    [self.view addSubview:_tabView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        DetailedTopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SurroundCell"];
        if (cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailedTopTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        return cell;
    }
    
}
@end
