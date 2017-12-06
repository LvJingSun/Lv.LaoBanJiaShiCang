//
//  MR_GetGroupCell.m
//  BusinessCenter
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_GetGroupCell.h"
#import "MR_GetGroupModel.h"
#import "MR_GetGroupFrame.h"

@interface MR_GetGroupCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation MR_GetGroupCell

+ (instancetype)MR_GetGroupCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"MR_GetGroupCell";
    
    MR_GetGroupCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[MR_GetGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *date = [[UILabel alloc] init];
        
        self.titleLab = date;
        
        date.textColor = [UIColor darkTextColor];
        
        date.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:date];
        
        UILabel *balanceLab = [[UILabel alloc] init];
        
        self.balanceLab = balanceLab;
        
        balanceLab.textColor = [UIColor redColor];
        
        balanceLab.textAlignment = NSTextAlignmentRight;
        
        balanceLab.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:balanceLab];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(MR_GetGroupFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.balanceLab.frame = self.frameModel.balanceF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    MR_GetGroupModel *model = self.frameModel.groupModel;
    
    self.titleLab.text = [NSString stringWithFormat:@"%@",model.week];
    
    self.balanceLab.text = [NSString stringWithFormat:@"已领取¥%@",model.balance];
    
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
