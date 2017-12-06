//
//  RowNumCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "RowNumCell.h"
#import <AVFoundation/AVFoundation.h>
#define Size ([UIScreen mainScreen].bounds.size)

@interface RowNumCell () {

    int alltime;
    
    NSTimer *currentTimer1;
    
    SystemSoundID soundID1;
    
}

@end

@implementation RowNumCell

+ (instancetype)adminCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"cellID";
    
    RowNumCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RowNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat imageX = Size.width * 0.05;
        
        CGFloat imageY = 5;
        
        CGFloat imageW = Size.width * 0.2;
        
        CGFloat imageH = 60;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        self.picImageView = imageview;
        
        [self addSubview:imageview];
        
        CGFloat nameX = Size.width * 0.3;
        
        CGFloat nameY = 10;
        
        CGFloat nameW = Size.width * 0.2;
        
        CGFloat nameH = 20;
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLab = nameLab;
        
        [self addSubview:nameLab];
        
        CGFloat telX = CGRectGetMaxX(nameLab.frame);
        
        CGFloat telY = nameY;
        
        CGFloat telW = Size.width * 0.5;
        
        CGFloat telH = nameH;
        
        UILabel *telLab = [[UILabel alloc] initWithFrame:CGRectMake(telX, telY, telW, telH)];
        
        self.telLab = telLab;
        
        telLab.textColor = [UIColor lightGrayColor];
        
        telLab.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:telLab];
        
        CGFloat titleX = nameX;
        
        CGFloat titleY = CGRectGetMaxY(nameLab.frame) + 10;
        
        CGFloat titleW = Size.width * 0.3;
        
        CGFloat titleH = nameH;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        self.titleLab = titleLab;
        
        titleLab.textColor = [UIColor darkGrayColor];
        
        titleLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:titleLab];
        
        self.height = 70;
        
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.85, (70 - Size.width * 0.08) * 0.5, Size.width * 0.08, Size.width * 0.08)];
        
        self.countLab = countLab;
        
        countLab.textAlignment = NSTextAlignmentCenter;
        
        countLab.textColor = [UIColor darkGrayColor];
        
        countLab.layer.borderWidth = 1;
        
        countLab.layer.borderColor = [UIColor blackColor].CGColor;
        
        countLab.layer.cornerRadius = countLab.bounds.size.width / 2;
        
        countLab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:countLab];
        
        UIImageView *statusIcon = [[UIImageView alloc] initWithFrame:CGRectMake(Size.width * 0.8, (70 - Size.width * 0.18) * 0.5, Size.width * 0.18, Size.width * 0.18)];
        
        self.statusIcon = statusIcon;
        
        [self addSubview:statusIcon];
        
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(Size.width * 0.8, 20, Size.width * 0.18, 30)];
        
        self.statusLabel = statusLabel;
        
        statusLabel.layer.masksToBounds = YES;
        
        statusLabel.textAlignment = NSTextAlignmentCenter;
        
        statusLabel.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:statusLabel];
        
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
