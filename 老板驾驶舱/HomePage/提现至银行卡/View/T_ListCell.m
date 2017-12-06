//
//  T_ListCell.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "T_ListCell.h"
#import "RechargeHeader.h"
#import "T_ListModel.h"
#import "T_ListFrame.h"

@interface T_ListCell ()

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation T_ListCell

+ (instancetype)T_ListCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"T_ListCell";
    
    T_ListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[T_ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *countLab = [[UILabel alloc] init];
        
        self.countLab = countLab;
        
        countLab.textColor = [UIColor darkTextColor];
        
        countLab.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:countLab];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textColor = [UIColor darkGrayColor];
        
        time.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:time];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.font = [UIFont systemFontOfSize:16];
        
        status.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:status];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(T_ListFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.countLab.frame = self.frameModel.countF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    T_ListModel *model = self.frameModel.listModel;
    
    self.countLab.text = model.balance;
    
    self.timeLab.text = model.time;
    
    if ([model.status isEqualToString:@"失败"] || [model.status isEqualToString:@"异常"]) {
        
        self.statusLab.textColor = [UIColor redColor];
        
    }else if ([model.status isEqualToString:@"待处理"] || [model.status isEqualToString:@"处理中"]) {
        
        self.statusLab.textColor = [UIColor orangeColor];
        
    }else {
        
        self.statusLab.textColor = [UIColor greenColor];
        
    }
    
    self.statusLab.text = model.status;
    
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
