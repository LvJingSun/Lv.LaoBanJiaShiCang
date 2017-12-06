//
//  GetListCell.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "GetListCell.h"
#import "GetFrameModel.h"
#import "F_ListModel.h"

#define ShenTextColor [UIColor colorWithRed:48/255. green:48/255. blue:48/255. alpha:1.]
#define QianTextColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define LineColor [UIColor colorWithRed:240/255. green:240/255. blue:240/255. alpha:1.]
#define BigFont [UIFont systemFontOfSize:15]
#define SmallFont [UIFont systemFontOfSize:13]

@interface GetListCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *sourceLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation GetListCell

+ (instancetype)GetListCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GetListCell";
    
    GetListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GetListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textColor = ShenTextColor;
        
        type.font = BigFont;
        
        type.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:type];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = ShenTextColor;
        
        count.font = [UIFont systemFontOfSize:17];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textColor = QianTextColor;
        
        time.font = SmallFont;
        
        time.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:time];
        
        UILabel *source = [[UILabel alloc] init];
        
        self.sourceLab = source;
        
        source.textColor = QianTextColor;
        
        source.font = SmallFont;
        
        source.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:source];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GetFrameModel *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.typeLab.frame = self.frameModel.typeF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.sourceLab.frame = self.frameModel.sourceF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    F_ListModel *model = self.frameModel.listmodel;
    
    self.typeLab.text = @"官方充值";
    
    if (![model.Jinzhongzi isEqualToString:@""]) {
        
        self.countLab.text = [NSString stringWithFormat:@"+%@",model.Jinzhongzi];
        
    }
    
    self.timeLab.text = [NSString stringWithFormat:@"%@",model.CreateDate];
    
    if (![model.info isEqualToString:@""]) {
        
        self.sourceLab.text = [NSString stringWithFormat:@"来源:%@",model.info];
        
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
