//
//  ActivitymemberCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"


@interface ActivitymemberCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView*Amemberimage;
@property(nonatomic,weak)IBOutlet UILabel*Amembernamelab;
@property(nonatomic,weak)IBOutlet UILabel*Amembersharelab;//分享关注

@end
