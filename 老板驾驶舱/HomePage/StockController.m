//
//  StockController.m
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "StockController.h"
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

@interface StockController ()<BtnClickDelegate> {

    ScrollView *scrollView1;
}

@property (nonatomic, strong) NSArray *btnArray;

@property (nonatomic, weak) BtnView *btn1;

@property (nonatomic, weak) BtnView *btn2;

@property (nonatomic, weak) BtnView *btn3;

@property (nonatomic, weak) BtnView *btn4;

@property (nonatomic, weak) BtnView *btn5;

@end

@implementation StockController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"6"] style:UIBarButtonItemStyleDone target:self action:@selector(settingBtnClick)];
    
    ScrollView *scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 2, self.view.bounds.size.width, 30)];
    
    scrollView1 = scrollView;
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:scrollView];
    
    [self initWithBtns];
    
}

- (void)settingBtnClick {

    SettingController *vc = [[SettingController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)initWithBtns {
    
    BtnView *btn1 = [[BtnView alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(scrollView1.frame) + 2, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn1.model = self.btnArray[0];
    
    btn1.delegate = self;
    
    self.btn1 = btn1;
    
    [self.view addSubview:btn1];
    
    BtnView *btn2 = [[BtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 3, CGRectGetMaxY(scrollView1.frame) + 2, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn2.model = self.btnArray[1];
    
    btn2.delegate = self;
    
    self.btn2 = btn2;
    
    [self.view addSubview:btn2];
    
    BtnView *btn3 = [[BtnView alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(btn1.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn3.model = self.btnArray[2];
    
    btn3.delegate = self;
    
    self.btn3 = btn3;
    
    [self.view addSubview:btn3];
    
    BtnView *btn4 = [[BtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 3, CGRectGetMaxY(btn2.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn4.model = self.btnArray[3];
    
    btn4.delegate = self;
    
    self.btn4 = btn4;
    
    [self.view addSubview:btn4];
    
    BtnView *btn5 = [[BtnView alloc] initWithFrame:CGRectMake(3, CGRectGetMaxY(btn3.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    btn5.model = self.btnArray[4];
    
    btn5.delegate = self;
    
    self.btn5 = btn5;
    
    [self.view addSubview:btn5];
    
    BtnView *btn6 = [[BtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + 3, CGRectGetMaxY(btn4.frame) + 3, (self.view.bounds.size.width - 9) * 0.5, 50)];
    
    [self.view addSubview:btn6];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn5.frame) + 3, self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(btn5.frame) - 3)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
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
    
    if ([btnModel.title isEqualToString:@"库存管理"]) {
        
        ManagerController *staffCon = [[ManagerController alloc] init];
        
        [self.navigationController pushViewController:staffCon animated:YES];
        
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
        
        self.btn4.countLab.text = countDic[@"KuCunShuLiang"];
        
        self.btn5.countLab.text = countDic[@"ChanPinShuLiang"];
        
        NSArray *yujingArray = dic[@"YuJingInfoModelList"];
        
        NSMutableArray *YJArray = [NSMutableArray array];
        
        for (NSDictionary *dict in yujingArray) {
            
            [YJArray addObject:dict[@"YuJingMiaoShu"]];
            
        }
        
    }failure:^(NSError *error){
        
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
