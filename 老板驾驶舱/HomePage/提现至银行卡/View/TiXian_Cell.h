//
//  TiXian_Cell.h
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TiXian_Frame;

@protocol TiXianDelegate <NSObject>

- (void)CountFieldChange:(UITextField *)field;

@end

@interface TiXian_Cell : UITableViewCell

+ (instancetype)TiXian_CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) TiXian_Frame *frameModel;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@property (nonatomic, strong) id<TiXianDelegate> delegate;

@end
