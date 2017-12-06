//
//  KuCunController.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "KuCunController.h"
#import "ScrollView.h"
#import "BtnView.h"
#import "BtnModel.h"
#import "StaffAdminController.h"
#import "SupplierAdminController.h"
#import "CustomerController.h"
#import "ProductController.h"
#import "SettingController.h"
#import "ManagerController.h"
#import "AppHttpClient.h"
#import "Type1Controller.h"


@interface KuCunController ()<UITableViewDelegate,UITableViewDataSource,BtnClickDelegate> {

    NSArray *yujingtishiArray;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *btnArray;

@property (nonatomic, weak) BtnView *btn1;

@property (nonatomic, weak) BtnView *btn2;

@property (nonatomic, weak) BtnView *btn3;

@property (nonatomic, weak) BtnView *btn4;

@property (nonatomic, weak) BtnView *btn5;

@property (nonatomic, weak) ScrollView *scrollview;

@end

@implementation KuCunController

-(NSArray *)btnArray {
    
    if (_btnArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BtnView.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            
            BtnModel *model = [[BtnModel alloc] initWithDict:dic];
            
            [tempArray addObject:model];
            
        }
        
        _btnArray = tempArray;
        
    }
    
    return _btnArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的库存";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableview = tableview;
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableview];
    
    [self initWithView];

}

- (void)initWithView {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 193)];
    
    view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    self.tableview.tableHeaderView = view;
    
    ScrollView *scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 2, self.view.bounds.size.width, 30)];
    
    self.scrollview = scrollView;
    
    scrollView.scrArray = yujingtishiArray;
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:scrollView];
    
    BtnView *btn1 = [[BtnView alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(self.scrollview.frame) + 2, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn1.model = self.btnArray[0];
    
    btn1.delegate = self;
    
    self.btn1 = btn1;
    
    [view addSubview:btn1];
    
    BtnView *btn2 = [[BtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 3, CGRectGetMaxY(self.scrollview.frame) + 2, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn2.model = self.btnArray[1];
    
    btn2.delegate = self;
    
    self.btn2 = btn2;
    
    [view addSubview:btn2];
    
    BtnView *btn3 = [[BtnView alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(btn1.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn3.model = self.btnArray[2];
    
    btn3.delegate = self;
    
    self.btn3 = btn3;
    
    [view addSubview:btn3];
    
    BtnView *btn4 = [[BtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 3, CGRectGetMaxY(btn2.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn4.model = self.btnArray[3];
    
    btn4.delegate = self;
    
    self.btn4 = btn4;
    
    [view addSubview:btn4];
    
    BtnView *btn5 = [[BtnView alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(btn3.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn5.model = self.btnArray[4];
    
    btn5.delegate = self;
    
    self.btn5 = btn5;
    
    [view addSubview:btn5];
    
    BtnView *btn6 = [[BtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 3, CGRectGetMaxY(btn4.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    [view addSubview:btn6];
}

- (void)BtnClickSelected:(BtnModel *)btnModel {
    
    if ([btnModel.title isEqualToString:@"供应商管理"]) {
        
        SupplierAdminController *staffCon = [[SupplierAdminController alloc] init];
        
        [self.navigationController pushViewController:staffCon animated:YES];
        
    }
    
    if ([btnModel.title isEqualToString:@"客户管理"]) {
        
        CustomerController *staffCon = [[CustomerController alloc] init];
        
        [self.navigationController pushViewController:staffCon animated:YES];
        
    }
    
    if ([btnModel.title isEqualToString:@"产品管理"]) {
        
        ProductController *staffCon = [[ProductController alloc] init];
        
        [self.navigationController pushViewController:staffCon animated:YES];
        
    }
    
    if ([btnModel.title isEqualToString:@"预警管理"]) {
        
        SettingController *vc = [[SettingController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if ([btnModel.title isEqualToString:@"产品类别"]) {
        
        Type1Controller *staffCon = [[Type1Controller alloc] init];
        
        [self.navigationController pushViewController:staffCon animated:YES];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated {

    [self requestData];
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpMainList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSDictionary *countDic = dic[@"MainInfoModel"];
        
        self.btn1.countLab.text = countDic[@"LeiBieShuLiang"];
        
        self.btn2.countLab.text = countDic[@"GongYingShangShuLiang"];
        
        self.btn3.countLab.text = countDic[@"KeHuShuLiang"];
        
        self.btn4.countLab.text = @"设置";
        
        [self.btn4.countLab setTextColor:[UIColor lightGrayColor]];
        
        self.btn5.countLab.text = countDic[@"ChanPinShuLiang"];
        
        NSArray *yujingArray = dic[@"YuJingInfoModelList"];
        
        NSMutableArray *YJArray = [NSMutableArray array];
        
        for (NSDictionary *dict in yujingArray) {
            
            [YJArray addObject:dict[@"YuJingMiaoShu"]];
            
        }
        
        yujingtishiArray = YJArray;
        
        NSUserDefaults *setArray = [NSUserDefaults standardUserDefaults];
        
        [setArray setObject:yujingtishiArray forKey:@"setArr"];
        
        [setArray synchronize];
        
        [self.tableview reloadData];
        
    }failure:^(NSError *error){
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}



@end
