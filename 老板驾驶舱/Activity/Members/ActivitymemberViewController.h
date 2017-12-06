//
//  ActivitymemberViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ActivityData.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"
#import "PullTableView.h"

@interface ActivitymemberViewController : UITableViewController<PullTableViewDelegate>
{
    int pageIndex;
    
}

@property (weak, nonatomic) IBOutlet PullTableView *B_ListTable;

@property(nonatomic,strong)ActivityDetailData *activitydata;
@property(nonatomic,strong)NSMutableArray *memberarray;

@property(nonatomic,strong)ImageCache *imagechage;

@end
