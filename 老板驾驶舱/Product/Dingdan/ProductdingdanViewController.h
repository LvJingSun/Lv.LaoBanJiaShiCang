//
//  ProductdingdanViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-28.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ProductData.h"
#import "BaseViewController.h"


@interface ProductdingdanViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)ProductDetailData*DingdanData;//传个产品ID过来
//@property(nonatomic,strong)NSMutableArray *Dingdangarray;

@property(nonatomic,strong) UILabel  *label;


@property (strong, nonatomic) NSString *itemType;
@property(nonatomic,strong)NSMutableArray *DingdangarrayNO;//未使用
@property(nonatomic,strong)NSMutableArray *DingdangarrayYES;//已使用

@end
