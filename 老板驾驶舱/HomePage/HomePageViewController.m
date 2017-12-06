//
//  HomePageViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "HomePageViewController.h"
#import "InComeViewController.h"
#import "RemindsystemViewController.h"
#import "MessageViewController.h"
#import "SalesrecordViewController.h"
#import "MKNumberBadgeView.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import  "UIImageView+AFNetworking.h"
#import "BusinesserViewController.h"
#import "MyAccountViewController.h"
#import "MemberShipController.h"
#import "StockController.h"
#import "StaffAdminController.h"
#import "RowNumberController.h"
#import "PositionController.h"
#import "KuCunController.h"
#import "SettingController.h"
#import "LevelsController.h"
#import "BigBtnView.h"
#import "BigIncomeCell.h"
#import "ManagerController.h"
#import "JPUSHService.h"
#import "HuahuaViewController.h"
#import "XWAlterview.h"

#import "YangCheBaoViewController.h"
#import "F_HomeViewController.h"
#import "Y_NoMemberViewController.h"
#import "Home_PersonInfoCell.h"
#import "Home_InComeCell.h"
#import "MerchantRechargeViewController.h"
#import "MerchantRedBagViewController.h"
#import "BalanceRecordsViewController.h"
#import "InComeHeadView.h"
#import "InCome_List_ViewController.h"
#import "TiXian_ViewController.h"

@interface HomePageViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *type; //1-实时账户 2-红包账户
    
    NSString *shishiBalance;
    
    NSString *hongbaoBalance;
    
}

//账户数据
@property (nonatomic, strong) NSArray *InComeArray;

@property (nonatomic, weak) UITableView *HP_tableview;

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, weak) UIButton *rechargeBtn;

@end

@implementation HomePageViewController

@synthesize imageCache;

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self) {
        
    }
    return self;
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"首页", @"1");
        self.tabBarItem.image = [UIImage imageNamed:@"Home"];
        
    }
    return self;
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH , SCREENHEIGHT - 64)];
    
    self.HP_tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
}

- (void)viewDidAppear:(BOOL)animated;
{
    self.tabBarController.title=self.title;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self getDataFromServerNum];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    imageCache = [[ImageCache alloc]init];
    
    [self versionCheck];
    
    [self requestForFSBxieyi];
    
    [self requestForYCBxieyi];
    
    type = @"1";
    
    [self allocWithTableview];

}

- (void)versionCheck {
    
    //当前版本信息
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSError *error;
    
    NSString *urlstr = [NSString stringWithFormat:@"https:itunes.apple.com/lookup?id=789651951"];
    
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if (error) {
        
    }
    
    NSArray *array = [dic objectForKey:@"results"];
    
    if (![array count]) {
        
    }
    
    NSDictionary *infodic = [array objectAtIndex:0];
    
    NSString *appstoreVersion = [infodic objectForKey:@"version"];
    
    //下载链接
    NSString *downLoad = [infodic objectForKey:@"trackViewUrl"];

    if ([self CompareDemoVersion:version WithAppStoreVersion:appstoreVersion]) {
        
        XWAlterview *alert = [[XWAlterview alloc] initWithIcon:@"icon_.png" Content:@"老板驾驶舱新版本发布啦！功能更加优化，体验更棒！" Title:@"版本更新" Sure:@"立即下载"];
        
        alert.rightBlock = ^(){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoad]];
            
        };
        
        [alert show];
        
    }
    
    
}

