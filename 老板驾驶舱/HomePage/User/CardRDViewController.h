//
//  CardRDViewController.h
//  BusinessCenter
//
//  Created by 冯海强 on 15-5-14.
//  Copyright (c) 2015年 冯海强. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"

@interface CardRDViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>
{
    int m_pageIndex;
}

@property (nonatomic,weak) IBOutlet PullTableView*CardD_tableview;
@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;
@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;

@end
