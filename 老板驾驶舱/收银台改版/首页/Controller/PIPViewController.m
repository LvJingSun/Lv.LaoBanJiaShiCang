//
//  PIPViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "PIPViewController.h"
#import "PIPrecordViewController.h"
#import "PIPincomeViewController.h"

#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "New_TiXianData.h"
#import "New_YuEFrame.h"
#import "New_YuECell.h"
#import "N_SYTrecordCell.h"

#import "N_RevenueViewController.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface PIPViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation PIPViewController
@synthesize PIPdic;

- (id)initWithStyle:(UITableViewStyle)style {
    
//    self = [super initWithStyle:style];

    if (self) {
        
    }
    
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {

        self.title = NSLocalizedString(@"保智付", @"1");
        
        self.tabBarItem.image = [UIImage imageNamed:@"PIP"];
        
        PIPdic=[[NSMutableDictionary alloc]initWithCapacity:0];
 
    }
    
    return self;
    
}

- (void)viewDidAppear:(BOOL)animated {

    self.tabBarController.title = self.title;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    
    [self getDataFromSever];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = TabBGCOLOR;
    
    [self initWithTableview];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;

}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count + 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        New_YuEFrame *frame = self.dataArray[indexPath.row];
        
        New_YuECell *cell = [[New_YuECell alloc] init];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
    
        N_SYTrecordCell *cell = [[N_SYTrecordCell alloc] init];
        
        if (indexPath.row == 1) {
            
            cell.titleLab.text = @"提现记录";
            
        }else if (indexPath.row == 2) {
        
            cell.titleLab.text = @"收支记录";
            
        }
        
        return cell;
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        New_YuEFrame *frame = self.dataArray[indexPath.row];
        
        return frame.height;
        
    }else {
    
        N_SYTrecordCell *cell = [[N_SYTrecordCell alloc] init];
        
        return cell.height;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    if (indexPath.row == 1) {
        
        New_YuEFrame *frame = self.dataArray[0];
        
        PIPrecordViewController *PIPrecordVC=[[PIPrecordViewController alloc] init];
        
        PIPrecordVC.tixianData = frame.dataModel;
        
        [self .navigationController pushViewController:PIPrecordVC animated:YES];
        
    }else if (indexPath.row == 2) {
        
//        PIPincomeViewController*PIPincomeVC=[[PIPincomeViewController alloc]initWithNibName:@"PIPincomeViewController" bundle:nil];
//        
//        [accountDefaults setInteger:indexPath.row forKey:@"PIPInEx"];//
        
        N_RevenueViewController *vc = [[N_RevenueViewController alloc] init];
        
        [self .navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

//获取卡号和提现数据
- (void)getDataFromSever {
    
    MainViewController*mainVC=[MainViewController shareobject];
    
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] ) {
        
        return;
        
    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
 
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           nil];

    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [httpClient request:@"BZF.ashx" parameters:param successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [handlJson[@"status"] boolValue];
        
        if (success)
        {
            
            [SVProgressHUD dismiss];
      
            NSDictionary *dic = handlJson[@"BZFInfo"];
            
            New_TiXianData *data = [[New_TiXianData alloc] initWithDict:dic];
            
            New_YuEFrame *frame = [[New_YuEFrame alloc] init];
            
            frame.dataModel = data;
            
            NSMutableArray *mut = [NSMutableArray array];
            
            [mut addObject:frame];
            
            self.dataArray = mut;
    
            [self.tableview reloadData];
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:handlJson[@"msg"]];
        }
        
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}

@end
