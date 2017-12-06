//
//  StaffAdminController.m
//  BusinessCenter
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "StaffAdminController.h"
#import "StaffModel.h"
#import "AdminCell.h"
#import "AddStaffController.h"
#import "EditStaffController.h"
#import "AppHttpClient.h"

@interface StaffAdminController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *memberID;
    
}

@property (nonatomic, strong) NSArray *staffArr;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UILabel *noLabel;

@property (nonatomic, strong) NSArray *shangpuArray;

@property (nonatomic, strong) NSArray *positionArray;

@property (nonatomic, strong) NSArray *levelArray;

@end

@implementation StaffAdminController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    memberID = memberId;
    
    self.title = @"员工管理";
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    [self setRightBtns];
    
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
    
    label.text = @"请添加员工";
    
    self.noLabel = label;
    
    label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];
    
    [self requestShangPuArrayWithMemberID:memberID];
    
    [self requestPositionArrayWithMemberID:memberID];
    
    [self requestDengJiArrayWithMemberID:memberID];

}

- (void)requestShangPuArrayWithMemberID:(NSString *)memberid {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberid,@"memberID",
                                @"4",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.shangpuArray = dic[@"KuCunModelList"];
        
    }failure:^(NSError *error){
        
    }];
}

- (void)requestDengJiArrayWithMemberID:(NSString *)memberid {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberid,@"memberID",
                                @"7",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.levelArray = dic[@"KuCunModelList"];
        
    }failure:^(NSError *error){
        
    }];
}

- (void)requestPositionArrayWithMemberID:(NSString *)memberid {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberid,@"memberID",
                                @"5",@"keyType",
                                nil];
    
    [httpClient request:@"ErpKeValueList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        self.positionArray = dic[@"KuCunModelList"];
        
    }failure:^(NSError *error){
        
    }];
}

- (void)setRightBtns {

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(0, 0, 20, 20);
    
    [addBtn setImage:[UIImage imageNamed:@"sotckjia.png"] forState:UIControlStateNormal];
    
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    screenBtn.frame = CGRectMake(0, 0, 30, 20);
    
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [screenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addBarBtn = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    
    self.navigationItem.rightBarButtonItems = @[screenBarBtn,addBarBtn];
    
}

- (void)addBtnClick {

    AddStaffController *vc = [[AddStaffController alloc] init];
    
    vc.shangpuArray = self.shangpuArray;
    
    vc.positionArray = self.positionArray;
    
    vc.levelArray = self.levelArray;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self requestData];
    
}

- (void)screenBtnClick {

    NSLog(@"筛选");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.staffArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AdminCell *cell = [[AdminCell alloc] init];
    
    NSDictionary *dic = self.staffArr[indexPath.row];
    
    cell.nameLab.text = dic[@"RealName"];
    
    cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"PhotoBigUrl"]]]];
    
    cell.titleLab.text = dic[@"RoleDes"];
    
    cell.telLab.text = dic[@"MerchantShopName"];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    AdminCell *cell = [[AdminCell alloc] init];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    NSDictionary *dic = self.staffArr[indexPath.row];
    
    EditStaffController *vc = [[EditStaffController alloc] init];
    
    vc.memberID = memberId;
    
    vc.yuanGongID = dic[@"YuanGongID"];
    
    vc.merchantShopID = dic[@"MerchantShopID"];
    
    vc.realName = dic[@"RealName"];
    
    vc.role = dic[@"Role"];
    
    vc.zhiWeiID = dic[@"ZhiWeiID"];
    
    vc.nickName = dic[@"NickName"];
    
    vc.phone = dic[@"Phone"];
    
    vc.account = dic[@"Account"];
    
    vc.touXiangImage = dic[@"PhotoBigUrl"];
    
    vc.jiBenGongZi = dic[@"JiBenGongZi"];
    
    vc.yongJinLevelID = dic[@"YongJinLevelID"];
    
    vc.YongJinLevelMengCheng = dic[@"YongJinLevelMengCheng"];
    
    vc.shangpuArray = self.shangpuArray;
    
    vc.positionArray = self.positionArray;
    
    vc.levelArray = self.levelArray;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpYuanGongList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"YuanGongModelList"];
        
        if (trueArr.count == 0) {
            
            self.noLabel.hidden = NO;
            
            self.tableView.hidden = YES;
            
        }else {
            
            self.noLabel.hidden = YES;
            
            self.tableView.hidden = NO;
            
            self.staffArr = trueArr;
            
            [self.tableView reloadData];
            
        }
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
