//
//  FriendsCell.h
//  baozhifu
//
//  Created by mac on 13-10-28.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_nickName;

@property (weak, nonatomic) IBOutlet UILabel *m_userName;

@property (weak, nonatomic) IBOutlet UILabel *m_status;

@property (weak, nonatomic) IBOutlet UILabel *m_timelabel;



@end


@interface InviteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_status;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

@property (weak, nonatomic) IBOutlet UIButton *m_lookBtn;

@end


@interface UserDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_titleDetailLabel;


@end