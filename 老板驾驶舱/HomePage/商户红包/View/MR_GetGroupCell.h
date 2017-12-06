//
//  MR_GetGroupCell.h
//  BusinessCenter
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MR_GetGroupFrame;

@interface MR_GetGroupCell : UITableViewCell

+ (instancetype)MR_GetGroupCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) MR_GetGroupFrame *frameModel;

@end
