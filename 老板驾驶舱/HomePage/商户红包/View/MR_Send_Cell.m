//
//  MR_Send_Cell.m
//  BusinessCenter
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "MR_Send_Cell.h"
#import "MR_SendModel.h"
#import "MR_Send_Frame.h"

@interface MR_Send_Cell ()

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation MR_Send_Cell

+ (instancetype)MR_Send_CellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"MR_Send_Cell";
    
    MR_Send_Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[MR_Send_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor darkTextColor];
        
        date.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:date];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor colorWithRed:255/255. green:49/255. blue:49/255. alpha:1.];
        
        count.font = [UIFont systemFontOfSize:18];
        
        count.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:count];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.textAlignment = NSTextAlignmentRight;
        
        status.textColor = [UIColor colorWithRed:32/255. green:143/255. blue:251/255. alpha:1.];
        
        status.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:status];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(MR_Send_Frame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    MR_SendModel *model = self.frameModel.send_model;
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.time];
    
    self.countLab.text = [NSString stringWithFormat:@"¥%@",model.balance];
    
    if ([model.style isEqualToString:@"1"]) {
        
        self.statusLab.text = @"已发放";
        
    }else if ([model.style isEqualToString:@"2"]) {
        
        self.statusLab.text = @"未发放";
        
        self.statusLab.textColor = [UIColor lightGrayColor];
        
    }
    
    
    
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
