//
//  WwebViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-10.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface WwebViewController : UIViewController
{
    NSMutableArray*AdvertisementArray;//广告
    NSMutableArray*InformationArray;//资讯
    NSMutableArray*PhotoArray;//相册
}

@property(nonatomic,weak)NSString *Type;

@end
