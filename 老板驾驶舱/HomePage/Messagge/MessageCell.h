//
//  MessageCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface MessageCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel*Message_titlelabel;//信息标题
@property(nonatomic,weak)IBOutlet UILabel*Message_contenttextview;//内容
@property(nonatomic,weak)IBOutlet UILabel*Message_timelabel;//时间

@end
