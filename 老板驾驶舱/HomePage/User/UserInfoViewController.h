//
//  UserInfoViewController.h
//  baozhifu
//
//  Created by mac on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"

#import <MessageUI/MessageUI.h>

@interface UserInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary  *m_dic;

@property (nonatomic, strong) UIWebView            *m_webView;

@end
