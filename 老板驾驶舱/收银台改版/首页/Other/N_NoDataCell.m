//
//  N_NoDataCell.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_NoDataCell.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation N_NoDataCell

+ (instancetype)N_NoDataCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"N_NoDataCell";
    
    N_NoDataCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[N_NoDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = TabBGCOLOR;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 100, SCREEN_WIDTH * 0.9, 30)];
        
        lab.text = @"暂无数据";
        
        lab.font = [UIFont systemFontOfSize:17];
        
        lab.textColor = [UIColor darkGrayColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lab];
        
        self.height = CGRectGetMaxY(lab.frame);
        
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
