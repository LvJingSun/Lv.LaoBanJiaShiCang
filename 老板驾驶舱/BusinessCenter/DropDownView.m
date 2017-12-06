//
//  DropDownView.m
//  BusinessCenter
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "DropDownView.h"
#import "DropDownCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface DropDownView () {

    CGFloat ViewHeight;
    
}

@property (nonatomic, weak) UIView *BJView;

@property (nonatomic, strong) UIView *backimageView;

@end

@implementation DropDownView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        
    }
    
    return self;
    
}

- (id)initWithTitleArray:(NSArray *)titleArray {

    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < titleArray.count; i ++) {
            
            DropDownCell *cell = [[DropDownCell alloc] init];
            
            cell.frame = CGRectMake(0, cell.height * i, SCREEN_WIDTH, cell.height);
            
            cell.titleLab.text = [NSString stringWithFormat:@"%@",titleArray[i]];
            
            cell.clickBtn.tag = i;
            
            [cell.clickBtn addTarget:self action:@selector(TitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:cell];
            
            ViewHeight = CGRectGetMaxY(cell.frame);
            
        }
        
    }
    
    return self;
    
}

- (void)TitleBtnClick:(UIButton *)sender {
    
//    if (self.didClickBlock) {
//        
//        self.didClickBlock();
//        
//    }
    
    if (self.returnsender) {
        
        self.returnsender(sender);
        
    }


    
    [self dismissAlert];
    
}

- (void)ReturnBlock:(ReturnSender)block {

    self.returnsender = block;
    
}

- (void)show {

    //获取第一响应视图视图
    UIViewController *topVC = [self appRootViewController];
    
    UIView *bjview = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.BJView = bjview;
    
    bjview.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];
    
    self.frame = CGRectMake(0, 64, topVC.view.bounds.size.width, ViewHeight);
    
    self.alpha = 1.f;
    
    [topVC.view addSubview:bjview];
    
    [topVC.view addSubview:self];
    
}

- (void)dismissAlert {
    
    [self.BJView removeFromSuperview];
    
    [self removeFromSuperview];
    
    if (self.dismissBlock) {
        
        self.dismissBlock();
        
    }
    
}

- (void)removeFromSuperview {
    
    [self.backimageView removeFromSuperview];
    
    self.backimageView = nil;
    
    UIViewController *topVC = [self appRootViewController];
    
    CGRect afterFrame = CGRectMake(0, 64, topVC.view.bounds.size.width, ViewHeight);
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.frame = afterFrame;
        
        self.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        [super removeFromSuperview];
        
    }];
    
}

//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    if (newSuperview == nil) {
        
        return;
        
    }
    
    //     获取根控制器
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        
        self.backimageView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        
        self.backimageView.backgroundColor = [UIColor clearColor];
        
        self.backimageView.alpha = 0.7f;
        
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
    }
    
    //    加载背景背景图,防止重复点击
    [topVC.view addSubview:self.backimageView];
    
    CGRect afterFrame = CGRectMake(0, 64, topVC.view.bounds.size.width, ViewHeight);
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.frame = afterFrame;
        
        self.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [super willMoveToSuperview:newSuperview];
    
}

- (UIViewController *)appRootViewController {
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *topVC = appRootVC;
    
    while (topVC.presentedViewController) {
        
        topVC = topVC.presentedViewController;
        
    }
    
    return topVC;
    
}

@end
