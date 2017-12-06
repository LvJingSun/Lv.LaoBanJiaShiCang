//
//  InCome_List_Cell.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InCome_List_Frame;

@interface InCome_List_Cell : UITableViewCell

+ (instancetype)InCome_List_CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) InCome_List_Frame *frameModel;

@end
