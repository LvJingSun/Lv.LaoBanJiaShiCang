//
//  HuahuaViewController.m
//  BusinessCenter
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "HuahuaViewController.h"
#import "HuaHuaViewCell.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

@interface HuahuaViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UILabel *yueLabel;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) UILabel *noLab;

@end

@implementation HuahuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewStyle];
    
    [self setHeadView];
    
    [self requestData];
    
    [self setTableview];
    
    [self requestRecord];
    
}

- (void)setHeadView {

    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    
    headview.backgroundColor = [UIColor colorWithRed:217/255. green:244/255. blue:254/255. alpha:1.];
    
    [self.view addSubview:headview];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.032, 10, self.view.bounds.size.width * 0.968, 30)];
    
    self.yueLabel = lab;
    
    lab.textColor = [UIColor darkGrayColor];
    
    lab.font = [UIFont systemFontOfSize:15];
    
    [headview addSubview:lab];
    
}

- (void)setTableview {
    
    UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200) * 0.5, (self.view.bounds.size.height - 40) * 0.5, 200, 40)];
    
    self.noLab = noLabel;
    
    noLabel.hidden = NO;
    
    noLabel.text = @"暂无收支记录";
    
    noLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:noLabel];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50)];
    
    self.tableview = tableview;
    
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.array[indexPath.row];

    HuaHuaViewCell *cell = [[HuaHuaViewCell alloc] init];
    
    NSString *type = [NSString stringWithFormat:@"%@",dic[@"TransactionType"]];
    
    cell.jingbanrenLab.text = [NSString stringWithFormat:@"经办人:%@",dic[@"CashierAccountID"]];
    
    cell.shopLab.text = dic[@"MerchantID"];
    
    if ([type isEqualToString:@"1"]) {
        
        cell.countLab.text = [NSString stringWithFormat:@"+%@",dic[@"YongBei"]];
        
        cell.countLab.textColor = [UIColor greenColor];
        
    }else {
        
        cell.countLab.text = [NSString stringWithFormat:@"-%@",dic[@"YongBei"]];
        
        cell.countLab.textColor = [UIColor redColor];
        
    }
    
    cell.nameLab.text = [NSString stringWithFormat:@"%@",dic[@"Memberid"]];
    
    cell.timeLab.text = [NSString stringWithFormat:@"%@",dic[@"CreateDate"]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    HuaHuaViewCell *cell = [[HuaHuaViewCell alloc] init];
    
    return cell.height;
    
}

- (void)requestRecord {
    
    [SVProgressHUD showWithStatus:@"请求中..."];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberid",
                                @"1",@"key",
                                nil];
    
    NSLog(@"%@",paeameters);
    
    [httpClient request:@"GetHuaHuaTranList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL success = [dic[@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSArray *temp = dic[@"ybtrList"];
            
            if (temp.count == 0) {
                
                self.noLab.hidden = NO;
                
                self.tableview.hidden = YES;
                
            }else {
                
                self.noLab.hidden = YES;
                
                self.tableview.hidden = NO;
            
                self.array = temp;
                
            }
            
            [self.tableview reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            
        }
        
    }failure:^(NSError *error){
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberid",
                                nil];
    
    [httpClient request:@"Gethuahuabalance.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL success = [dic[@"status"] boolValue];
        
        if (success) {
            
            self.yueLabel.text = [NSString stringWithFormat:@"余额：%@",((NSDictionary *)dic[@"yuEMore"])[@"Balance"]];
            
        }else {
        
            self.yueLabel.text = [NSString stringWithFormat:@"余额：0"];
            
        }
        
    }failure:^(NSError *error){
        
        self.yueLabel.text = [NSString stringWithFormat:@"余额：0"];
        
    }];
    
}

- (void)setViewStyle {

    self.title = @"花花";
    
    self.view.backgroundColor = [UIColor whiteColor];

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
