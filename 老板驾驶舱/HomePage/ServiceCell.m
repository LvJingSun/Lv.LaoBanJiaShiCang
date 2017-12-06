//
//  ServiceCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "ServiceCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation ServiceCell

+ (instancetype)ServiceCellWithTableView:(UITableView *)tableview {

    static NSString *cellID = @"ServiceCell";
    
    ServiceCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat imageX = Size.width * 0.07;
        
        CGFloat imageY = 10;
        
        CGFloat imageW = Size.width * 0.17;
        
        CGFloat imageH = 50;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        self.serviceImageView = imageview;
        
        [self addSubview:imageview];
        
        CGFloat nameX = Size.width * 0.35;
        
        CGFloat nameY = 10;
        
        CGFloat nameW = Size.width * 0.3;
        
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
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.7, 20, Size.width * 0.25, 30)];
        
        self.priceLabel = priceLabel;
        
        priceLabel.font = [UIFont systemFontOfSize:17];
        
        priceLabel.textAlignment = NSTextAlignmentCenter;
        
        priceLabel.textColor = [UIColor colorWithRed:255/255. green:167/255. blue:82/255. alpha:1.];
        
        [self addSubview:priceLabel];
        
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
