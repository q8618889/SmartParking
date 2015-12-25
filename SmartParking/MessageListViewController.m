//
//  MessageListViewController.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MessageListViewController.h"
#import "MassageTableViewCell.h"
@interface MessageListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _myTableView;
}

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLabel.text = @"动态信息";

    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor redColor];
    [self createView];
    // Do any additional setup after loading the view.
}
-(void)createView
{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, RECT_W, RECT_H-108) style:UITableViewStylePlain];
    _myTableView.delegate =self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 140;

    [self.view addSubview:_myTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MassageTableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"MassageTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MassageTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    
    cell.title.text =@"asdadasd";
    cell.infoMassage.text = @"sdasjdaksldjasdlkjakldjaslkdjalsasdasdadasdasdasdasdasdsadasdasdasdasdasdkdja";
    cell.numberLook.text = @"2015-10-02";
    
    
    //  NSString * imgUrl = [NSString stringWithFormat:@"%@/jdgs_bks%@",MAXURL,obj.fileUrl];
   // [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.fileUrl]]placeholderImage:[UIImage imageNamed:@"newimgemoren.jpg"]];
    return cell;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
