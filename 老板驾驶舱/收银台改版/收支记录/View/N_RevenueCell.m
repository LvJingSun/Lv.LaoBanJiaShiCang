//
//  N_RevenueCell.m
//  BusinessCenter
//
//  Created by mac on 2017/4/13.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "N_RevenueCell.h"
#import "N_RevenueModel.h"
#import "N_RevenueFrame.h"

#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]
#define TypeColor [UIColor colorWithRed:66/255.f green:66/255.f blue:66/255.f alpha:1.0]
#define DateColor [UIColor colorWithRed:156/255.f green:156/255.f blue:156/255.f alpha:1.0]
#define YuEColor [UIColor colorWithRed:69/255.f green:69/255.f blue:69/255.f alpha:1.0]
#define CountColor [UIColor colorWithRed:33/255.f green:33/255.f blue:33/255.f alpha:1.0]
#define TypeFont [UIFont systemFontOfSize:15]
#define DateFont [UIFont systemFontOfSize:13]
#define YuEFont [UIFont systemFontOfSize:13]
#define CountFont [UIFont systemFontOfSize:18]

@interface N_RevenueCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *yueCountLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation N_RevenueCell

+ (instancetype)N_RevenueCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"N_RevenueCell";
    
    N_RevenueCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[N_RevenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textColor = TypeColor;
        
        type.font = TypeFont;
        
        [self addSubview:type];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = DateColor;
        
        date.font = DateFont;
        
        date.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:date];
        
        UILabel *yue = [[UILabel alloc] init];
        
        self.yueCountLab = yue;
        
        yue.textColor = YuEColor;
        
        yue.font = YuEFont;
        
        [self addSubview:yue];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = CountColor;
        
        count.font = CountFont;
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

- (void)setFrameModel:(N_RevenueFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.yueCountLab.frame = self.frameModel.yueCountF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    N_RevenueModel *record = self.frameModel.recordModel;
    
    self.typeLab.text = [NSString stringWithFormat:@"%@",record.Type];
    
    NSString *dateStr = [record.TransactionDate substringWithRange:NSMakeRange(0, 10)];
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",dateStr];
    
    self.yueCountLab.text = [NSString stringWithFormat:@"余额：%@",@"0.00"];
    
    if ([record.Type isEqualToString:@"收入"]) {
        
        self.countLab.text = [NSString stringWithFormat:@"+%@",record.Amount];
        
    }else {
    
        self.countLab.text = [NSString stringWithFormat:@"-%@",record.Amount];
        
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
