//
//  DropDownCell.h
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol DropDownClickDelegate <NSObject>
//
//- (void)TitleBtnClick:(UIButton *)sender;
//
//@end

@interface DropDownCell : UIView

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UIButton *clickBtn;

//@property (nonatomic, strong) id<DropDownClickDelegate> delegate;

@end
