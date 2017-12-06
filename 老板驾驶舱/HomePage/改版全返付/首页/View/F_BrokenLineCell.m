//
//  F_BrokenLineCell.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_BrokenLineCell.h"
#import "F_BrokenLineView.h"


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation F_BrokenLineCell

+ (instancetype)F_BrokenLineCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"F_BrokenLineCell";
    
    F_BrokenLineCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[F_BrokenLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        
        top.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.];
        
        [self addSubview:top];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(top.frame) + 15, SCREENWIDTH * 0.45, 20)];
        
        self.titleLab = title;
        
        title.font = [UIFont boldSystemFontOfSize:15];
        
        title.textColor = [UIColor blackColor];
        
        title.text = @"近5天赠送情况";
        
        [self addSubview:title];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.7, CGRectGetMaxY(top.frame) + 15, SCREENWIDTH * 0.25, 20)];
        
        self.changeBtn = btn;
        
        [btn setTitleColor:[UIColor blackColor] forState:0];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [btn setTitle:@"切换充值情况" forState:0];
        
        [self addSubview:btn];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.origin.x - 18, btn.frame.origin.y + 2.5, 15, 15)];
        
        imageview.image = [UIImage imageNamed:@"change.png"];
        
        [self addSubview:imageview];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(btn.frame) + 14.5, SCREENWIDTH * 0.9, 0.5)];
        
        line.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:line];
        
        F_BrokenLineView *view = [[F_BrokenLineView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), SCREENWIDTH, 120)];
        
        self.lineView = view;
        
        [self addSubview:view];
        
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(view.frame) + 9.5, SCREENWIDTH * 0.9, 0.5)];
        
        bottomLine.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:bottomLine];
        
        self.height = CGRectGetMaxY(bottomLine.frame);
        
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