- (BOOL)CompareDemoVersion:(NSString *)demoVersion WithAppStoreVersion:(NSString *)appstoreVersion {
    
    NSMutableArray *demoArr = [NSMutableArray arrayWithArray:[demoVersion componentsSeparatedByString:@"."]];
    
    NSMutableArray *appstoreArr = [NSMutableArray arrayWithArray:[appstoreVersion componentsSeparatedByString:@"."]];
    
    // 补全版本信息为相同位数
    while (demoArr.count < appstoreArr.count) {
        
        [demoArr addObject:@"0"];
        
    }
    while (appstoreArr.count < demoArr.count) {
        
        [appstoreArr addObject:@"0"];
        
    }
    
    BOOL compareResutl = NO;
    
    for(NSUInteger i = 0; i < demoArr.count; i++){
        
        NSInteger versionNumber1 = [demoArr[i] integerValue];
        
        NSInteger versionNumber2 = [appstoreArr[i] integerValue];
        
        if (versionNumber1 < versionNumber2) {
            
            compareResutl = YES;
            
            break;
            
        }else if (versionNumber2 < versionNumber1){
            
            compareResutl = NO;
            
            break;
            
        }else{
            
            compareResutl = NO;
            
        }
        
    }
    
    return compareResutl;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)requestForFSBxieyi {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1", @"type",
                           nil];
    
    [httpClient request:@"Agreement_2.ashx" parameters:param success:^(NSJSONSerialization* json)
     {
         NSString *fensibao_extension = [json valueForKey:@"Content"];
         
         fensibao_extension = [fensibao_extension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
         
         NSString *fensibao_title = [json valueForKey:@"Title"];
         
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         
         [defaults setObject:fensibao_extension forKey:@"fensibao_extension"];
         
         [defaults setObject:fensibao_title forKey:@"fensibao_title"];
         
     }
                failure:^(NSError *error)
     {
         [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
     }];
    
}

- (void)requestForYCBxieyi {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"2", @"type",
                           nil];
    
    [httpClient request:@"Agreement_2.ashx" parameters:param success:^(NSJSONSerialization* json)
     {
         NSString *fensibao_extension = [json valueForKey:@"Content"];
         
         fensibao_extension = [fensibao_extension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
         
         NSString *fensibao_title = [json valueForKey:@"Title"];
         
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         
         [defaults setObject:fensibao_extension forKey:@"yangchebao_extension"];
         
         [defaults setObject:fensibao_title forKey:@"yangchebao_title"];
         
     }
                failure:^(NSError *error)
     {
         [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
     }];
    
}

-(void)getDataFromServerNum
{
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                            [userDefau objectForKey:@"memberId"], @"memberId",
                           nil];
    
    [httpClient request:@"Default_Red.ashx" parameters:param success:^(NSJSONSerialization* json)
     {
         
         shishiBalance = [NSString stringWithFormat:@"¥%@",[json valueForKey:@"Balance"]];
         
         hongbaoBalance = [NSString stringWithFormat:@"¥%@",[json valueForKey:@"RedBalance"]];
         
         if ([type isEqualToString:@"1"]) {

             NSDictionary *dd1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"今日收入",@"title",
                                  [json valueForKey:@"TodayIncome"],@"count",
                                  nil];
             
             NSDictionary *dd2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"本周收入",@"title",
                                  [json valueForKey:@"WeekIncome"],@"count",
                                  nil];
             
             NSDictionary *dd3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"本月收入",@"title",
                                  [json valueForKey:@"MonthIncome"],@"count",
                                  nil];
             
             NSDictionary *dd4 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"近三月收入",@"title",
                                  [json valueForKey:@"TMonthIncome"],@"count",
                                  nil];
             
             NSMutableArray *mut = [NSMutableArray array];
             
             [mut addObject:dd1];
             
             [mut addObject:dd2];
             
             [mut addObject:dd3];
             
             [mut addObject:dd4];
             
             self.InComeArray = mut;
             
             self.balanceLab.text = shishiBalance;
             
             NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
             
             [self.HP_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
             
         }else if ([type isEqualToString:@"2"]) {

             NSDictionary *dd1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"今日收入",@"title",
                                  [json valueForKey:@"RedTodayIncome"],@"count",
                                  nil];
             
             NSDictionary *dd2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"本周收入",@"title",
                                  [json valueForKey:@"RedWeekIncome"],@"count",
                                  nil];
             
             NSDictionary *dd3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"本月收入",@"title",
                                  [json valueForKey:@"RedMonthIncome"],@"count",
                                  nil];
             
             NSDictionary *dd4 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"近三月收入",@"title",
                                  [json valueForKey:@"RedTMonthIncome"],@"count",
                                  nil];
             
             NSMutableArray *mut = [NSMutableArray array];
             
             [mut addObject:dd1];
             
             [mut addObject:dd2];
             
             [mut addObject:dd3];
             
             [mut addObject:dd4];
             
             self.InComeArray = mut;
             
             self.balanceLab.text = hongbaoBalance;
             
             NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
             
             [self.HP_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
             
         }

     }
        failure:^(NSError *error)
     {
         [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
     }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        
        InComeHeadView *headview = [[InComeHeadView alloc] init];
        
        return headview.height;
        
    }else if (section == 2) {
        
        return 20;
        
    }else {
        
        return 0;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        InComeHeadView *headview = [[InComeHeadView alloc] init];
        
        if ([type isEqualToString:@"1"]) {
            
            [headview.shishibtn setTitleColor:[UIColor redColor] forState:0];
            
            headview.shishiline.hidden = NO;
            
            [headview.hongbaobtn setTitleColor:[UIColor blackColor] forState:0];
            
            headview.hongbaoline.hidden = YES;
            
        }else if ([type isEqualToString:@"2"]) {
            
            [headview.shishibtn setTitleColor:[UIColor blackColor] forState:0];
            
            headview.shishiline.hidden = YES;
            
            [headview.hongbaobtn setTitleColor:[UIColor redColor] forState:0];
            
            headview.hongbaoline.hidden = NO;
            
        }
        
        __weak typeof(InComeHeadView) *weakView = headview;
        
        headview.shishiBlock = ^{
            
            if ([type isEqualToString:@"2"]) {
                
                type = @"1";
                
                [weakView.shishibtn setTitleColor:[UIColor redColor] forState:0];
                
                weakView.shishiline.hidden = NO;
                
                [weakView.hongbaobtn setTitleColor:[UIColor blackColor] forState:0];
                
                weakView.hongbaoline.hidden = YES;
                
                self.balanceLab.text = shishiBalance;
                
                [self.rechargeBtn setBackgroundColor:[UIColor colorWithRed:32/255. green:143/255. blue:250/255. alpha:1.]];
                
                [self.rechargeBtn setTitle:@"充值" forState:0];
                
            }
            
        };
        
        headview.hongbaoBlock = ^{
            
            if ([type isEqualToString:@"1"]) {
                
                type = @"2";
                
                [weakView.shishibtn setTitleColor:[UIColor blackColor] forState:0];
                
                weakView.shishiline.hidden = YES;
                
                [weakView.hongbaobtn setTitleColor:[UIColor redColor] forState:0];
                
                weakView.hongbaoline.hidden = NO;
                
                self.balanceLab.text = hongbaoBalance;
                
                [self.rechargeBtn setBackgroundColor:[UIColor redColor]];
                
                [self.rechargeBtn setTitle:@"提现" forState:0];
                
            }
            
        };
        
        return headview;
        
    }else {
        
        return nil;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return self.InComeArray.count;
    }

    else {
    
        return 1;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        Home_PersonInfoCell *cell = [[Home_PersonInfoCell alloc] init];
        
        return cell.height;
        
    }else if (indexPath.section == 2) {
    
        BigIncomeCell *cell = [[BigIncomeCell alloc] init];
        
        return cell.height;
        
    }else {
    
        Home_InComeCell *cell = [[Home_InComeCell alloc] init];
        
        return cell.height;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
            
        Home_PersonInfoCell *cell = [[Home_PersonInfoCell alloc] init];
        
        cell.titleLab.text = @"实时账户余额";
        
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhotoMidUrl_B"];
        
        cell.iconImg.image=[CommonUtil scaleImage:[NSKeyedUnarchiver unarchiveObjectWithData:imageData] toSize:CGSizeMake(70,70)];
        
        self.balanceLab = cell.balanceLab;
        
        self.rechargeBtn = cell.rechargeBtn;
        
        if ([type isEqualToString:@"1"]) {
            
            cell.balanceLab.text = shishiBalance;
            
            [cell.rechargeBtn setBackgroundColor:[UIColor colorWithRed:32/255. green:143/255. blue:250/255. alpha:1.]];
            
            [cell.rechargeBtn setTitle:@"充值" forState:0];
            
        }else if ([type isEqualToString:@"2"]) {
            
            cell.balanceLab.text = hongbaoBalance;
            
            [cell.rechargeBtn setBackgroundColor:[UIColor redColor]];
            
            [cell.rechargeBtn setTitle:@"提现" forState:0];
            
        }
        
        cell.rechargeBlock = ^{
            
            if ([type isEqualToString:@"1"]) {
                
                MerchantRechargeViewController *vc = [[MerchantRechargeViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([type isEqualToString:@"2"]) {
                
                TiXian_ViewController *vc = [[TiXian_ViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        cell.balanceBlock = ^{
            
            BalanceRecordsViewController *vc = [[BalanceRecordsViewController alloc] init];
            
            if ([type isEqualToString:@"1"]) {
                
                vc.type = @"1";
                
            }else if ([type isEqualToString:@"2"]) {
                
                vc.type = @"2";
                
            }
            
            [self.navigationController pushViewController:vc animated:YES];
            
        };
            
            return cell;
       
    }
    if (indexPath.section==1)
    {

        Home_InComeCell *cell = [[Home_InComeCell alloc] init];
        
        NSDictionary *dic = self.InComeArray[indexPath.row];
        
        cell.titleLab.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
        
        cell.countLab.text = [NSString stringWithFormat:@"%@",dic[@"count"]];
        
        return cell;

    }
    
    if (indexPath.section == 2) {
        
        BigIncomeCell *cell = [[BigIncomeCell alloc] init];
      
        [cell.yonghu.button addTarget:self action:@selector(yonghuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.kucun.button addTarget:self action:@selector(kucunBtnClick) forControlEvents:UIControlEventTouchUpInside];
      
        [cell.xiaoxi.button addTarget:self action:@selector(xiaoxiBtnClick) forControlEvents:UIControlEventTouchUpInside];
      
        [cell.xiaoshou.button addTarget:self action:@selector(xiaoshouBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
        [cell.huiyuanka.button addTarget:self action:@selector(huiyuankaBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
        [cell.yuangong.button addTarget:self action:@selector(yuangongBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
        [cell.paihao.button addTarget:self action:@selector(paihaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
      
        [cell.zhiwei.button addTarget:self action:@selector(zhiweiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.dengji.button addTarget:self action:@selector(dengjiBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.huahua.button addTarget:self action:@selector(huahuaClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.quanfanfu.button addTarget:self action:@selector(quanfanfuClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.yangchebao.button addTarget:self action:@selector(yangchebaoClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.merchantRed.button addTarget:self action:@selector(merchantRedClick) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else {
    
        return nil;
        
    }
   
}

- (void)merchantRedClick {
    
    MerchantRedBagViewController *vc = [[MerchantRedBagViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)yangchebaoClick {
    
    NSUserDefaults *userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *istype = [userDefau objectForKey:@"Istype"];
    
    NSString *IphoneUrl = [userDefau objectForKey:@"Iphone"];
    
    NSString *Phone = [userDefau objectForKey:@"Phone"];
    
    if ([istype isEqualToString:@"1"]) {
        
        YangCheBaoViewController *vc = [[YangCheBaoViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
    
        Y_NoMemberViewController *vc = [[Y_NoMemberViewController alloc] init];
        
        vc.urlString = IphoneUrl;
        
        vc.photoNum = Phone;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
  
}

- (void)quanfanfuClick {
    
    F_HomeViewController *vc = [[F_HomeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)huahuaClick {

    HuahuaViewController *vc = [[HuahuaViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)kucunBtnClick {

    ManagerController *vc = [[ManagerController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)yonghuBtnClick {

    MyAccountViewController*VC=[[MyAccountViewController alloc]initWithNibName:@"MyAccountViewController" bundle:nil];
    [self .navigationController pushViewController:VC animated:YES];
    
}

- (void)xiaoxiBtnClick {
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    int cc=3;
    [accountDefaults setInteger:cc forKey:@"Message"];//
    RemindsystemViewController*remindsystemVC=[[RemindsystemViewController alloc]initWithNibName:@"RemindsystemViewController" bundle:nil];
    [self .navigationController pushViewController:remindsystemVC animated:YES];
    [[NSUserDefaults standardUserDefaults] synchronize];//立即读取；
    
}

- (void)xiaoshouBtnClick {

    SalesrecordViewController*SalesrecordVC=[[SalesrecordViewController alloc]initWithNibName:@"SalesrecordViewController" bundle:nil];

    [self .navigationController pushViewController:SalesrecordVC animated:YES];
    
}

- (void)huiyuankaBtnClick {

    MemberShipController *memberShip = [[MemberShipController alloc] init];

    [self .navigationController pushViewController:memberShip animated:YES];
    
}

- (void)yuangongBtnClick {

    StaffAdminController *staffvc = [[StaffAdminController alloc] init];

    [self .navigationController pushViewController:staffvc animated:YES];
    
}

- (void)paihaoBtnClick {

    RowNumberController *staffvc = [[RowNumberController alloc] init];

    [self .navigationController pushViewController:staffvc animated:YES];
    
}

- (void)zhiweiBtnClick {

    PositionController *staffvc = [[PositionController alloc] init];

    [self .navigationController pushViewController:staffvc animated:YES];
    
}

- (void)dengjiBtnClick {

    LevelsController *staffvc = [[LevelsController alloc] init];

    [self .navigationController pushViewController:staffvc animated:YES];
    
}

//选中CELL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section==1) {
        
        InCome_List_ViewController *vc = [[InCome_List_ViewController alloc] init];

        if (indexPath.row == 0) {
            
            if ([type isEqualToString:@"1"]) {
                
                vc.type = @"1";
                
            }else if ([type isEqualToString:@"2"]) {
                
                vc.type = @"5";
                
            }
            
        }else if (indexPath.row == 1) {
            
            if ([type isEqualToString:@"1"]) {
                
                vc.type = @"2";
                
            }else if ([type isEqualToString:@"2"]) {
                
                vc.type = @"6";
                
            }
            
        }else if (indexPath.row == 2) {
            
            if ([type isEqualToString:@"1"]) {
                
                vc.type = @"3";
                
            }else if ([type isEqualToString:@"2"]) {
                
                vc.type = @"7";
                
            }
            
        }else if (indexPath.row == 3) {
            
            if ([type isEqualToString:@"1"]) {
                
                vc.type = @"4";
                
            }else if ([type isEqualToString:@"2"]) {
                
                vc.type = @"8";
                
            }
            
        }

        [self.navigationController pushViewController:vc animated:YES];

    }
    
}


@end
