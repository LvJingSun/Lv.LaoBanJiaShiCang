//
//  BtnView.h
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BtnModel;

@protocol BtnClickDelegate <NSObject>

- (void)BtnClickSelected:(BtnModel *)btnModel;

@end

@interface BtnView : UIView

@property (nonatomic, strong) BtnModel *model;

@property (nonatomic, assign) id<BtnClickDelegate> delegate;

@property (nonatomic, weak) UILabel *countLab;


@end
