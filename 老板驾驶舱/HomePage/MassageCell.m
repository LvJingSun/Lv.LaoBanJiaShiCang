//
//  MassageCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "MassageCell.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation MassageCell

//+ (instancetype)MassageCellWithTableView:(UITableView *)tableview {
//
//    static NSString *cellID = @"MassageCell";
//    
//    MassageCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
//    
//    if (cell == nil) {
//        
//        cell = [[MassageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        
//    }
//    
//    return cell;
//    
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat imageX = Size.width * 0.05;
        
        CGFloat imageY = 10;
        
        CGFloat imageW = Size.width * 0.15;
        
        CGFloat imageH = 50;
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        self.iconImageview = imageview;
        
        [self addSubview:imageview];
        
        CGFloat nameX = Size.width * 0.25;
        
        CGFloat nameY = 5;
        
        CGFloat nameW = Size.width * 0.25;
        
        CGFloat nameH = 20;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        
        self.nameLabel = nameLabel;
        
        nameLabel.font = [UIFont systemFontOfSize:17];
        
        nameLabel.textColor = [UIColor colorWithRed:56/255. green:56/255. blue:56/255. alpha:1.];
        
        [self addSubview:nameLabel];
        
        CGFloat proportionX = nameX;
        
        CGFloat proportionY = CGRectGetMaxY(nameLabel.frame) + 5;
        
        CGFloat proportionW = nameW;
        
        CGFloat proportionH = 15;
        
        UILabel *proportionLabel = [[UILabel alloc] initWithFrame:CGRectMake(proportionX, proportionY, proportionW, proportionH)];
        
        self.proportionLabel = proportionLabel;
        
        proportionLabel.font = [UIFont systemFontOfSize:11];
        
        proportionLabel.textColor = [UIColor colorWithRed:3/255. green:168/255. blue:226/255. alpha:1.];
        
        [self addSubview:proportionLabel];
        
        CGFloat timeX = nameX;
        
        CGFloat timeY = CGRectGetMaxY(proportionLabel.frame) + 5;
        
        CGFloat timeW = nameW;
        
        CGFloat timeH = proportionH;
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        
        self.timeLabel = timeLabel;
        
        timeLabel.font = [UIFont systemFontOfSize:11];
        
        timeLabel.textColor = [UIColor colorWithRed:168/255. green:168/255. blue:168/255. alpha:1.];
        
        [self addSubview:timeLabel];
        
        CGFloat priceX = Size.width * 0.55;
        
        CGFloat priceY = 20;
        
        CGFloat priceW = Size.width * 0.15;
        
        CGFloat priceH = 30;
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceX, priceY, priceW, priceH)];
        
        priceLabel.textColor = [UIColor colorWithRed:255/255. green:88/255. blue:0/255. alpha:1.];
        
        self.priceLabel = priceLabel;
        
        priceLabel.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:priceLabel];
        
        CGFloat reduceX = Size.width * 0.75;
        
        CGFloat reduceY = priceY;
        
        CGFloat reduceW = Size.width * 0.08;
        
        CGFloat reduceH = 30;
        
        UIButton *reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(reduceX, reduceY, reduceW, reduceH)];
        
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        
        self.reduceBtn = reduceBtn;
        
        [reduceBtn setTitleColor:[UIColor colorWithRed:255/255. green:88/255. blue:0/255. alpha:1.] forState:UIControlStateNormal];
        
        [self addSubview:reduceBtn];
        
        CGFloat countX = Size.width * 0.83;
        
        CGFloat countY = reduceY;
        
        CGFloat countW = reduceW;
        
        CGFloat countH = reduceH;
        
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(countX, countY, countW, countH)];
        
        self.countLabel = countLabel;
        
        countLabel.font = [UIFont systemFontOfSize:14];
        
        countLabel.textColor = [UIColor lightGrayColor];
        
        countLabel.textAlignment = NSTextAlignmentCenter;
        
        countLabel.text = @"0";
        
        [self addSubview:countLabel];
        
        CGFloat addX = Size.width * 0.91;
        
        CGFloat addY = reduceY;
        
        CGFloat addW = reduceW;
        
        CGFloat addH = reduceH;
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(addX, addY, addW, addH)];
        
        self.addBtn = addBtn;
        
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        
        [addBtn setTitleColor:[UIColor colorWithRed:255/255. green:88/255. blue:0/255. alpha:1.] forState:UIControlStateNormal];
        
        [self addSubview:addBtn];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 69, Size.width, 1)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
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
