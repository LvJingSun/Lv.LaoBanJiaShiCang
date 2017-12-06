//
//  New_YuECell.h
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New_YuEFrame;

@interface New_YuECell : UITableViewCell

+ (instancetype)New_YuECellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) New_YuEFrame *frameModel;

@end
