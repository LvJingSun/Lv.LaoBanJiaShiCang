//
//  YangCheBaoViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/8/18.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "YangCheBaoViewController.h"
#import "ZJScrollPageView.h"
#import "Y_GetViewController.h"
#import "Y_SendViewController.h"
#import "Y_TitleView.h"
#import "XieYiViewController.h"
#import "TiXingView.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface YangCheBaoViewController ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation YangCheBaoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self initWithTitleView];
    
    [self initWithScrollStyle];
    
    [self yanZheng];
    
}

//验证是否签订合同
- (void)yanZheng {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           nil];
    
    [httpClient request:@"Default_Red.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        NSString *yanzheng = [json valueForKey:@"IsYCB"];
        
        if (![yanzheng isEqualToString:@"养车宝已同意"]) {
            
            TiXingView *view = [[TiXingView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            
            view.icon.image = [UIImage imageNamed:@"car_yuan.png"];
            
            [view.sureBtn addTarget:self action:@selector(tongyiRequest) forControlEvents:UIControlEventTouchUpInside];
            
            [view.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *fensibaoExtension = [defaults objectForKey:@"yangchebao_extension"];
            
            view.xieyiTextView.text = fensibaoExtension;
            
            [[[UIApplication sharedApplication].delegate window] addSubview:view];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//不签订协议返回上一页
- (void)backBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//签订合同
- (void)tongyiRequest {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"Firstlogin3.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:@"欢迎加入养车宝"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//自定义标题
- (void)initWithTitleView {
    
    Y_TitleView *view = [[Y_TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH * 0.6, 30)];
    
    self.navigationItem.titleView = view;
    
    view.titleBlock = ^{
        
        XieYiViewController *vc = [[XieYiViewController alloc] init];
        
        vc.type = @"2";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
}

//初始化分页控制器
- (void)initWithScrollStyle {
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    
    style.showLine = YES;
    
    style.gradualChangeTitleColor = YES;
    
    style.scrollTitle = NO;
    
    style.normalTitleColor = [UIColor colorWithRed:57/255. green:57/255. blue:57/255. alpha:1.];
    
    style.selectedTitleColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.];
    
    style.scrollLineColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.];
    
    style.segmentHeight = 40;
    
    style.titleFont = [UIFont systemFontOfSize:17];
    
    self.titles = @[@"充值",@"赠送"];
    
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    //原parentViewController——[self getCurrentViewController]
    //现改为self，后面view可以push页面
    
    [self.view addSubview:scrollPageView];
    
}

- (NSInteger)numberOfChildViewControllers {
    
    return self.titles.count;
    
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (index == 0) {
        
        childVc = [[Y_GetViewController alloc] init];
        
        childVc.view.backgroundColor = [UIColor whiteColor];
        
    }else if (index == 1) {
        
        childVc = [[Y_SendViewController alloc] init];
        
        childVc.view.backgroundColor = [UIColor whiteColor];
        
    }
    
    return childVc;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
