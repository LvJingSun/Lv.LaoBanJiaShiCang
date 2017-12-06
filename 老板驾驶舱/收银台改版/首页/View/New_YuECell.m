//
//  New_YuECell.m
//  BusinessCenter
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "New_YuECell.h"
#import "New_YuEFrame.h"
#import "New_TiXianData.h"

#define LightColor [UIColor colorWithRed:134/255. green:134/255. blue:134/255. alpha:1.]
#define DarkColor [UIColor colorWithRed:46/255. green:46/255. blue:46/255. alpha:1.]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]
#define CardColor [UIColor colorWithRed:72/255. green:162/255. blue:245/255. alpha:1.]
#define HangColor [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define TitleFont [UIFont systemFontOfSize:15]
#define CountFont [UIFont systemFontOfSize:35]

@interface New_YuECell ()

@property (nonatomic, weak) UILabel *yueTitleLab;

@property (nonatomic, weak) UILabel *yueCountLab;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UILabel *cardTitleLab;

@property (nonatomic, weak) UILabel *cardLab;

@property (nonatomic, weak) UILabel *line2Lab;

@property (nonatomic, weak) UILabel *hangLab;

@end

@implementation New_YuECell

+ (instancetype)New_YuECellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"New_YuECell";
    
    New_YuECell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[New_YuECell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *yuetitle = [[UILabel alloc] init];
        
        self.yueTitleLab = yuetitle;
        
        yuetitle.textColor = LightColor;
        
        yuetitle.font = TitleFont;
        
        [self addSubview:yuetitle];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.yueCountLab = count;
        
        count.textColor = DarkColor;
        
        count.font = CountFont;
        
        [self addSubview:count];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = LineColor;
        
        [self addSubview:line1];
        
        UILabel *cardtitle = [[UILabel alloc] init];
        
        self.cardTitleLab = cardtitle;
        
        cardtitle.textColor = LightColor;
        
        cardtitle.font = TitleFont;
        
        [self addSubview:cardtitle];
        
        UILabel *card = [[UILabel alloc] init];
        
        self.cardLab = card;
        
        card.textColor = CardColor;
        
        card.font = TitleFont;
        
        [self addSubview:card];
        
        UILabel *line2 = [[UILabel alloc] init];
        
        self.line2Lab = line2;
        
        line2.backgroundColor = LineColor;
        
        [self addSubview:line2];
        
        UILabel *hang = [[UILabel alloc] init];
        
        self.hangLab = hang;
        
        hang.backgroundColor = HangColor;
        
        [self addSubview:hang];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(New_YuEFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.yueTitleLab.frame = self.frameModel.yueTitleF;
    
    self.yueCountLab.frame = self.frameModel.yueCountF;
    
    self.line1Lab.frame = self.frameModel.line1F;
    
    self.cardTitleLab.frame = self.frameModel.cardTitleF;
    
    self.cardLab.frame = self.frameModel.cardNumberF;
    
    self.line2Lab.frame = self.frameModel.line2F;
    
    self.hangLab.frame = self.frameModel.hangF;
    
}

- (void)setContent {

    New_TiXianData *data = self.frameModel.dataModel;
    
    self.yueTitleLab.text = @"账户余额:";
    
    NSString *yue = [[NSUserDefaults standardUserDefaults] objectForKey:@"Balance"];
    
    if (yue.length != 0) {
        
        self.yueCountLab.text = [NSString stringWithFormat:@"%@ 元",yue];
        
    }else {
    
        self.yueCountLab.text = [NSString stringWithFormat:@"%@ 元",@"0.00"];
        
    }
    
    self.cardTitleLab.text = @"收款账号:";
    
    if ([data.CardNumber isEqualToString:@""]) {
        
        self.cardLab.text = @"暂无收款账号";
        
    }else {
    
        self.cardLab.text = [NSString stringWithFormat:@"%@",data.CardNumber];
        
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
