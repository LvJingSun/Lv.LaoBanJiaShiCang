//
//  PIPincomeCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface PIPincomeCell : UITableViewCell

//////
@property(nonatomic,weak)IBOutlet UILabel*PIPincome_moneylabelname;//收入金额Name
@property(nonatomic,weak)IBOutlet UILabel*PIPincome_explainlabelname;//说明Name

@property(nonatomic,weak)IBOutlet UILabel*PIPincome_moneylabel;//价钱
@property(nonatomic,weak)IBOutlet UIWebView*m_PIPwebView;//
@property(nonatomic,weak)IBOutlet UILabel*PIPincome_timelabel;//

@end
