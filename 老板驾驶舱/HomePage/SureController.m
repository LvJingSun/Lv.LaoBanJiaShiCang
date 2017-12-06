//
//  SureController.m
//  BusinessCenter
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "SureController.h"
#import "MassageCell.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface SureController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *memberID;
    
    NSString *yuanGongID;
    
    NSString *remark;
    
    NSString *guaZhongDetails;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *jsonArr;

@end

@implementation SureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.jsonArr = [NSMutableArray array];
    
    self.title = @"确认点单";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableview];
    
    [self initWithFooterView];
    
}

- (void)initWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

- (void)initWithFooterView {

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.05, CGRectGetMaxY(self.tableview.frame) + 5, self.view.bounds.size.width * 0.9, 40)];
    
    [btn setBackgroundColor:[UIColor colorWithRed:255/255. green:88/255. blue:0/255. alpha:1.]];
    
    [btn setTitle:@"确认点单" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 5;
    
    [self.view addSubview:btn];
    
}

- (void)sureBtnClick {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    memberID = memberId;
    
    yuanGongID = self.yuangongID;
    
    remark = @"";
    
    guaZhongDetails = [self arrayToJson:self.jsonArr];
    
    [SVProgressHUD showWithStatus:@"下单中..."];
    
    [self pushData];

}

- (void)pushData {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberID,@"memberID",
                                self.optionType,@"optionType",
                                yuanGongID,@"yuanGongID",
                                remark,@"remark",
                                guaZhongDetails,@"guaZhongDetails",
                                nil];
    
    [httpClient request:@"ErpPaiHaoGuaPai.ashx" parameters:paeameters success:^(NSJSONSerialization* json){

        [SVProgressHUD showSuccessWithStatus:((NSDictionary *)json)[@"msg"]];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataArray[indexPath.row];

    MassageCell *cell = [[MassageCell alloc] init];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.iconImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"MenuImageM"]]]];
    
    cell.nameLabel.text = dic[@"MenuName"];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%d分钟",[dic[@"ShiChang"] intValue]];
    
    cell.proportionLabel.text = [NSString stringWithFormat:@"%d %@",[dic[@"YongJinBiLi"] intValue],@"%"];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%d¥",[dic[@"MenuPrice"] intValue]];
    
    cell.reduceBtn.hidden = YES;
    
    cell.addBtn.hidden = YES;
    
    cell.countLabel.hidden = YES;
    
    NSDictionary *json = @{@"XiangMuID":dic[@"XiangMuID"],@"ShiChang":dic[@"ShiChang"],@"JinE":dic[@"MenuPrice"],@"ShuLiang":@"1",@"YongJinBiLi":dic[@"YongJinBiLi"]};
    
    [self.jsonArr addObject:json];
    
    return cell;
    
}

//数组转Json
- (NSString *)arrayToJson:(NSArray *)array {
    
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    MassageCell *cell = [[MassageCell alloc] init];
    
    return cell.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
