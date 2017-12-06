//
//  YongjinCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "YongjinCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation YongjinCell

+ (instancetype)YongjinCellWithTableView:(UITableView *)tableview {

    static NSString *cellID = @"YongjinCell";
    
    YongjinCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[YongjinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat nameX = Size.width * 0.1;
        
        CGFloat nameY = 10;
        
        CGFloat nameW = Size.width * 0.35;
        
        CGFloat nameH = 20;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLabel = nameLabel;
        
        nameLabel.font = [UIFont systemFontOfSize:15];
        
        nameLabel.textColor = [UIColor colorWithRed:51/255. green:51/255. blue:51/255. alpha:1.];
        
        [self addSubview:nameLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, CGRectGetMaxY(nameLabel.frame) + 10, nameW, nameH)];
        
        self.timeLabel = timeLabel;
        
        timeLabel.font = [UIFont systemFontOfSize:12];
        
        timeLabel.textColor = [UIColor colorWithRed:161/255. green:161/255. blue:161/255. alpha:1.];
        
        [self addSubview:timeLabel];
        
        UILabel *yongjinLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.55, 20, Size.width * 0.35, 30)];
        
        self.priceLabel = yongjinLabel;
        
        yongjinLabel.textAlignment = NSTextAlignmentCenter;
        
        yongjinLabel.textColor = [UIColor colorWithRed:255/255. green:167/255. blue:82/255. alpha:1.];
        
        yongjinLabel.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:yongjinLabel];
        
        self.height = 70;
        
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
