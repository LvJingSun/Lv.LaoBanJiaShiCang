//
//  InComeCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface InComeCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel*InCome_moneylabel;//收入钱

@property(nonatomic,weak)IBOutlet UILabel*InCome_timelabel;//时间

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end
