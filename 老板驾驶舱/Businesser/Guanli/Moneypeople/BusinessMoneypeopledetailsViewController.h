//
//  BusinessMoneypeopledetailsViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "MoneypeopleData.h"
#import "BasicData.h"
@class TableViewWithBlock;
@interface BusinessMoneypeopledetailsViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>

{
    
    IBOutlet UIScrollView*BusinessMoneypeopledetails_scrollview;//查看修改收银员scroview

    int iphonenum;
    BOOL moneypeoisOpened;
    BOOL moneypeoisOpened2;
    
    int pickerorphoto;
}




@property (nonatomic,strong) IBOutlet TableViewWithBlock *moneypeodownTab;
@property (nonatomic,strong) IBOutlet TableViewWithBlock *moneypeodownTab2;


@property(nonatomic,strong)MoneypeopleDetailData*moneydetail;

@property(nonatomic,strong)NSMutableArray*moneydetailarray;//店铺数组

@end
