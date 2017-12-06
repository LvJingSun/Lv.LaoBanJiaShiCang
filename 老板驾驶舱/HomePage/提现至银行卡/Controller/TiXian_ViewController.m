//
//  TiXian_ViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "TiXian_ViewController.h"
#import "RechargeHeader.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "TiXian_Model.h"
#import "TiXian_Frame.h"
#import "TiXian_Cell.h"
#import "TiXian_List_ViewController.h"

@interface TiXian_ViewController () <UITableViewDelegate,UITableViewDataSource,TiXianDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation TiXian_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"提现至银行卡";
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.];
    
    [self allocWithTableview];
    
    [self requestForData];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"记录" andaction:@selector(listClick)];
    
}

- (void)listClick {
    
    TiXian_List_ViewController *vc = [[TiXian_List_ViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestForData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"memberid",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [SVProgressHUD show];
    
    [http request:@"GetBankCardInfo.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            TiXian_Model *model = [[TiXian_Model alloc] init];
            
            model.bandName = [NSString stringWithFormat:@"%@",[json valueForKey:@"BankName"]];
            
            model.bandCard = [NSString stringWithFormat:@"%@",[json valueForKey:@"CardNumber"]];
            
            model.balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"Balance"]];
            
            TiXian_Frame *frame = [[TiXian_Frame alloc] init];
            
            frame.tixianModel = model;
            
            NSMutableArray *mut = [NSMutableArray array];
            
            [mut addObject:frame];
            
            self.dataArray = mut;
            
            [self.tableview reloadData];
            
            [SVProgressHUD dismiss];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (void)CountFieldChange:(UITextField *)field {
    
    for (TiXian_Frame *frame in self.dataArray) {
        
        frame.tixianModel.count = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TiXian_Cell *cell = [[TiXian_Cell alloc] init];
    
    TiXian_Frame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.sureBlock = ^{
        
        [self TiXianRequest];
        
    };
    
    return cell;
    
}

- (void)TiXianRequest {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    TiXian_Frame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         memberId,@"memberid",
                         frame.tixianModel.count,@"amount",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [SVProgressHUD show];
    
    [http request:@"Getwithdrawals_btn.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        NSDictionary *dic = (NSDictionary *)json;
        
        BOOL isSuccess = [dic[@"status"] boolValue];
        
        if (isSuccess) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TiXian_Frame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
