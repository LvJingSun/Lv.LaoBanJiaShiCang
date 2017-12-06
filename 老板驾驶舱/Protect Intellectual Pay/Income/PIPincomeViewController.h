//
//  PIPincomeViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PullTableView.h"

@interface PIPincomeViewController : UIViewController<UITextFieldDelegate,PullTableViewDelegate,UITabBarControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    IBOutlet UIView*PIPincome_view;
    
    UIView*dateview;
    
    int PI_pageindex;

    int  m_current;
    
    UILabel *label;

}

@property (weak, nonatomic) IBOutlet PullTableView *PIPincome_tableview;

@property(nonatomic,strong)NSMutableArray*PIPincomearray;

@property(nonatomic,strong)NSMutableArray*m_webViewArray;


@property (nonatomic, strong) UIDatePicker          *m_datePicker;
@property (nonatomic,weak) NSString *KeyString;
@property (nonatomic, strong) NSString              *m_dataString;
@property (nonatomic, strong) UIToolbar             *m_toolbar;
@property (nonatomic, assign) BOOL                  isSelected;

@end
