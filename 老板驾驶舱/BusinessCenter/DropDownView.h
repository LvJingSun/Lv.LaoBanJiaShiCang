//
//  DropDownView.h
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnSender)(UIButton *sender);

@interface DropDownView : UIView

- (id)initWithTitleArray:(NSArray *)titleArray;

- (void)show;

- (void)dismissAlert;

@property (nonatomic, copy) ReturnSender returnsender;

- (void)ReturnBlock:(ReturnSender)block;

@property (nonatomic, copy) dispatch_block_t didClickBlock;

@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end
