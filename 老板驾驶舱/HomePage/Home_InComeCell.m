//
//  Home_InComeCell.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "Home_InComeCell.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation Home_InComeCell

+ (instancetype)Home_InComeCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"Home_InComeCell";
    
    Home_InComeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Home_InComeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        CGFloat titleX = SCREENWIDTH * 0.05;
        
        CGFloat titleY = 10;
        
        CGFloat titleW = SCREENWIDTH * 0.35;
        
        CGFloat titleH = 30;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = title;
        
        title.textColor = [UIColor darkTextColor];
        
        title.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:title];
        
        CGFloat countX = CGRectGetMaxX(title.frame);
        
        CGFloat countY = titleY;
        
        CGFloat countW = SCREENWIDTH * 0.5;
        
        CGFloat countH = titleH;
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(countX, countY, countW, countH)];
        
        self.countLab = count;
        
        count.textColor = [UIColor darkGrayColor];
        
        count.font = [UIFont systemFontOfSize:16];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(count.frame) + 9.5, SCREENWIDTH * 0.95, 0.5)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
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
