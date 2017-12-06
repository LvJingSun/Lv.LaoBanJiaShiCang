//
//  UserInfoViewController.m
//  baozhifu
//
//  Created by mac on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "UserInfoViewController.h"

#import "FriendsCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

@interface UserInfoViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_sexImgV;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;



- (IBAction)callBtnClicked:(id)sender;

- (IBAction)sendMsgClicked:(id)sender;


@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"dic = %@",self.m_dic);
    [self setTitle:@"用户信息"];
    
    // 判断男女性别
    if ( [[self.m_dic objectForKey:@"Sex"] isEqualToString:@"Female"] ) {
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
        
    }else if ( [[self.m_dic objectForKey:@"Sex"] isEqualToString:@"Male"] ) {
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
        
    }else{
        
        
    }
    
    // 姓名赋值
    self.m_nameLabel.text = [NSString stringWithFormat:@"%@(%@)",[self.m_dic objectForKey:@"NickName"],[self.m_dic objectForKey:@"RealName"]];
    
    // 赋值图片
    NSString *path = [self.m_dic objectForKey:@"PhotoMidUrl"];
    
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
    
    // 设置tableView的footerView
    self.m_tableView.tableFooterView = self.m_footerView;
    
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"UserDetailsCellIdentifier";
    
    UserDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil];
        cell = (UserDetailsCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( indexPath.row == 0 ) {
        
        cell.m_titleLabel.text = @"手机号";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]];
   
    }else if ( indexPath.row == 1 ){
  
        cell.m_titleLabel.text = @"邮箱";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Email"]];

    }else if ( indexPath.row == 2 ){
        
        cell.m_titleLabel.text = @"注册时间";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"JoinedDate"]];
        
    }else if ( indexPath.row == 3 ){
        
        cell.m_titleLabel.text = @"状态";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InviteState"]];
        
    }else{
        
    }
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (IBAction)callBtnClicked:(id)sender {
    
    NSString *phone = [self.m_dic objectForKey:@"Account"];
    
    NSLog(@"%@",phone);
    
    // 调用此方法，进入通讯录后不返回程序  下面的方法将会返回程序当中
    //    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]];//telprompt
    //    [[UIApplication sharedApplication] openURL:phoneNumberURL];
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"本设备暂不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        
    }else{
        
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
        
    }

}

- (IBAction)sendMsgClicked:(id)sender {
    
    NSLog(@"%@",[self.m_dic objectForKey:@"Account"]);
    
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.body = @"";
        picker.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]]];
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"该设备不支持短信功能"];
    }

}

#pragma mark - MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            break;
        default:
            break;
    }
}



@end
