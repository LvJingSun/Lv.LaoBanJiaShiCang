//
//  R_StaffViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "R_StaffViewController.h"
#import "F_RoundView.h"
#import "F_RoundBottomView.h"

#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface R_StaffViewController ()

@property (nonatomic, weak) F_RoundView *roundview;

@property (nonatomic, weak) F_RoundBottomView *bottomview;

@end

@implementation R_StaffViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    F_RoundView *roundview = [[F_RoundView alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 200)];

    self.roundview = roundview;

    [self.view addSubview:roundview];

    F_RoundBottomView *bottomview = [[F_RoundBottomView alloc] init];
    
    self.bottomview = bottomview;
    
    bottomview.frame = CGRectMake(0, CGRectGetMaxY(roundview.frame), SCREENWIDTH, bottomview.height);
    
    [self.view addSubview:bottomview];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [self RequestForSendCount];
    
}

//请求员工赠送情况
- (void)RequestForSendCount {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *paeameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"MemID",
                                nil];
    
    [httpClient request:@"PieChartDataNew.ashx" parameters:paeameters success:^(NSJSONSerialization* json){
        
        NSDictionary *dic = (NSDictionary *)json;
        
        if ([dic[@"status"] boolValue]) {
            
            NSArray *array = dic[@"listMctList"];
            
            NSMutableArray *mut1 = [NSMutableArray array];
            
            NSMutableArray *mut2 = [NSMutableArray array];
            
            for (NSDictionary *dd in array) {
                
                [mut1 addObject:dd[@"Num"]];
                
                [mut2 addObject:dd[@"CashierName"]];
                
            }
            
            self.roundview.dataArr = mut1;
            
            self.bottomview.array = mut2;
            
        }else {
        
            self.roundview.dataArr = @[];
            
            self.bottomview.array = @[];
            
        }
        
    }failure:^(NSError *error){
        
    }];
    
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
