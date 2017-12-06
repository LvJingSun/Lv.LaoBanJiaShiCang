//
//  HomePageViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ImageCache.h"

@interface HomePageViewController : UIViewController
{
    int first;

    
    
    NSMutableArray*HP_accountArray;//首页账户
    NSMutableArray*HP_imcomeArray;//收入
    NSMutableArray*HP_informationArray;//信息
    NSMutableArray*HP_saleArray;//销售
    
    ImageCache *imageCache;
    
    
    NSString* TotalNoReadMsgSys;//系统
//    NSString* TotalNoReadRemind;//提醒
//    NSString* TotalNoReadPrivate;//私信
    NSString* TotalNoReadMsg;//总数
    NSString* Balance;//余额
    
    NSString* TodayIncome;//今日
    NSString* WeekIncome;//本周
    NSString* MonthIncome;//本月
    NSString* TMonthIncome;//三月
    
    
    
}


@property (nonatomic,strong) ImageCache *imageCache;
@property(nonatomic,weak)UIImageView* Homeimageview;



@end
