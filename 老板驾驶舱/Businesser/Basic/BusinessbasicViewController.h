//
//  BusinessbasicViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "BaseViewController.h"

@class TableViewWithBlock;

@interface BusinessbasicViewController : BaseViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    IBOutlet UIScrollView*Businessbasic_scrollview;//基本信息scroview
    int iphonenum;
    
    BOOL jibenisOpened1;
    BOOL jibenisOpened2;
    
    NSString* fatherindexrow;
    
    
    int pickerorphoto;
    

}

@property (nonatomic,retain) IBOutlet TableViewWithBlock *jibendownTab1;
@property (nonatomic,retain) IBOutlet TableViewWithBlock *jibendownTab2;

@property(nonatomic,strong) NSMutableArray *B_Fatherarray;
@property(nonatomic,strong) NSMutableArray *B_Soonarray;

@property(nonatomic,strong) NSDictionary *BasicDic;

@property (nonatomic,strong) NSMutableDictionary *m_imagDic;

@end
