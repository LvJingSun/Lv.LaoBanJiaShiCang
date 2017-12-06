//
//  Y_SendDetailCell.m
//  BusinessCenter
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "Y_SendDetailCell.h"
#import "New_RecordFrame.h"
#import "F_ListModel.h"
#import <UIImageView+WebCache.h>
#define NameTextColor [UIColor colorWithRed:63/255. green:63/255. blue:63/255. alpha:1.]
#define LineColor [UIColor colorWithRed:243/255. green:243/255. blue:243/255. alpha:1.]
#define CountTextColor [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:1.]
#define StatusTextColor [UIColor colorWithRed:39/255. green:39/255. blue:39/255. alpha:1.]
#define BiaoTiTextColor [UIColor colorWithRed:170/255. green:170/255. blue:170/255. alpha:1.]
#define ProductTextColor [UIColor colorWithRed:95/255. green:95/255. blue:95/255. alpha:1.]

@interface Y_SendDetailCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UIImageView *pic;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UILabel *p_nameLab;

@property (nonatomic, weak) UILabel *productLab;

@property (nonatomic, weak) UILabel *t_countLab;

@property (nonatomic, weak) UILabel *tranCountLab;

@property (nonatomic, weak) UILabel *a_countLab;

@property (nonatomic, weak) UILabel *allCountLab;

@property (nonatomic, weak) UILabel *line3Lab;

@property (nonatomic, weak) UILabel *c_staffLab;

@property (nonatomic, weak) UILabel *staffLab;

@property (nonatomic, weak) UILabel *s_shopLab;

@property (nonatomic, weak) UILabel *shopLab;

@property (nonatomic, weak) UILabel *c_cuxiaoyuanLab;

@property (nonatomic, weak) UILabel *cuxiaoyuanLab;

@property (nonatomic, weak) UILabel *t_timeLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *d_danhaoLab;

@property (nonatomic, weak) UILabel *danhaoLab;

@property (nonatomic, weak) UILabel *line4Lab;

@property (nonatomic, weak) UILabel *p_pic1Lab;

@property (nonatomic, weak) UIImageView *pic1;

@property (nonatomic, weak) UILabel *p_pic2Lab;

@property (nonatomic, weak) UIImageView *pic2;

@end

@implementation Y_SendDetailCell

