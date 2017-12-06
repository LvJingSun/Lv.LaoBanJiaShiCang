//
//  SupplierAdminController.m
//  BusinessCenter
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "SupplierAdminController.h"
#import "StaffModel.h"
#import "AdminCell.h"
#import "AddSupplierController.h"
#import "EditSupplierController.h"
#import "AppHttpClient.h"

@interface SupplierAdminController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *supplierArr;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation SupplierAdminController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"供应商管理";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtn];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 2, self.view.bounds.size.width, self.view.bounds.size.height - rectStatus.size.height - rectNav.size.height - 2)];
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    self.tableView = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    [self.view addSubview:tableview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"请添加供应商";
    
    self.noLabel = label;
    
    label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [self requestData];
    
}

- (void)setRightBtn {

    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    editBtn.frame = CGRectMake(0, 0, 20, 20);
    
    [editBtn setImage:[UIImage imageNamed:@"sotckjia.png"] forState:UIControlStateNormal];
    
    [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barreflectBtn=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    
    self.navigationItem.rightBarButtonItem = barreflectBtn;
    
}

- (void)editBtnClick {

    AddSupplierController *vc = [[AddSupplierController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.supplierArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AdminCell *cell = [[AdminCell alloc] init];
    
    NSDictionary *dic = self.supplierArr[indexPath.row];
    
    cell.nameLab.text = dic[@"XingMing"];
    
    cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"TuBiao"]]]];
    
    cell.titleLab.text = dic[@"Address"];
    
    cell.telLab.text = dic[@"Phone"];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.supplierArr[indexPath.row];
    
    EditSupplierController *vc = [[EditSupplierController alloc] init];
    
    vc.name = dic[@"XingMing"];
    
    vc.suppliername = dic[@"SupplierName"];
    
    vc.phone = dic[@"Phone"];
    
    vc.address = dic[@"Address"];
    
    vc.supplierID = dic[@"SupplierID"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpGongYingShangList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"GongYingShangModelList"];
        
        if (trueArr.count == 0) {
            
            self.noLabel.hidden = NO;
            
            self.tableView.hidden = YES;
        
        }else {
            
            self.noLabel.hidden = YES;
            
            self.tableView.hidden = NO;
            
            self.supplierArr = trueArr;
            
            [self.tableView reloadData];
            
        }
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
