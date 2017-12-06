//
//  TiXian_Cell.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "TiXian_Cell.h"
#import "TiXian_Model.h"
#import "TiXian_Frame.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface TiXian_Cell ()

@property (nonatomic, weak) UILabel *bandTitleLab;

@property (nonatomic, weak) UILabel *bandNameLab;

@property (nonatomic, weak) UILabel *bandCardLab;

@property (nonatomic, weak) UILabel *balanceTitleLab;

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation TiXian_Cell

+ (instancetype)TiXian_CellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"TiXian_Cell";
    
    TiXian_Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[TiXian_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.];
        
        UILabel *bandtitle = [[UILabel alloc] init];
        
        self.bandTitleLab = bandtitle;
        
        bandtitle.textColor = [UIColor darkTextColor];
        
        bandtitle.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:bandtitle];
        
        UILabel *bandname = [[UILabel alloc] init];
        
        self.bandNameLab = bandname;
        
        bandname.textColor = [UIColor darkGrayColor];
        
        bandname.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:bandname];
        
        UILabel *bandcard = [[UILabel alloc] init];
        
        self.bandCardLab = bandcard;
        
        bandcard.textColor = [UIColor darkGrayColor];
        
        bandcard.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:bandcard];
        
        UILabel *balancetitle = [[UILabel alloc] init];
        
        self.balanceTitleLab = balancetitle;
        
        balancetitle.textColor = [UIColor darkTextColor];
        
        balancetitle.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:balancetitle];
        
        UILabel *balance = [[UILabel alloc] init];
        
        self.balanceLab = balance;
        
        balance.textColor = [UIColor darkGrayColor];
        
        balance.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:balance];
        
        UITextField *count = [[UITextField alloc] init];
        
        self.countField = count;
        
        count.backgroundColor = [UIColor whiteColor];
        
        count.keyboardType = UIKeyboardTypeDecimalPad;
        
        [count addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:count];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.sureBtn = sure;
        
        [sure setTitle:@"确认提现" forState:0];
        
        [sure setTitleColor:[UIColor whiteColor] forState:0];
        
        [sure setBackgroundColor:[UIColor colorWithRed:0/255.f green:179/255.f blue:255/255.f alpha:1.0]];
        
        sure.layer.masksToBounds = YES;
        
        sure.layer.cornerRadius = 5;
        
        [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sure];
        
    }
    
    return self;
    
}

- (void)countChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(CountFieldChange:)]) {
        
        [self.delegate CountFieldChange:field];
        
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
}

-(void)setFrameModel:(TiXian_Frame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.bandTitleLab.frame = self.frameModel.bandTitleF;
    
    self.bandNameLab.frame = self.frameModel.bandNameF;
    
    self.bandCardLab.frame = self.frameModel.bandCardF;
    
    self.balanceTitleLab.frame = self.frameModel.balanceTitleF;
    
    self.balanceLab.frame = self.frameModel.balanceF;
    
    self.countField.frame = self.frameModel.countF;
    
    CGSize size = [self sizeWithText:@"提现金额:" font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(0,self.frameModel.countF.size.height)];
    
    CGFloat labW = SCREENWIDTH * 0.032 + size.width + 10;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labW, self.frameModel.countF.size.height)];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    lab.font = [UIFont systemFontOfSize:17];
    
    lab.textColor = [UIColor darkTextColor];
    
    lab.text = @"提现金额:";
    
    self.countField.leftViewMode = UITextFieldViewModeAlways;
    
    self.countField.leftView = lab;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {
    
    TiXian_Model *model = self.frameModel.tixianModel;
    
    self.bandTitleLab.text = @"到账银行卡";
    
    self.bandNameLab.text = model.bandName;
    
    self.bandCardLab.text = model.bandCard;
    
    self.balanceTitleLab.text = @"账户余额";
    
    self.balanceLab.text = model.balance;
    
    if ([self isBlankString:model.count]) {
        
        self.countField.text = @"";
        
    }else {
        
        self.countField.text = model.count;
        
    }
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
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