+ (instancetype)Y_SendDetailCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"Y_SendDetailCell";
    
    Y_SendDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Y_SendDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *namelab = [[UILabel alloc] init];
        
        self.nameLab = namelab;
        
        namelab.textAlignment = NSTextAlignmentCenter;
        
        namelab.font = [UIFont systemFontOfSize:23];
        
        namelab.textColor = NameTextColor;
        
        [self addSubview:namelab];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = LineColor;
        
        [self addSubview:line1];
        
        UILabel *countLab = [[UILabel alloc] init];
        
        self.countLab = countLab;
        
        countLab.textAlignment = NSTextAlignmentCenter;
        
        countLab.font = [UIFont systemFontOfSize:40];
        
        countLab.textColor = CountTextColor;
        
        [self addSubview:countLab];
        
        UIImageView *pic = [[UIImageView alloc] init];
        
        self.pic = pic;
        
        [self addSubview:pic];
        
        UILabel *statusLab = [[UILabel alloc] init];
        
        self.statusLab = statusLab;
        
        statusLab.textAlignment = NSTextAlignmentLeft;
        
        statusLab.font = [UIFont systemFontOfSize:14];
        
        statusLab.textColor = StatusTextColor;
        
        [self addSubview:statusLab];
        
        UILabel *line2Lab = [[UILabel alloc] init];
        
        self.line2Lab = line2Lab;
        
        line2Lab.backgroundColor = LineColor;
        
        [self addSubview:line2Lab];
        
        UILabel *p_nameLab = [[UILabel alloc] init];
        
        self.p_nameLab = p_nameLab;
        
        p_nameLab.textAlignment = NSTextAlignmentLeft;
        
        p_nameLab.font = [UIFont systemFontOfSize:16];
        
        p_nameLab.textColor = BiaoTiTextColor;
        
        [self addSubview:p_nameLab];
        
        UILabel *productLab = [[UILabel alloc] init];
        
        self.productLab = productLab;
        
        productLab.textAlignment = NSTextAlignmentLeft;
        
        productLab.font = [UIFont systemFontOfSize:16];
        
        productLab.textColor = ProductTextColor;
        
        [self addSubview:productLab];
        
        UILabel *t_countLab = [[UILabel alloc] init];
        
        self.t_countLab = t_countLab;
        
        t_countLab.textAlignment = NSTextAlignmentLeft;
        
        t_countLab.font = [UIFont systemFontOfSize:16];
        
        t_countLab.textColor = BiaoTiTextColor;
        
        [self addSubview:t_countLab];
        
        UILabel *tranCountLab = [[UILabel alloc] init];
        
        self.tranCountLab = tranCountLab;
        
        tranCountLab.textAlignment = NSTextAlignmentLeft;
        
        tranCountLab.font = [UIFont systemFontOfSize:16];
        
        tranCountLab.textColor = ProductTextColor;
        
        [self addSubview:tranCountLab];
        
        UILabel *a_countLab = [[UILabel alloc] init];
        
        self.a_countLab = a_countLab;
        
        a_countLab.textAlignment = NSTextAlignmentLeft;
        
        a_countLab.font = [UIFont systemFontOfSize:16];
        
        a_countLab.textColor = BiaoTiTextColor;
        
        [self addSubview:a_countLab];
        
        UILabel *allCountLab = [[UILabel alloc] init];
        
        self.allCountLab = allCountLab;
        
        allCountLab.textAlignment = NSTextAlignmentLeft;
        
        allCountLab.font = [UIFont systemFontOfSize:16];
        
        allCountLab.textColor = ProductTextColor;
        
        [self addSubview:allCountLab];
        
        UILabel *line3Lab = [[UILabel alloc] init];
        
        self.line3Lab = line3Lab;
        
        line3Lab.backgroundColor = LineColor;
        
        [self addSubview:line3Lab];
        
        UILabel *c_staffLab = [[UILabel alloc] init];
        
        self.c_staffLab = c_staffLab;
        
        c_staffLab.textAlignment = NSTextAlignmentLeft;
        
        c_staffLab.font = [UIFont systemFontOfSize:16];
        
        c_staffLab.textColor = BiaoTiTextColor;
        
        [self addSubview:c_staffLab];
        
        UILabel *staffLab = [[UILabel alloc] init];
        
        self.staffLab = staffLab;
        
        staffLab.textAlignment = NSTextAlignmentLeft;
        
        staffLab.font = [UIFont systemFontOfSize:16];
        
        staffLab.textColor = BiaoTiTextColor;
        
        [self addSubview:staffLab];
        
        UILabel *s_shopLab = [[UILabel alloc] init];
        
        self.s_shopLab = s_shopLab;
        
        s_shopLab.textAlignment = NSTextAlignmentLeft;
        
        s_shopLab.font = [UIFont systemFontOfSize:16];
        
        s_shopLab.textColor = BiaoTiTextColor;
        
        [self addSubview:s_shopLab];
        
        UILabel *shopLab = [[UILabel alloc] init];
        
        self.shopLab = shopLab;
        
        shopLab.textAlignment = NSTextAlignmentLeft;
        
        shopLab.font = [UIFont systemFontOfSize:16];
        
        shopLab.textColor = BiaoTiTextColor;
        
        [self addSubview:shopLab];
        
        UILabel *c_cuxiaoyuanLab = [[UILabel alloc] init];
        
        self.c_cuxiaoyuanLab = c_cuxiaoyuanLab;
        
        c_cuxiaoyuanLab.textAlignment = NSTextAlignmentLeft;
        
        c_cuxiaoyuanLab.font = [UIFont systemFontOfSize:16];
        
        c_cuxiaoyuanLab.textColor = BiaoTiTextColor;
        
        [self addSubview:c_cuxiaoyuanLab];
        
        UILabel *cuxiaoyuanLab = [[UILabel alloc] init];
        
        self.cuxiaoyuanLab = cuxiaoyuanLab;
        
        cuxiaoyuanLab.textAlignment = NSTextAlignmentLeft;
        
        cuxiaoyuanLab.font = [UIFont systemFontOfSize:16];
        
        cuxiaoyuanLab.textColor = BiaoTiTextColor;
        
        [self addSubview:cuxiaoyuanLab];
        
        UILabel *t_timeLab = [[UILabel alloc] init];
        
        self.t_timeLab = t_timeLab;
        
        t_timeLab.textAlignment = NSTextAlignmentLeft;
        
        t_timeLab.font = [UIFont systemFontOfSize:16];
        
        t_timeLab.textColor = BiaoTiTextColor;
        
        [self addSubview:t_timeLab];
        
        UILabel *timeLab = [[UILabel alloc] init];
        
        self.timeLab = timeLab;
        
        timeLab.textAlignment = NSTextAlignmentLeft;
        
        timeLab.font = [UIFont systemFontOfSize:16];
        
        timeLab.textColor = BiaoTiTextColor;
        
        [self addSubview:timeLab];
        
        UILabel *d_danhaoLab = [[UILabel alloc] init];
        
        self.d_danhaoLab = d_danhaoLab;
        
        d_danhaoLab.textAlignment = NSTextAlignmentLeft;
        
        d_danhaoLab.font = [UIFont systemFontOfSize:16];
        
        d_danhaoLab.textColor = BiaoTiTextColor;
        
        [self addSubview:d_danhaoLab];
        
        UILabel *danhaoLab = [[UILabel alloc] init];
        
        self.danhaoLab = danhaoLab;
        
        danhaoLab.textAlignment = NSTextAlignmentLeft;
        
        danhaoLab.font = [UIFont systemFontOfSize:16];
        
        danhaoLab.textColor = BiaoTiTextColor;
        
        [self addSubview:danhaoLab];
        
        UILabel *line4Lab = [[UILabel alloc] init];
        
        self.line4Lab = line4Lab;
        
        line4Lab.backgroundColor = LineColor;
        
        [self addSubview:line4Lab];
        
        UILabel *p_pic1Lab = [[UILabel alloc] init];
        
        self.p_pic1Lab = p_pic1Lab;
        
        p_pic1Lab.textAlignment = NSTextAlignmentCenter;
        
        p_pic1Lab.font = [UIFont systemFontOfSize:16];
        
        p_pic1Lab.textColor = ProductTextColor;
        
        [self addSubview:p_pic1Lab];
        
        UIImageView *pic1 = [[UIImageView alloc] init];
        
        self.pic1 = pic1;
        
        pic1.layer.masksToBounds = YES;
        
        pic1.layer.cornerRadius = 5;
        
        [self addSubview:pic1];
        
        UILabel *p_pic2Lab = [[UILabel alloc] init];
        
        self.p_pic2Lab = p_pic2Lab;
        
        p_pic2Lab.textAlignment = NSTextAlignmentCenter;
        
        p_pic2Lab.font = [UIFont systemFontOfSize:16];
        
        p_pic2Lab.textColor = ProductTextColor;
        
        [self addSubview:p_pic2Lab];
        
        UIImageView *pic2 = [[UIImageView alloc] init];
        
        self.pic2 = pic2;
        
        pic2.layer.masksToBounds = YES;
        
        pic2.layer.cornerRadius = 5;
        
        [self addSubview:pic2];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(New_RecordFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setContent];
    
    [self setRect];
    
}

