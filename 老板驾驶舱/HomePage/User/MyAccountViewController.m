//
//  MyAccountViewController.m
//  baozhifu
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MyAccountViewController.h"

#import "UserInfoViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

//#import "FriendsCell.h"

//#import "ExplanationViewController.h"

#import "MyAccountCell.h"

#import "SendSMSViewController.h"
#import "CardRLViewController.h"

@interface MyAccountViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIView *m_validateView;

@property (weak, nonatomic) IBOutlet UIView *m_bvtnView;

@property (weak, nonatomic) IBOutlet UIButton *m_selectedBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_UserCount;

// 全选按钮触发的事件
- (IBAction)selectedAllUser:(id)sender;

// 申请成为公众邀请码
//- (IBAction)applicationValidate:(id)sender;


// 发短信
- (IBAction)sendSMS:(id)sender;
// 发短信
- (IBAction)sendEmail:(id)sender;

@end

@implementation MyAccountViewController

@synthesize m_userArray;

@synthesize isCheckedAll;

@synthesize m_dic;

@synthesize m_accountArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_userArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;
        
        isCheckedAll = NO;
        
        m_accountArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    [self setTitle:@"我的用户"];
    
//    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
//    [addButton setTitle:@"会员卡记录" forState:UIControlStateNormal];
//    [addButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
//    [addButton setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
//    [addButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [addButton addTarget:self action:@selector(MyCardRecord) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
//    self.navigationItem.rightBarButtonItem = _addFriendItem;
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    
    self.m_tableView.hidden = YES;
    self.m_validateView.hidden = YES;
    self.m_bvtnView.hidden = YES;
    
    self.m_tableView.frame = CGRectMake(0, 48, viewsize.size.width, viewsize.size.height-92);
    // 验证登录的用户是否申请过公众邀请码
