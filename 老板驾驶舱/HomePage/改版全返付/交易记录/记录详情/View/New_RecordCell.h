//
//  New_RecordCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class New_RecordFrame;

@interface New_RecordCell : UITableViewCell

+ (instancetype)Q_ljDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) New_RecordFrame *frameModel;

@end
