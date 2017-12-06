//
//  CommissionCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "CommissionCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation CommissionCell

+ (instancetype)CommissionCellWithTableView:(UITableView *)tableview {

    static NSString *cellID = @"CommissionCell";
    
    CommissionCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[CommissionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat nameLabelX = Size.width * 0.05;
        
        CGFloat nameLabelY = 10;
        
        CGFloat nameLabelW = Size.width * 0.4;
        
        CGFloat nameLabelH = 20;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH)];
        
        self.CommissionNameLabel = nameLabel;
        
        [self addSubview:nameLabel];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabelX, CGRectGetMaxY(nameLabel.frame) + 10, nameLabelW, nameLabelH)];
        
        self.CommissionDateLabel = dateLabel;
        
        dateLabel.textColor = [UIColor colorWithRed:125/255. green:125/255. blue:125/255. alpha:1.];
        
        dateLabel.font = [UIFont systemFontOfSize:11];
        
        [self addSubview:dateLabel];
        
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.6, 15, Size.width * 0.3, 40)];
        
        self.CommissionCountLabel = countLabel;
        
        countLabel.textColor = [UIColor colorWithRed:255/255. green:167/255. blue:82/255. alpha:1.];
        
        countLabel.font = [UIFont systemFontOfSize:18];
        
        countLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:countLabel];
        
        self.height = CGRectGetMaxY(dateLabel.frame) + 10;
        
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
