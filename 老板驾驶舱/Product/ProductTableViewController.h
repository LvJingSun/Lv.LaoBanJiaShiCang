//
//  ProductTableViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-18.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "PullTableView.h"
#import "BaseViewController.h"

@interface ProductTableViewController : BaseViewController<PullTableViewDelegate>
{

int  P_pageIndex;//页数；

int P_searchType;

}

@property (strong, nonatomic) NSString *itemType;//类型


@property (weak, nonatomic) IBOutlet PullTableView *B_ListTable;

@property (nonatomic,strong)NSMutableArray*productarray;

@property (nonatomic,strong)NSMutableArray*photoarray;

@property(nonatomic,strong)ImageCache *imagechage;

@end
