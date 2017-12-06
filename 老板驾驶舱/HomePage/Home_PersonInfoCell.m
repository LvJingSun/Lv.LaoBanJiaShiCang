//
//  Home_PersonInfoCell.m
//  BusinessCenter
//
//  Created by mac on 2017/9/28.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "Home_PersonInfoCell.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation Home_PersonInfoCell

+ (instancetype)Home_PersonInfoCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"Home_PersonInfoCell";
    
    Home_PersonInfoCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Home_PersonInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat iconX = SCREENWIDTH * 0.032;
        
        CGFloat iconY = 5;
        
        CGFloat iconW = 70;
        
        CGFloat iconH = iconW;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        CGFloat titleX = CGRectGetMaxX(icon.frame) + iconX;
        
        CGFloat titleY = 10;
        
        CGFloat titleW = SCREENWIDTH * 0.8 - titleX;
        
        CGFloat titleH = 20;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = titleLab;
        
        titleLab.textColor = [UIColor darkTextColor];
        
        titleLab.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:titleLab];
        
        CGFloat balanceX = titleX;
        
        CGFloat balanceY = CGRectGetMaxY(titleLab.frame) + 10;
        
        CGFloat balanceW = titleW;
        
        CGFloat balanceH = 35;
        
        UILabel *balanceLab = [[UILabel alloc] initWithFrame:CGRectMake(balanceX, balanceY, balanceW, balanceH)];
        
        self.balanceLab = balanceLab;
        
        balanceLab.textColor = [UIColor redColor];
        
        balanceLab.font = [UIFont systemFontOfSize:30];
        
        [self addSubview:balanceLab];
        
        CGFloat clickX = titleX;
        
        CGFloat clickY = titleY;
        
        CGFloat clickW = titleW;
        
        CGFloat clickH = CGRectGetMaxY(balanceLab.frame) - titleY;
        
        UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(clickX, clickY, clickW, clickH)];
        
        self.balanceBtn = click;
        
        [click addTarget:self action:@selector(balanceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:click];
        
        CGFloat btnX = CGRectGetMaxX(balanceLab.frame) + iconX;
        
        CGFloat btnY = 30;
        
        CGFloat btnW = SCREENWIDTH * 0.968 - btnX;
        
        CGFloat btnH = 20;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        
        self.rechargeBtn = btn;
        
        btn.layer.masksToBounds = YES;
        
        btn.layer.cornerRadius = 5;
        
        [btn setBackgroundColor:[UIColor colorWithRed:32/255. green:143/255. blue:250/255. alpha:1.]];
        
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        
        [btn setTitle:@"充值" forState:0];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn addTarget:self action:@selector(rechargeClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        self.height = CGRectGetMaxY(icon.frame) + 5;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 0.5, SCREENWIDTH, 0.5)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

- (void)balanceBtnClick {
    
    if (self.balanceBlock) {
        
        self.balanceBlock();
        
    }
    
}

- (void)rechargeClick {
    
    if (self.rechargeBlock) {
        
        self.rechargeBlock();
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
