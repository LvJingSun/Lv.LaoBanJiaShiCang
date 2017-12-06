//
//  BigIncomeCell.m
//  BusinessCenter
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "BigIncomeCell.h"
#import "BigBtnView.h"
#define Size ([UIScreen mainScreen].bounds.size)

@implementation BigIncomeCell

+ (instancetype)BigIncomeCellWithTableView:(UITableView *)tableview {

    static NSString *cellID = @"BigIncomeCell";
    
    BigIncomeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[BigIncomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithRed:233/255. green:233/255. blue:233/255. alpha:1.];
        
        BigBtnView *yonghu = [[BigBtnView alloc] initWithFrame:CGRectMake(0, 0, (Size.width - 3) * 0.25, 70)];

        self.yonghu = yonghu;
        
        yonghu.titleLabel.text = @"用户";
        
        yonghu.iconImageview.image = [UIImage imageNamed:@"L_1.png"];
        
        [self addSubview:yonghu];
        
        BigBtnView *xiaoxi = [[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yonghu.frame) + 1, 0, (Size.width - 3) * 0.25, 70)];
        
        self.xiaoxi = xiaoxi;
        
        xiaoxi.titleLabel.text = @"消息";
        
        xiaoxi.iconImageview.image = [UIImage imageNamed:@"L_2.png"];
        
        [self addSubview:xiaoxi];
        
        BigBtnView *xiaoshou = [[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xiaoxi.frame) + 1, 0, (Size.width - 3) * 0.25, 70)];
        
        self.xiaoshou = xiaoshou;
        
        xiaoshou.titleLabel.text = @"销售记录";
        
        xiaoshou.iconImageview.image = [UIImage imageNamed:@"L_3.png"];
        
        [self addSubview:xiaoshou];
        
        BigBtnView *huiyuanka = [[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xiaoshou.frame) + 1, 0, (Size.width - 3) * 0.25, 70)];
        
        self.huiyuanka = huiyuanka;
        
        huiyuanka.titleLabel.text = @"会员卡记录";
        
        huiyuanka.iconImageview.image = [UIImage imageNamed:@"L_4.png"];
        
        [self addSubview:huiyuanka];
        
        BigBtnView *kucun =[[BigBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(yonghu.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.kucun = kucun;
        
        kucun.titleLabel.text = @"库存";
        
        kucun.iconImageview.image = [UIImage imageNamed:@"L_5.png"];
        
        [self addSubview:kucun];
        
        BigBtnView *yuangong =[[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(kucun.frame) + 1, CGRectGetMaxY(yonghu.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.yuangong = yuangong;
        
        yuangong.titleLabel.text = @"员工";
        
        yuangong.iconImageview.image = [UIImage imageNamed:@"L_6.png"];
        
        [self addSubview:yuangong];
        
        BigBtnView *paihao =[[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yuangong.frame) + 1, CGRectGetMaxY(yonghu.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.paihao = paihao;
        
        paihao.titleLabel.text = @"排号";
        
        paihao.iconImageview.image = [UIImage imageNamed:@"L_7.png"];
        
        [self addSubview:paihao];
        
        BigBtnView *zhiwei =[[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(paihao.frame) + 1, CGRectGetMaxY(yonghu.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.zhiwei = zhiwei;
        
        zhiwei.titleLabel.text = @"职位";
        
        zhiwei.iconImageview.image = [UIImage imageNamed:@"L_8.png"];
        
        [self addSubview:zhiwei];
        
        BigBtnView *dengji =[[BigBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(kucun.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.dengji = dengji;
        
        dengji.titleLabel.text = @"等级";
        
        dengji.iconImageview.image = [UIImage imageNamed:@"L_9.png"];
        
        [self addSubview:dengji];
        
        BigBtnView *huahua =[[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dengji.frame) + 1, CGRectGetMaxY(kucun.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.huahua = huahua;
        
        huahua.titleLabel.text = @"花花";
        
        huahua.iconImageview.image = [UIImage imageNamed:@"hh_yuan.png"];
        
        [self addSubview:huahua];
        
        BigBtnView *quanfanfu =[[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(huahua.frame) + 1, CGRectGetMaxY(kucun.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.quanfanfu = quanfanfu;
        
        quanfanfu.titleLabel.text = @"粉丝宝";
        
        quanfanfu.iconImageview.image = [UIImage imageNamed:@"fen_yuan.png"];
        
        [self addSubview:quanfanfu];
        
        BigBtnView *yangchebao =[[BigBtnView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(quanfanfu.frame) + 1, CGRectGetMaxY(kucun.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.yangchebao = yangchebao;
        
        yangchebao.titleLabel.text = @"养车宝";
        
        yangchebao.iconImageview.image = [UIImage imageNamed:@"car_yuan.png"];
        
        [self addSubview:yangchebao];
        
        BigBtnView *merchantRed =[[BigBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dengji.frame) + 1, (Size.width - 3) * 0.25, 70)];
        
        self.merchantRed = merchantRed;
        
        merchantRed.titleLabel.text = @"商户红包";
        
        merchantRed.iconImageview.image = [UIImage imageNamed:@"h_hongbao"];
        
        [self addSubview:merchantRed];
        
        self.height = CGRectGetMaxY(merchantRed.frame);

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
