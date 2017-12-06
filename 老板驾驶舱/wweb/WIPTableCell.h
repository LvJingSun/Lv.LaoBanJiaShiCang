//
//  WIPTableCell.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"
@interface WIPTableCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UIImageView*WIP_photoImage;//头像
@property(nonatomic,weak) NSString*photo;//头像

@property(nonatomic,weak)IBOutlet UILabel*WIP_NameTitleLable;//名称、标题
//说明
@property(nonatomic,weak)IBOutlet UILabel*WIP_MemberLablename;//中文说明：商户
@property(nonatomic,weak)IBOutlet UILabel*WIP_TimeLablename;//时间(创建、下架)

@property(nonatomic,weak)IBOutlet UILabel*WIP_MemberLable;//
@property(nonatomic,weak)IBOutlet UILabel*WIP_TimeLable;//时间






@end
