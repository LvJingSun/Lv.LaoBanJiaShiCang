//
//  MR_GetCell.h
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MR_GetFrame;

@interface MR_GetCell : UITableViewCell

+ (instancetype)MR_GetCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) MR_GetFrame *frameModel;

@end
