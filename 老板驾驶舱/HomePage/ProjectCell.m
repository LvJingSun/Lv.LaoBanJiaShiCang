//
//  ProjectCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "ProjectCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation ProjectCell

+ (instancetype)ProjectCellWithTableView:(UITableView *)tableview {

    static NSString *cellID = @"ProjectCell";
    
    ProjectCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat imageX = Size.width * 0.05;
        
        CGFloat imageY = 10;
        
        CGFloat imageW = Size.width * 0.2;
        
        CGFloat imageH = 60;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        self.ProjectImageView = imageview;
        
        [self addSubview:imageview];
        
        CGFloat nameLabH = 20;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.3, 5, Size.width * 0.6, nameLabH)];
        
        self.ProjectNameLab = nameLabel;
        
        nameLabel.textColor = [UIColor colorWithRed:51/255. green:51/255. blue:51/255. alpha:1.];
        
        [self addSubview:nameLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.3, CGRectGetMaxY(nameLabel.frame) + 5, (Size.width * 0.6 - 5) * 0.5, nameLabH)];
        
        self.ProjectPriceLab = priceLabel;
        
        priceLabel.font = [UIFont systemFontOfSize:11];
        
        priceLabel.textColor = [UIColor colorWithRed:125/255. green:125/255. blue:125/255. alpha:1.];
        
        [self addSubview:priceLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame) + 5, CGRectGetMaxY(nameLabel.frame) + 5, (Size.width * 0.6 - 5) * 0.5, nameLabH)];
        
        self.ProjectTimeLab = timeLabel;
        
        timeLabel.font = [UIFont systemFontOfSize:11];
        
        timeLabel.textColor = [UIColor colorWithRed:125/255. green:125/255. blue:125/255. alpha:1.];
        
        [self addSubview:timeLabel];
        
        UILabel *beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.3, CGRectGetMaxY(priceLabel.frame) + 5, (Size.width * 0.6 - 5) * 0.5, nameLabH)];
        
        self.ProjectBeginLab = beginLabel;
        
        beginLabel.textColor = [UIColor colorWithRed:161/255. green:161/255. blue:161/255. alpha:1.];
        
        beginLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:beginLabel];
        
        UILabel *finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(beginLabel.frame) + 5, CGRectGetMaxY(priceLabel.frame) + 5, (Size.width * 0.6 - 5) * 0.5, nameLabH)];
        
        self.ProjectFinishLab = finishLabel;
        
        finishLabel.font = [UIFont systemFontOfSize:10];
        
        finishLabel.textColor = [UIColor colorWithRed:161/255. green:161/255. blue:161/255. alpha:1.];
        
        [self addSubview:finishLabel];
        
        self.height = CGRectGetMaxY(finishLabel.frame) + 5;
        
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
