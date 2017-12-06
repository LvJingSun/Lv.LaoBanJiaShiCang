//
//  New_RecordCell.m
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_SYTrecordCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TitleFont [UIFont systemFontOfSize:17]
#define LightColor [UIColor colorWithRed:134/255. green:134/255. blue:134/255. alpha:1.]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@implementation N_SYTrecordCell

+ (instancetype)N_SYTrecordCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"N_SYTrecordCell";
    
    N_SYTrecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[N_SYTrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.9, 20)];
        
        self.titleLab = title;
        
        title.textColor = LightColor;
        
        title.font = TitleFont;
        
        [self addSubview:title];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(title.frame) + 10, SCREEN_WIDTH * 0.95, 1)];
        
        line.backgroundColor = LineColor;
        
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
