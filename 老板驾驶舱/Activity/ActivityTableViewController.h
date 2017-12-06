//
//  ActivityTableViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "PullTableView.h"
#import "BaseViewController.h"


@interface ActivityTableViewController : BaseViewController<PullTableViewDelegate>
{
    int  A_pageIndex;
    
    int  A_searchType;
    
}

@property (strong, nonatomic) NSString *itemType;//类型

@property (weak, nonatomic) IBOutlet PullTableView *B_ListTable;

@property(nonatomic,strong)NSMutableArray *Activityarray;
@property(nonatomic,strong)NSMutableArray *A_photoarray;

@property(nonatomic,strong)ImageCache *imagechage;

@end
