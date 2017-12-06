//
//  AdminCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "AdminCell.h"
#define size ([UIScreen mainScreen].bounds.size)

@implementation AdminCell

+ (instancetype)adminCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"cellID";
    
    AdminCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AdminCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat imageX = size.width * 0.05;
        
        CGFloat imageY = 5;
        
        CGFloat imageW = size.width * 0.2;
        
        CGFloat imageH = 60;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        self.picImageView = imageview;
        
        [self addSubview:imageview];
        
        CGFloat nameX = size.width * 0.3;
        
        CGFloat nameY = 10;
        
        CGFloat nameW = size.width * 0.2;
        
        CGFloat nameH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLab = nameLab;
        
        [self addSubview:nameLab];
        
        CGFloat telX = CGRectGetMaxX(nameLab.frame);
        
        CGFloat telY = nameY;
        
        CGFloat telW = size.width * 0.5;
        
        CGFloat telH = nameH;
        
        UILabel *telLab = [[UILabel alloc] initWithFrame:CGRectMake(telX, telY, telW, telH)];
        
        self.telLab = telLab;
        
        telLab.textColor = [UIColor lightGrayColor];
        
        telLab.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:telLab];
        
        CGFloat titleX = nameX;
        
        CGFloat titleY = CGRectGetMaxY(nameLab.frame) + 10;
        
        CGFloat titleW = size.width * 0.7;
        
        CGFloat titleH = nameH;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = titleLab;
        
        titleLab.textColor = [UIColor darkGrayColor];
        
        titleLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:titleLab];
        
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