- (void)setContent {
    
    F_ListModel *record = self.frameModel.record;
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",record.Memberid];
    
    self.countLab.text = [NSString stringWithFormat:@"-%@",record.Jinzhongzi];
    
    if ([record.nstatus isEqualToString:@"已提交"]) {
        
        self.pic.image = [UIImage imageNamed:@"push_pic.png"];
        
    }else if ([record.nstatus isEqualToString:@"未提交"]) {
        
        self.pic.image = [UIImage imageNamed:@"no_pic.png"];
        
    }
    
    self.statusLab.text = [NSString stringWithFormat:@"%@凭证",record.nstatus];
    
    self.p_nameLab.text = [NSString stringWithFormat:@"商品信息"];
    
    self.productLab.text = [NSString stringWithFormat:@"%@",record.goodsname];
    
    self.t_countLab.text = [NSString stringWithFormat:@"汽车品牌"];
    
    self.tranCountLab.text = [NSString stringWithFormat:@"%@",record.Brandname];
    
    self.a_countLab.text = [NSString stringWithFormat:@"全返金额"];
    
    self.allCountLab.text = [NSString stringWithFormat:@"%@",record.allaccount];
    
    self.c_staffLab.text = [NSString stringWithFormat:@"操作人员"];
    
    self.staffLab.text = [NSString stringWithFormat:@"%@",record.CashierAccountID];
    
    self.s_shopLab.text = [NSString stringWithFormat:@"店铺信息"];
    
    self.shopLab.text = [NSString stringWithFormat:@"%@",record.MerchantID];
    
    self.c_cuxiaoyuanLab.text = [NSString stringWithFormat:@"汽车牌照"];
    
    self.cuxiaoyuanLab.text = [NSString stringWithFormat:@"%@",record.CarNo];
    
    self.t_timeLab.text = [NSString stringWithFormat:@"交易时间"];
    
    self.timeLab.text = [NSString stringWithFormat:@"%@",record.CreateDate];
    
    self.d_danhaoLab.text = [NSString stringWithFormat:@"交易单号"];
    
    self.danhaoLab.text = [NSString stringWithFormat:@"%@",record.TranRcdsid];
    
    self.p_pic1Lab.text = @"合同/销售单";
    
    [self.pic1 sd_setImageWithURL:[NSURL URLWithString:record.pic1] placeholderImage:[UIImage imageNamed:@"noZZ.png"]];
    
    self.p_pic2Lab.text = @"收据/发票";
    
    [self.pic2 sd_setImageWithURL:[NSURL URLWithString:record.pic2] placeholderImage:[UIImage imageNamed:@"noZZ.png"]];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.line1Lab.frame = self.frameModel.line1F;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.pic.frame = self.frameModel.picF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.line2Lab.frame = self.frameModel.line2F;
    
    self.p_nameLab.frame = self.frameModel.p_nameF;
    
    self.productLab.frame = self.frameModel.productF;
    
    self.t_countLab.frame = self.frameModel.t_countF;
    
    self.tranCountLab.frame = self.frameModel.tranCountF;
    
    self.a_countLab.frame = self.frameModel.a_countF;
    
    self.allCountLab.frame = self.frameModel.allCountF;
    
    self.line3Lab.frame = self.frameModel.line3F;
    
    self.c_staffLab.frame = self.frameModel.c_staffF;
    
    self.staffLab.frame = self.frameModel.staffF;
    
    self.s_shopLab.frame = self.frameModel.s_shopF;
    
    self.shopLab.frame = self.frameModel.shopF;
    
    self.c_cuxiaoyuanLab.frame = self.frameModel.c_cuxiaoyuanF;
    
    self.cuxiaoyuanLab.frame = self.frameModel.cuxiaoyuanF;
    
    self.t_timeLab.frame = self.frameModel.t_timeF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.d_danhaoLab.frame = self.frameModel.d_danhaoF;
    
    self.danhaoLab.frame = self.frameModel.danhaoF;
    
    self.line4Lab.frame = self.frameModel.line4F;
    
    self.p_pic1Lab.frame = self.frameModel.p_pic1F;
    
    self.pic1.frame = self.frameModel.pic1F;
    
    self.p_pic2Lab.frame = self.frameModel.p_pic2F;
    
    self.pic2.frame = self.frameModel.pic2F;
    
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
