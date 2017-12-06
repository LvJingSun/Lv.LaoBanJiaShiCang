//
//  MR_Send_Cell.h
//  BusinessCenter
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MR_Send_Frame;

@interface MR_Send_Cell : UITableViewCell

+ (instancetype)MR_Send_CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) MR_Send_Frame *frameModel;

@end
