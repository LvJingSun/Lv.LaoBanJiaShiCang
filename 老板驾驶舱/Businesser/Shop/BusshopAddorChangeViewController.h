//
//  BusshopAddorChangeViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "BasicData.h"
@class TableViewWithBlock;



@interface BusshopAddorChangeViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIScrollView*BusinessAddorChange_scrollview;//查看修改店铺信息scroview
    int iphonenum;
    
    BOOL shopisOpened1;
    BOOL shopisOpened2;
    
    NSString *fatherindexrow;
    
    NSString *soonindexrow;
    
    
    NSString *option;//增加，编辑类别

}


@property (nonatomic,retain) IBOutlet TableViewWithBlock *shopdownTab1;
@property (nonatomic,retain) IBOutlet TableViewWithBlock *shopdownTab2;

@property(nonatomic,strong)ShopDetailData *shopDetailData;

@property(nonatomic,strong)NSMutableArray *S_fatherarray;
@property(nonatomic,strong)NSMutableArray *S_soonarray;



@end
