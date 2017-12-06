//
//  AccountController.m
//  BusinessCenter
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AccountController.h"
#import "GMDCircleLoader.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#define LINE_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]
#define size ([UIScreen mainScreen].bounds.size)

@interface AccountController (){

    NSString *account;
    
    NSString *password;
    
}

@property (nonatomic, weak) UITextField *accountField;

@property (nonatomic, weak) UITextField *passwordField;

@end

@implementation AccountController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithView];
    
}

- (void)initWithView {

    UILabel *biaoti1 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, 0, size.width * 0.15, 40)];
    
    biaoti1.textColor = [UIColor blackColor];
    
    biaoti1.text = @"账号";
    
    [self.view addSubview:biaoti1];
    
    UITextField *accountField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti1.frame), 0, size.width * 0.8, 40)];
    
    accountField.placeholder = @"收银员账号";
    
    accountField.text = self.account;
    
    self.accountField = accountField;
    
    [self.view addSubview:accountField];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaoti1.frame), size.width * 0.95, 1)];
    
    line2.backgroundColor = LINE_COLOR;
    
    [self.view addSubview:line2];
    
    UILabel *biaoti2 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line2.frame), size.width * 0.15, 40)];
    
    biaoti2.text = @"密码";
    
    [self.view addSubview:biaoti2];
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(biaoti2.frame), CGRectGetMaxY(line2.frame), size.width * 0.8, 40)];
    
    passwordField.placeholder = @"密码";
    
    self.passwordField = passwordField;
    
    [self.view addSubview:passwordField];
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(biaoti2.frame), size.width * 0.95, 1)];
    
    line3.backgroundColor = LINE_COLOR;
    
    [self.view addSubview:line3];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width * 0.05, CGRectGetMaxY(line3.frame) + 10, size.width * 0.9, 40)];
    
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [sureBtn setBackgroundColor:[UIColor colorWithRed:3/255. green:168/255. blue:226/255. alpha:1.]];
    
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    sureBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:sureBtn];
    
}

- (void)sureBtnClick {
    
    account = self.accountField.text;
    
    password = self.passwordField.text;

    if ([account isEqualToString:@""] || [password isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号或密码为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
    
        [GMDCircleLoader setOnView:self.view withTitle:@"正在提交员工信息" animated:YES];
        
        [self pushData];
        
    }
}

- (void)pushData {

    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *pardic = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.memberID,@"memberID",
                            self.yuanGongID,@"yuanGongID",
                            self.merchantShopID,@"merchantShopID",
                            account,@"account",
                            password,@"password",
                            self.realName,@"realName",
                            self.role,@"role",
                            self.zhiWeiID,@"zhiWeiID",
                            self.nickName,@"nickName",
                            self.phone,@"phone",
                            self.yongJinLevelID,@"yongJinLevelID",
                            self.jiBenGongZi,@"jiBenGongZi",
                            nil];
    
    [httpClient multiRequest:@"ErpYuanGongAdd.ashx" parameters:pardic files:self.touXiangDic success:^(NSJSONSerialization *json) {
        
        BOOL isSuccess = [((NSDictionary *)json)[@"status"] boolValue];
        
        if (isSuccess) {
            
            [GMDCircleLoader hideFromView:self.view animated:YES];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
        }else {
        
            [GMDCircleLoader hideFromView:self.view animated:YES];
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",((NSDictionary *)json)[@"msg"]]];

        }
  
    } failure:^(NSError *error) {
        
        [GMDCircleLoader hideFromView:self.view animated:YES];
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.accountField resignFirstResponder];
    
    [self.passwordField resignFirstResponder];
     
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}



@end
