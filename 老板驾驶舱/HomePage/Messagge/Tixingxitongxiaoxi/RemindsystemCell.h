//
//  RemindsystemCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface RemindsystemCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel*Remindsystem_titlelabel;//信息标题

@property(nonatomic,weak)IBOutlet UILabel*Remindsystem_timelabel;//时间

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end