//    [self requestValidateCode];
    
    [self userLoadData];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.m_userArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"MyAccountCellIdentifier";
   
    //初始化cell并指定其类型，也可自定义cell
    MyAccountCell *cell = (MyAccountCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"MyAccountCell" owner:self options:nil];
        
        cell = (MyAccountCell *)[array objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 添加分割线
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
        
        imgV.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:0.5];
        
        [cell addSubview:imgV];
        
    }
    
    if ( self.m_userArray.count != 0 ) {
        
        NSUInteger row = [indexPath row];
        NSDictionary *item = [self.m_userArray objectAtIndex:row];
        
        // 账号和手机号
        cell.m_accountlabel.text = [NSString stringWithFormat:@"%@", [item objectForKey:@"NickName"]];
        
        cell.m_phoneLabel.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"Account"]];
        
        cell.m_selectedbnt.tag = indexPath.row;
        [cell.m_selectedbnt addTarget:self action:@selector(selectedAccount:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSString *Account = [item objectForKey:@"Account"];
        
        NSString *string = [self.m_dic objectForKey:[NSString stringWithFormat:@"%@",Account]];
        
        // 判断是否全选
        if ( [string isEqualToString:@"0"] ) {
            
            cell.m_selectedbnt.selected = NO;
            
        }else{
            
            cell.m_selectedbnt.selected = YES;
            
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dic = [self.m_userArray objectAtIndex:indexPath.row];
    
    // 进入个人信息的页面
    UserInfoViewController *VC = [[UserInfoViewController alloc]initWithNibName:@"UserInfoViewController" bundle:nil];
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    pageIndex = 1;
    
    [self userLoadData];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    pageIndex++;
    
    // 用户请求数据
    [self performSelector:@selector(userLoadData) withObject:nil];
    
}


// 判断登录的用户是否生成过公众邀请码的请求
//- (void)requestValidateCode{
//    
//    // 判断网络是否存在
//    if ( ![self isConnectionAvailable] ) {
//        
//        return;
//    }
//    
//    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key=@"";
//    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,     @"memberid",
//                           key,   @"key",
//                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
//    [httpClient request:@"PublicInviteIsExist.ashx" parameters:param success:^(NSJSONSerialization* json) {
//        BOOL success = [[json valueForKey:@"status"] boolValue];
//        if (success) {
//            [SVProgressHUD dismiss];
//          
//            // 验证申请了公众邀请码后请求用户列表的信息
//            [self userLoadData];
//        
//            
//        } else {
//            
//            NSString *msg = [json valueForKey:@"msg"];
//            //            [SVProgressHUD showErrorWithStatus:msg];
//            
//            // 1表示用户信息丢失，请重新登录 2表示没有申请公众邀请码
//            if ( [msg isEqualToString:@"1"] ) {
//                
//                [SVProgressHUD showErrorWithStatus:@"用户信息丢失，请重新登录"];
//                
//                
//            }else  if ( [msg isEqualToString:@"2"] ) {
//                
//                [SVProgressHUD dismiss];
//                
//                self.m_validateView.hidden = NO;
//                
//                self.m_tableView.hidden = YES;
//                
//                self.m_bvtnView.hidden = YES;
//
//                
//            }else{
//                
//                [SVProgressHUD showErrorWithStatus:msg];
//                
//                self.m_validateView.hidden = NO;
//                
//                self.m_bvtnView.hidden = YES;
//                
//                self.m_tableView.hidden = YES;
//                
//            }
//            
//        }
//    } failure:^(NSError *error) {
//        //NSLog(@"failed:%@", error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//    }];
//    
//}

// 用户的数据请求网络
- (void)userLoadData {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    NSString *key=@"";

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    // inviteState（邀请中Invitation、已加入Joined）
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%ld", (long)pageIndex],   @"pageIndex",
                           nil];
    NSLog(@"aaa%@",param);
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberPublicInviteList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *resultList = [json valueForKey:@"MemPublicInviteList"];
            
            NSLog(@"用户：：%@",resultList);
            
            if (pageIndex == 1) {
                if (resultList == nil || resultList.count == 0) {
                    [self.m_userArray removeAllObjects];
                    
                    [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_bvtnView.hidden = YES;
                    
                    self.m_validateView.hidden = NO;
                    
                    return;
                    
                } else {
                    
                    self.m_userArray = resultList;
                    
                    self.m_validateView.hidden = YES;
                    
                    self.m_bvtnView.hidden = NO;

                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                
                self.m_tableView.hidden = NO;
                
                self.m_bvtnView.hidden = NO;
                
                self.m_validateView.hidden = YES;

                
                if (resultList == nil || resultList.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_userArray addObjectsFromArray:resultList];
                }
            }
            
            if ( self.m_accountArray.count != 0 ) {
                
                [self.m_accountArray removeAllObjects];

            }
            
            // 默认存储的是未选中 0
            for (int i = 0; i < self.m_userArray.count; i ++) {
                
                // 判断是否全选
                if ( self.isCheckedAll ) {
                    
                    NSMutableDictionary *dic = [self.m_userArray objectAtIndex:i];
                    
                    [self.m_dic setValue:@"1" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]]];
                    
                    self.m_UserCount.hidden = NO;
                    
                    self.m_UserCount.text = [NSString stringWithFormat:@"已选%i人",self.m_userArray.count];
                    
                    [self.m_accountArray addObject:dic];

                    
                }else{
                    
                    NSMutableDictionary *dic = [self.m_userArray objectAtIndex:i];
                    
                    self.m_UserCount.hidden = YES;

                    [self.m_dic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]]];
                }
                
              
            }
            
            [self.m_tableView reloadData];
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
}


//- (IBAction)applicationValidate:(id)sender {
//    
//    // 进入申请公众邀请码的说明页面
//    ExplanationViewController *VC = [[ExplanationViewController alloc]initWithNibName:@"ExplanationViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];
//    
//}


- (IBAction)selectedAllUser:(id)sender {
    
    // 全选
    self.isCheckedAll = !self.isCheckedAll;
    
    // 先清空数据后加入
    [self.m_accountArray removeAllObjects];
    
    for (int i = 0; i < self.m_userArray.count; i++) {
        
        NSMutableDictionary *dic = [self.m_userArray objectAtIndex:i];
        
        if ( self.isCheckedAll ) {
            
            self.m_selectedBtn.selected = YES;
            
            [self.m_dic setValue:@"1" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]]];
            
            // 将数据添加到字典里面
            [self.m_accountArray addObject:dic];
            
            self.m_UserCount.hidden = NO;
            
            self.m_UserCount.text = [NSString stringWithFormat:@"已选%i人",self.m_accountArray.count];

            
        }else{
            
            self.m_selectedBtn.selected = NO;
            
            [self.m_dic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]]];
            
            // 删除所有的数据
            [self.m_accountArray removeAllObjects];
            
            self.m_UserCount.hidden = YES;
            
        }
    }
    
    
    [self.m_tableView reloadData];
}

