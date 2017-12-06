//
//  MR_GetCell.m
//  BusinessCenter
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_GetCell.h"
#import "MR_GetModel.h"
#import "MR_GetFrame.h"

@interface MR_GetCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation MR_GetCell

+ (instancetype)MR_GetCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"MR_GetCell";
    
    MR_GetCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[MR_GetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:name];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textColor = [UIColor darkGrayColor];
        
        time.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:time];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor colorWithRed:255/255. green:49/255. blue:49/255. alpha:1.];
        
        count.font = [UIFont systemFontOfSize:17];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(MR_GetFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    MR_GetModel *model = self.frameModel.getModel;
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.nickname];
    
    self.timeLab.text = [NSString stringWithFormat:@"%@",model.time];
    
    self.countLab.text = [NSString stringWithFormat:@"已领取¥%@",model.balance];
    
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
