//
//  GetListCell.h
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetFrameModel;

@interface GetListCell : UITableViewCell

+ (instancetype)GetListCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GetFrameModel *frameModel;

@end
