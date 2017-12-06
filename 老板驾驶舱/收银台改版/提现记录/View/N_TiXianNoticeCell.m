//
//  N_TiXianNoticeCell.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_TiXianNoticeCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define YuEColor [UIColor colorWithRed:69/255.f green:69/255.f blue:69/255.f alpha:1.0]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@implementation N_TiXianNoticeCell

+ (instancetype)N_TiXianNoticeCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"N_TiXianNoticeCell";
    
    N_TiXianNoticeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[N_TiXianNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.9, 20)];
        
        self.noticeLab = lab;
        
        lab.textColor = YuEColor;
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:lab];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame) + 9, SCREEN_WIDTH, 1)];
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
    }
    
    return self;
    
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
