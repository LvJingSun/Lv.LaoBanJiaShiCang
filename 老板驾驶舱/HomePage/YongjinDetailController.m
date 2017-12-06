//
//  YongjinDetailController.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "YongjinDetailController.h"
#import "YongjinDetailHeadView.h"
#import "YongjinCell.h"

@interface YongjinDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) YongjinDetailHeadView *headView;

@end

@implementation YongjinDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"佣金明细";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableView];
    
    [self initWithHeadView];

}

- (void)initWithTableView {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
}

- (void)initWithHeadView {
    
    YongjinDetailHeadView *headView = [[YongjinDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    
    self.headView = headView;
    
    headView.nameLabel.text = @"点钟";
    
    headView.countLabel.text = @"共5种服务";
    
    headView.yongjinLabel.text = [NSString stringWithFormat:@"总佣金:180¥"];
    
    self.tableview.tableHeaderView = headView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YongjinCell *cell = [[YongjinCell alloc] init];
    
    cell.nameLabel.text = @"足浴";
    
    cell.timeLabel.text = [NSString stringWithFormat:@"时长:30分钟"];
    
    cell.priceLabel.text = @"50¥";
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YongjinCell *cell = [[YongjinCell alloc] init];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    
}



@end