- (void)selectedAccount:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 选中某个用户
    NSMutableDictionary *dic = [self.m_userArray objectAtIndex:btn.tag];
    
    if ( btn.selected ) {
        
        [self.m_dic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]]];
        
        NSString *Account = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]];
        
        for (int i = 0; i < self.m_accountArray.count; i ++) {
            NSMutableDictionary *l_dic = [self.m_accountArray objectAtIndex:i];
            NSString *l_Account = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"Account"]];
            
            if ( [l_Account isEqualToString:Account] ) {
                
                [self.m_accountArray removeObject:l_dic];
            }
            
        }
        
    }else{
        
        [self.m_dic setValue:@"1" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]]];
        
        // 添加对应的数据
        [self.m_accountArray addObject:dic];
        
    }
    
    // 判断如果选中的按钮等于全选的话，则全选的按钮被选中，反之未选中
    if ( self.m_accountArray.count == self.m_userArray.count ) {
        
        self.m_selectedBtn.selected = YES;
        
        self.isCheckedAll = YES;
        
    }else{
        
        self.m_selectedBtn.selected = NO;
        
        self.isCheckedAll = NO;
        
    }
    
    // 判断label是否隐藏
    if ( self.m_accountArray.count != 0 ) {
        
        self.m_UserCount.hidden = NO;
        
        self.m_UserCount.text = [NSString stringWithFormat:@"已选%i人",self.m_accountArray.count];

    }else{
        
         self.m_UserCount.hidden = YES;
    }
    
    [self.m_tableView reloadData];
    
}

// 发短信
- (IBAction)sendSMS:(id)sender{
    
    if ( self.m_accountArray.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请先选择用户"];
        
        return;
    }
    
     NSString *phoneString = @"";
    
    if ( self.m_accountArray.count == 1 ) {
        
        NSMutableDictionary *dic = [self.m_accountArray objectAtIndex:0];

        NSString *phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]];

        phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@"%@",phone]];
        
    }else{
        
        for (int i = 0; i < self.m_accountArray.count; i++) {
            
            NSMutableDictionary *dic = [self.m_accountArray objectAtIndex:i];
            
            NSString *phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]];
            
            if ( i == self.m_accountArray.count - 1 ){
                
                phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@"%@",phone]];
                
            }else{
                
                phoneString = [phoneString stringByAppendingString:[NSString stringWithFormat:@"%@,",phone]];
                
            }
            
            
        }
        
    }
    
    // 进入发送短信的页面
    SendSMSViewController *VC = [[SendSMSViewController alloc]initWithNibName:@"SendSMSViewController" bundle:nil];
    VC.m_typeString = @"1";
    VC.m_phone = [NSString stringWithFormat:@"%@",phoneString];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

// 发短信
- (IBAction)sendEmail:(id)sender{
    
    if ( self.m_accountArray.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请先选择用户"];
        
        return;
    }
    
    NSString *emailString = @"";
    
    if ( self.m_accountArray.count == 1 ) {
        
        NSMutableDictionary *dic = [self.m_accountArray objectAtIndex:0];
        
        NSString *email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]];
        
        emailString = [emailString stringByAppendingString:[NSString stringWithFormat:@"%@",email]];
        
    }else{
        
        for (int i = 0; i < self.m_accountArray.count; i++) {
            
            NSMutableDictionary *dic = [self.m_accountArray objectAtIndex:i];
            
            NSString *email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberId"]];
            
            if ( i == self.m_accountArray.count - 1 ){
                
                emailString = [emailString stringByAppendingString:[NSString stringWithFormat:@"%@",email]];
                
            }else{
                
                emailString = [emailString stringByAppendingString:[NSString stringWithFormat:@"%@,",email]];
                
            }
            
            
        }
        
    }
    
    // 进入发送邮件的页面
    SendSMSViewController *VC = [[SendSMSViewController alloc]initWithNibName:@"SendSMSViewController" bundle:nil];
    VC.m_typeString = @"2";
    VC.m_email = [NSString stringWithFormat:@"%@",emailString];
    [self.navigationController pushViewController:VC animated:YES];

    
}



-(void)MyCardRecord{

    CardRLViewController *VC = [[CardRLViewController alloc]initWithNibName:@"CardRLViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];


}

@end
