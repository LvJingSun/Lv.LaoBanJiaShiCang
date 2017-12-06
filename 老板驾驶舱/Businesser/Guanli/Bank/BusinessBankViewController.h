//
//  BusinessBankViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-22.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "BaseViewController.h"
@class TableViewWithBlock;

@interface BusinessBankViewController : BaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    IBOutlet UIScrollView*BusinessBank_scrollview;
    
    int iphonenum;
    BOOL BankisOpened1;
    BOOL BankisOpened2;
    
    
    NSString *orgCode;//银行代码
    
    IBOutlet UIButton *SaveBtn;
    
    int Banktimer;//验证码隔时间


}

@property (nonatomic,retain) IBOutlet TableViewWithBlock *BusinessBankdownTab1;
@property (nonatomic,retain) IBOutlet TableViewWithBlock *BusinessBankdownTab2;
@property (nonatomic,retain) IBOutlet TableViewWithBlock *BusinessBankweb;

@property (nonatomic,strong) NSDictionary *BankDataDic;//银行卡信息字典；

@property (nonatomic,strong) NSArray *Bankcodearray;//银行代码数组

@property (nonatomic,strong) NSMutableArray *Bankwebarray;//银行网点数组；

@end
