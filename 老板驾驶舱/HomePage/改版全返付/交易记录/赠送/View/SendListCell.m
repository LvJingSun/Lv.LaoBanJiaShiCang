//
//  SendListCell.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "SendListCell.h"
#import "F_ListModel.h"
#import "SendFrameModel.h"

#define CheXiaoColor [UIColor colorWithRed:255/255.f green:0/255.f blue:0/255.f alpha:1.];
#define CountTextColor [UIColor colorWithRed:248/255.f green:36/255.f blue:0/255.f alpha:1.]
#define KeHuTextColor [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1.]
#define ShenTextColor [UIColor colorWithRed:48/255. green:48/255. blue:48/255. alpha:1.]
#define QianTextColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define LineColor [UIColor colorWithRed:240/255. green:240/255. blue:240/255. alpha:1.]
#define KeHuFont [UIFont systemFontOfSize:20]
#define XiaoFeiFont [UIFont systemFontOfSize:15]
#define TimeFont [UIFont systemFontOfSize:13]
#define CountFont [UIFont systemFontOfSize:30]
#define CheXiaoFont [UIFont systemFontOfSize:14]

@interface SendListCell ()

@property (nonatomic, weak) UILabel *kehuLab;

@property (nonatomic, weak) UIImageView *picImageview;

@property (nonatomic, weak) UILabel *xiaofeiLab;

@property (nonatomic, weak) UILabel *cuxiaoLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *jingbanLab;

@property (nonatomic, weak) UILabel *chexiaoLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation SendListCell

+ (instancetype)SendListCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"SendListCell";
    
    SendListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[SendListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *kehu = [[UILabel alloc] init];
        
        self.kehuLab = kehu;
        
        kehu.textColor = KeHuTextColor;
        
        kehu.font = KeHuFont;
        
        [self addSubview:kehu];
        
        UIImageView *pic = [[UIImageView alloc] init];
        
        self.picImageview = pic;
        
        [self addSubview:pic];
        
        UILabel *chexiao = [[UILabel alloc] init];
        
        self.chexiaoLab = chexiao;
        
        chexiao.textColor = CheXiaoColor;
        
        chexiao.font = CheXiaoFont;
        
        [self addSubview:chexiao];
        
        UILabel *xiaofei = [[UILabel alloc] init];
        
        self.xiaofeiLab = xiaofei;
        
        xiaofei.textColor = ShenTextColor;
        
        xiaofei.font = XiaoFeiFont;
        
        [self addSubview:xiaofei];
        
        UILabel *cuxiao = [[UILabel alloc] init];
        
        self.cuxiaoLab = cuxiao;
        
        cuxiao.textColor = ShenTextColor;
        
        cuxiao.font = XiaoFeiFont;
        
        [self addSubview:cuxiao];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = CountTextColor;
        
        count.font = CountFont;
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textColor = QianTextColor;
        
        time.font = TimeFont;
        
        [self addSubview:time];
        
        UILabel *jingban = [[UILabel alloc] init];
        
        self.jingbanLab = jingban;
        
        jingban.textColor = QianTextColor;
        
        jingban.font = TimeFont;
        
        jingban.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:jingban];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(SendFrameModel *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.kehuLab.frame = self.frameModel.kehuF;
    
    self.picImageview.frame = self.frameModel.picF;
    
    self.chexiaoLab.frame = self.frameModel.chexiaoF;
    
    self.xiaofeiLab.frame = self.frameModel.xiaofeiF;
    
    self.cuxiaoLab.frame = self.frameModel.cuxiaoF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.jingbanLab.frame = self.frameModel.jingbanF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    F_ListModel *model = self.frameModel.model;

    self.kehuLab.text = [NSString stringWithFormat:@"%@",model.Memberid];
    
    if ([model.nstatus isEqualToString:@"已提交"]) {
        
        self.picImageview.image = [UIImage imageNamed:@"push_pic.png"];
        
    }else if ([model.nstatus isEqualToString:@"未提交"]) {
    
        self.picImageview.image = [UIImage imageNamed:@"no_pic.png"];
        
    }
    
    if ([model.status isEqualToString:@"已撤销"]) {
        
        self.chexiaoLab.text = @"（已撤销）";
        
    }else if ([model.status isEqualToString:@"已冻结"]) {
    
        self.chexiaoLab.text = @"（已冻结）";
        
    }
    
    if ([model.TranAccount isEqualToString:@""]) {
        
        self.xiaofeiLab.text = @"消费:暂无";
        
    }else {
    
        self.xiaofeiLab.text = [NSString stringWithFormat:@"消费:%@元",model.TranAccount];
        
    }

    if ([model.cuxiao isEqualToString:@""]) {
        
        self.cuxiaoLab.text = @"促销员:暂无";
        
    }else {
    
        self.cuxiaoLab.text = [NSString stringWithFormat:@"促销员:%@",model.cuxiao];
        
    }
    
    if (model.isMerchantRed) {
            
        self.countLab.text = [NSString stringWithFormat:@"%@",model.allaccount];
        
    }else {
        
        if (![model.Jinzhongzi isEqualToString:@""]) {
            
            self.countLab.text = [NSString stringWithFormat:@"-%@",model.Jinzhongzi];
            
        }
        
    }

    self.timeLab.text = [NSString stringWithFormat:@"%@",model.CreateDate];
    
    if ([model.CashierAccountID isEqualToString:@""]) {
        
        self.jingbanLab.text = @"经办人:暂无";
        
    }else {
    
        self.jingbanLab.text = [NSString stringWithFormat:@"经办人:%@",model.CashierAccountID];
        
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
