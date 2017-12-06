//
//  HuaHuaViewCell.m
//  BusinessCenter
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "HuaHuaViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation HuaHuaViewCell

+ (instancetype)HuaHuaViewCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"HuaHuaViewCell";
    
    HuaHuaViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HuaHuaViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.032, 10, WIDTH * 0.268, 15)];
        
        self.nameLab = nameLab;
        
        nameLab.font = [UIFont systemFontOfSize:17];
        
        nameLab.textColor = [UIColor darkGrayColor];
        
        [self addSubview:nameLab];

        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.032, CGRectGetMaxY(nameLab.frame) + 10, WIDTH * 0.268, 15)];
        
        self.timeLab = timeLab;
        
        timeLab.font = [UIFont systemFontOfSize:15];
        
        timeLab.textColor = [UIColor lightGrayColor];
        
        [self addSubview:timeLab];
        
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLab.frame) + WIDTH * 0.05, 15, WIDTH * 0.25, 30)];
        
        self.countLab = countLab;
        
        countLab.font = [UIFont systemFontOfSize:18];
        
        countLab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:countLab];

        UILabel *jingbanrenLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(countLab.frame), 5, WIDTH * 0.368, 25)];
        
        jingbanrenLab.font = [UIFont systemFontOfSize:13];
        
        self.jingbanrenLab = jingbanrenLab;
        
        jingbanrenLab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:jingbanrenLab];

        UILabel *shopLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(countLab.frame), CGRectGetMaxY(nameLab.frame) + 5, WIDTH * 0.368, 25)];
        
        shopLab.font = [UIFont systemFontOfSize:11];
        
        shopLab.textColor = [UIColor lightGrayColor];
        
        self.shopLab = shopLab;
        
        shopLab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:shopLab];

        self.height = CGRectGetMaxY(timeLab.frame) + 10;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.032, self.height - 0.5, WIDTH * 0.968, 0.5)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
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
