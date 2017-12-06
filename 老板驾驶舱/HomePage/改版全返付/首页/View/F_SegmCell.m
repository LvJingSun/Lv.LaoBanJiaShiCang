//
//  F_SegmCell.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_SegmCell.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SegmColor [UIColor colorWithRed:72/255. green:162/255. blue:245/255. alpha:1.]

@implementation F_SegmCell

+ (instancetype)F_SegmCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"F_SegmCell";
    
    F_SegmCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[F_SegmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UISegmentedControl *segm = [[UISegmentedControl alloc] initWithItems:@[@"近五天",@"近五周",@"近五月"]];

        segm.frame = CGRectMake(SCREENWIDTH * 0.2, 10, SCREENWIDTH * 0.6, 30);

        segm.tintColor = SegmColor;

        segm.selectedSegmentIndex = 0;

        self.segm = segm;

        [self addSubview:segm];
        
        self.height = CGRectGetMaxY(segm.frame) + 10;
        
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
