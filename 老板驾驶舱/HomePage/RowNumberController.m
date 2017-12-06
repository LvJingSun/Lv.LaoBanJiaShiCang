//
//  RowNumberController.m
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "RowNumberController.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"
#import <MJRefresh.h>
#import "AddRowController.h"
#import "StaffModel.h"
#import "RowNumCell.h"
#import "SetupController.h"
#import "SVProgressHUD.h"
#define BackColor [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]

@interface RowNumberController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) UILabel *NoLabel;

@end

@implementation RowNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"排号系统";
    
    self.view.backgroundColor = BackColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无数据";
    
    label.textColor = [UIColor lightGrayColor];
    
    self.NoLabel = label;
    
    [self.view addSubview:label];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - rectNav.size.height - rectStatus.size.height)];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    self.tableview = tableView;
    
    [self.view addSubview:tableView];
    
    [self setRightBtns];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
        
        self.tableview.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
        
        self.navigationItem.rightBarButtonItems = nil;
        
    }
    
    [SVProgressHUD showWithStatus:@"请求中..."];

    [self requestData];
    
}

- (void)rebackToRootViewAction {
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
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

//添加
- (void)addBtnClick {
    
    AddRowController *vc = [[AddRowController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//筛选
- (void)screenBtnClick {
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RowNumCell *cell = [[RowNumCell alloc] init];
    
    NSDictionary *dic = self.array[indexPath.row];
    
    cell.nameLab.text = dic[@"RealName"];
    
    cell.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"PhotoBigUrl"]]]];
    
    cell.titleLab.text = dic[@"ZhiWeiMingCheng"];
    
    cell.telLab.text = dic[@"Phone"];
    
    if ([dic[@"StatusDes"] isEqualToString:@"停排"]) {
        
        cell.statusIcon.hidden = NO;
        
        cell.statusIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"StatusIconUrl"]]]];
        
        cell.countLab.hidden = YES;
        
    }else if ([dic[@"StatusDes"] isEqualToString:@"点钟"]) {
        
        cell.statusIcon.hidden = YES;
        
        cell.countLab.hidden = YES;
        
        cell.statusLabel.text = dic[@"StatusDes"];
        
        cell.statusLabel.backgroundColor = [UIColor colorWithRed:0/255. green:255/255. blue:0/255. alpha:0.5];
        
        cell.statusLabel.layer.cornerRadius = 5;
        
        cell.statusLabel.layer.borderWidth = 1;
        
        cell.statusLabel.layer.borderColor = [UIColor colorWithRed:0/255. green:255/255. blue:0/255. alpha:0.5].CGColor;
    
    }else if ([dic[@"StatusDes"] isEqualToString:@"排钟"]) {
        
        cell.statusIcon.hidden = YES;
        
        cell.countLab.hidden = YES;
        
        cell.statusLabel.text = dic[@"StatusDes"];
        
        cell.statusLabel.backgroundColor = [UIColor colorWithRed:227/255. green:207/255. blue:87/255. alpha:0.5];
        
        cell.statusLabel.layer.cornerRadius = 5;
        
        cell.statusLabel.layer.borderWidth = 1;
        
        cell.statusLabel.layer.borderColor = [UIColor colorWithRed:227/255. green:207/255. blue:87/255. alpha:0.5].CGColor;
    
    }else {
        
        cell.statusIcon.hidden = YES;
        
        cell.countLab.hidden = NO;
        
        cell.countLab.text = dic[@"PaiXu"];
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.array[indexPath.row];
    
    SetupController *vc = [[SetupController alloc] init];
    
    vc.yuanGongID = dic[@"YuanGongID"];
    
    vc.iconImageUrl = dic[@"PhotoBigUrl"];
    
    vc.realName = dic[@"RealName"];
    
    vc.statusIconUrl = dic[@"StatusIconUrl"];
    
    vc.StatusDes = dic[@"StatusDes"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"memberID",
                                nil];
    
    [httpClient request:@"ErpPaiHaoList.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dic = (NSDictionary *)json;
        
        NSArray *trueArr = dic[@"YuanGongModelList"];
        
        if (trueArr.count == 0) {
            
            self.tableview.hidden = YES;
            
            self.NoLabel.hidden = NO;
            
        }else {
            
            self.tableview.hidden = NO;
            
            self.NoLabel.hidden = YES;
            
            self.array = trueArr;
            
            [self.tableview reloadData];
            
        }
        
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        
    }];
    
}

@end
