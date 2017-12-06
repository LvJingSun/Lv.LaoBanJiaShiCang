//
//  InCome_List_Cell.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "InCome_List_Cell.h"
#import "InCome_List_Model.h"
#import "InCome_List_Frame.h"

@interface InCome_List_Cell ()

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *notitleLab;

@property (nonatomic, weak) UILabel *noLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation InCome_List_Cell

+ (instancetype)InCome_List_CellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"InCome_List_Cell";
    
    InCome_List_Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[InCome_List_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor redColor];
        
        count.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:count];
        
        UILabel *notitle = [[UILabel alloc] init];
        
        self.notitleLab = notitle;
        
        notitle.textColor = [UIColor darkGrayColor];
        
        notitle.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:notitle];
        
        UILabel *no = [[UILabel alloc] init];
        
        self.noLab = no;
        
        no.textColor = [UIColor darkGrayColor];
        
        no.font = [UIFont systemFontOfSize:14];
        
        no.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:no];
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textColor = [UIColor darkTextColor];
        
        type.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:type];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:name];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textColor = [UIColor darkTextColor];
        
        time.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:time];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(InCome_List_Frame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.countLab.frame = self.frameModel.countF;
    
    self.notitleLab.frame = self.frameModel.noTitleF;
    
    self.noLab.frame = self.frameModel.noF;
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    InCome_List_Model *model = self.frameModel.listmodel;
    
    self.countLab.text = [NSString stringWithFormat:@"¥%@",model.Amount];
    
    self.notitleLab.text = @"订单编号";
    
    self.noLab.text = model.OrderNumber;
    
    self.typeLab.text = model.Description;
    
    self.nameLab.text = [NSString stringWithFormat:@"消费者:%@",model.NickName];
    
    self.timeLab.text = [NSString stringWithFormat:@"消费时间:%@",model.TransactionDate];
    
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
