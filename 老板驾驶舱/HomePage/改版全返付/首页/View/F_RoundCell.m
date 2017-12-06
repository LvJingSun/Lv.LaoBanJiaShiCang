//
//  F_RoundCell.m
//  BusinessCenter
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_RoundCell.h"
#import "ZJScrollPageView.h"

#import "R_ShopViewController.h"
#import "R_StaffViewController.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define Round1Color [UIColor colorWithRed:242/255. green:89/255. blue:68/255. alpha:1.]
#define Round2Color [UIColor colorWithRed:29/255. green:172/255. blue:145/255. alpha:1.]
#define Round3Color [UIColor colorWithRed:0/255. green:165/255. blue:230/255. alpha:1.]
#define Round4Color [UIColor colorWithRed:52/255. green:116/255. blue:196/255. alpha:1.]
#define Round5Color [UIColor colorWithRed:245/255. green:153/255. blue:1/255. alpha:1.]
#define Round6Color [UIColor colorWithRed:190/255. green:149/255. blue:228/255. alpha:1.]

@interface F_RoundCell ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation F_RoundCell

+ (instancetype)F_RoundCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"F_RoundCell";
    
    F_RoundCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[F_RoundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        
        top.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.];
        
        [self addSubview:top];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(top.frame) + 15, SCREENWIDTH * 0.45, 20)];
        
        title.font = [UIFont boldSystemFontOfSize:15];
        
        title.textColor = [UIColor blackColor];
        
        title.text = @"本月赠送情况";
        
        [self addSubview:title];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.5, CGRectGetMaxY(top.frame) + 15, SCREENWIDTH * 0.45, 20)];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:13];
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.textColor = [UIColor blackColor];
        
        count.text = @"0(个)";
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(title.frame) + 14.5, SCREENWIDTH * 0.9, 0.5)];
        
        line.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:line];
        

            
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        
        style.showLine = YES;
        
        style.gradualChangeTitleColor = YES;
        
        style.scrollTitle = NO;
        
        style.normalTitleColor = [UIColor colorWithRed:57/255. green:57/255. blue:57/255. alpha:1.];
        
        style.selectedTitleColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.];
        
        style.scrollLineColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.];
        
        style.segmentHeight = 40;
        
        style.titleFont = [UIFont systemFontOfSize:17];
        
        self.titles = @[@"员工",@"店铺"];
        
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), SCREENWIDTH, 360) segmentStyle:style titles:self.titles parentViewController:[self getCurrentViewController] delegate:self];
        
        [self addSubview:scrollPageView];
            
        
        self.height = CGRectGetMaxY(scrollPageView.frame);
        
    }
    
    return self;
    
}

- (NSInteger)numberOfChildViewControllers {
    
    return self.titles.count;
    
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (index == 0) {
        
        childVc = [[R_StaffViewController alloc] init];
        
        childVc.view.backgroundColor = [UIColor whiteColor];
        
    }else if (index == 1) {
        
        childVc = [[R_ShopViewController alloc] init];
        
        childVc.view.backgroundColor = [UIColor whiteColor];
        
    }
    
    return childVc;
    
}

/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
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
