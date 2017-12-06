//
//  DaoChuViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/1/3.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "DaoChuViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface DaoChuViewController ()<MFMailComposeViewControllerDelegate>

@property (nonatomic, copy) NSString *xuhao;

@property (nonatomic, copy) NSString *shuliang;

@property (nonatomic, copy) NSString *kehu;

@property (nonatomic, copy) NSString *jingbanren;

@property (nonatomic, copy) NSString *dianpu;

@property (nonatomic, copy) NSString *cuxiaoyuan;

@property (nonatomic, copy) NSString *shangpin;

@property (nonatomic, copy) NSString *riqi;

@end

@implementation DaoChuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *contentArray = [[NSMutableArray alloc] init];
    
    [contentArray addObject:@""];
    
    [contentArray addObject:@"序号"];
    
    [contentArray addObject:@"数量"];
    
    [contentArray addObject:@"客户"];
    
    [contentArray addObject:@"经办人"];
    
    [contentArray addObject:@"店铺"];
    
    [contentArray addObject:@"促销员"];
    
    [contentArray addObject:@"商品"];
    
    [contentArray addObject:@"日期"];
    
    [contentArray addObject:@"\n"];
    
    for (int i = 0; i < self.dateArr.count; i ++) {
        
        NSDictionary *dic = self.dateArr[i];
        
        [contentArray addObject:[NSString stringWithFormat:@"%d",i + 1]];
        
        [contentArray addObject:[NSString stringWithFormat:@"%@",dic[@"Jinzhongzi"]]];
        
        [contentArray addObject:[NSString stringWithFormat:@"%@",dic[@"Memberid"]]];
        
        [contentArray addObject:[NSString stringWithFormat:@"%@",dic[@"CashierAccountID"]]];
        
        [contentArray addObject:[NSString stringWithFormat:@"%@",dic[@"MerchantID"]]];
        
        [contentArray addObject:[NSString stringWithFormat:@"%@",dic[@"cuxiao"]]];
        
        [contentArray addObject:[NSString stringWithFormat:@"%@",dic[@"goodsname"]]];
        
        [contentArray addObject:[NSString stringWithFormat:@"%@",dic[@"CreateDate"]]];
        
        [contentArray addObject:@"\n"];
        
    }
    
    NSString *fileContent = [contentArray componentsJoinedByString:@"\t"];
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    
    NSData *filedata = [fileContent dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *document = [paths objectAtIndex:0];
    
    NSString *filepath = [document stringByAppendingPathComponent:@"赠送记录.xls"];
    
    [manager createFileAtPath:filepath contents:filedata attributes:nil];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 40, 40)];
    
    button.backgroundColor = [UIColor lightGrayColor];
    
    [button addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}



- (void)sendMessage {
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *document = [paths objectAtIndex:0];
    
    NSString *filepath = [document stringByAppendingPathComponent:@"赠送记录.xls"];

    NSData *data = [manager contentsAtPath:filepath];
    
    if (data) {
        
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        
        if (mailCompose) {
            
            [mailCompose setMailComposeDelegate:self];
            
            NSArray *toAddress = [NSArray arrayWithObject:@"876089831@qq.com"];
            
//            NSArray *ccAddress = [NSArray arrayWithObject:@"18118195178@163.com"];
            
            NSString *emailBody = @"<H1>日志信息</H1>";
            
            [mailCompose setToRecipients:toAddress];
            
//            [mailCompose setCcRecipients:ccAddress];
            
            [mailCompose setMessageBody:emailBody isHTML:YES];
            
            [mailCompose setSubject:@"主题"];
            
            [mailCompose addAttachmentData:data mimeType:@"xls" fileName:@"赠送记录.xls"];
            
            [self presentViewController:mailCompose animated:YES completion:nil];
            
        }
        
        return;
        
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            
            NSLog(@"cancle");
            
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            
            NSLog(@"baocun success");
//            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            
            NSLog(@"send success");
//            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            
            NSLog(@"faile");
//            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
