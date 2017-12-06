//
//  MerchantRechargeViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/9/28.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MerchantRechargeViewController.h"
#import "RechargeHeader.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "CommonUtil.h"
#import "WXApi.h"
#import "payRequsestHandler.h"

@interface MerchantRechargeViewController () <WXApiDelegate> {
    
    NSString *rechargeOrder;
    
    float min_count;
    
}

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *needCountLab;

@property (nonatomic, weak) UILabel *noticeLab;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation MerchantRechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    min_count = 0.00;
    
    [self requestData];

    self.title = @"充值";
    
    UILabel *needCount = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth * 0.05, 10, ScreenWidth * 0.9, 30)];
    
    self.needCountLab = needCount;
    
    needCount.textColor = [UIColor redColor];
    
    needCount.font = [UIFont systemFontOfSize:16];
    
    needCount.text = @"下周需要发放0元，需要充值0元";
    
    [self.view addSubview:needCount];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 10 + CGRectGetMaxY(needCount.frame), ScreenWidth, 50)];
    
    self.countField = field;
    
    field.backgroundColor = [UIColor whiteColor];
    
    field.font = [UIFont systemFontOfSize:15];
    
    field.placeholder = @"请输入充值金额";
    
    field.keyboardType = UIKeyboardTypeDecimalPad;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    lab.text = @"充值金额：";
    
    lab.textColor = [UIColor darkTextColor];
    
    lab.font = [UIFont systemFontOfSize:16];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    field.leftViewMode = UITextFieldViewModeAlways;
    
    field.leftView = lab;
    
    [self.view addSubview:field];
    
    UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(field.frame) + 10, ScreenWidth, 15)];
    
    self.noticeLab = notice;
    
    notice.textAlignment = NSTextAlignmentRight;
    
    notice.text = @"充值金额不得低于0元（目前仅支持微信支付）";
    
    notice.font = [UIFont systemFontOfSize:12];
    
    notice.textColor = [UIColor darkGrayColor];
    
    [self.view addSubview:notice];
    
    UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth * 0.1, CGRectGetMaxY(field.frame) + 100, ScreenWidth * 0.8, 50)];
    
    self.sureBtn = surebtn;
    
    [surebtn setBackgroundColor:ThemeColor];
    
    [surebtn setTitle:@"确认充值" forState:0];
    
    [surebtn setTitleColor:[UIColor whiteColor] forState:0];
    
    surebtn.layer.masksToBounds = YES;
    
    surebtn.layer.cornerRadius = 8;
    
    [surebtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:surebtn];
    
    // 添加微信支付成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestForSuccess) name:@"MenuPaySuccessKey" object:nil];
    
}

//支付成功调用接口
- (void)requestForSuccess {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"'%@'",rechargeOrder],@"ordernumber",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [SVProgressHUD show];
    
    [http request:@"AddVip_Order_OK.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"充值失败！"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"充值失败！"];
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyBoard];
    
}

- (void)sureBtnClick {
    
    [self hideKeyBoard];
    
    if ([self.countField.text isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入充值金额"];
        
    }else if ([self.countField.text floatValue] < min_count) {
        
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"充值金额不得低于%.2f元！",min_count]];
        
    }else {
        
        [self creatOrder];
        
    }
    
}

- (void)requestData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *Merchant_ID = [userDefau objectForKey:@"Merchant_ID"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         Merchant_ID,@"merchantid",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"Balance_prompt.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.needCountLab.text = [NSString stringWithFormat:@"下周需要发放%@元，需要充值%@元",[json valueForKey:@"balance_nextweek"],[json valueForKey:@"balance_left"]];
            
            self.noticeLab.text = [NSString stringWithFormat:@"充值金额不得低于%@元（目前仅支持微信支付）",[json valueForKey:@"min_balance"]];
            
            min_count = [[json valueForKey:@"min_balance"] floatValue];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"充值金额信息请求失败！"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"充值金额信息请求失败！"];
        
    }];
    
}

//生成微信订单
- (void)creatOrder {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         [NSString stringWithFormat:@"%@",self.countField.text],@"price", nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"订单生成中..."];
    
    [http request:@"AddVip_Order.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            rechargeOrder = [NSString stringWithFormat:@"%@",[json valueForKey:@"ordenumber"]];
            
            [self WeChatRechargeRequest];
            
            [SVProgressHUD dismiss];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"订单生成失败，请稍后再试！"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"订单生成失败，请稍后再试！"];
        
    }];
    
}

//微信充值
- (void)WeChatRechargeRequest {
    
    // 判断是否安装了微信
    if ( [WXApi isWXAppInstalled] ) {
        
        // 点击去支付后将数据保存起来用于微信支付的赋值
        [CommonUtil addValue:[NSString stringWithFormat:@"%@",@"老板驾驶舱余额充值"] andKey:WEIXIN_NAME];
        [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.countField.text] andKey:WEIXIN_PRICE];
        [CommonUtil addValue:rechargeOrder andKey:WEIXIN_OREDENO];
        
        // 表示是点单购买
        [CommonUtil addValue:@"3" andKey:WEIXIN_PAYTYPE];
        
        
        //创建支付签名对象
        payRequsestHandler *req = [payRequsestHandler alloc];
        //初始化支付签名对象
        [req init:APP_ID mch_id:MCH_ID];
        //设置密钥
        [req setKey:PARTNER_ID];
        
        //}}}
        
        //获取到实际调起微信支付的参数后，在app端调起支付
        NSMutableDictionary *dict = [req sendPay_demo];
        
        if(dict == nil){
            //错误提示
            NSString *debug = [req getDebugifo];
            
            [SVProgressHUD showErrorWithStatus:debug];
            
        }else{
            
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [dict objectForKey:@"appid"];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            
            [WXApi sendReq:req];
        }
        
    }else{
        // 微信没有安装
        [SVProgressHUD showErrorWithStatus:@"您没有安装微信"];
        
    }
    
}


- (void)hideKeyBoard {
    
    if ([self.countField isFirstResponder]) {
        
        [self.countField resignFirstResponder];
        
    }
    
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
