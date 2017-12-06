//
//  BusinessMoneypeopleViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"

@interface BusinessMoneypeopleViewController : UITableViewController

{
    int   M_pagindex;

    int arraycount;
    
    int once;

}


@property(nonatomic,strong)NSMutableArray*shoparray;

@property(nonatomic,strong)NSMutableArray *moneypeoplearray;


@property(nonatomic,strong)ImageCache*imagechage;


@property(nonatomic,strong)NSMutableDictionary*shopdic;//有几个店铺字典分类；再次分类

@end
