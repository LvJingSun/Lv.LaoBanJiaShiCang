//
//  F_ListViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "F_ListViewController.h"
#import "ZJScrollPageView.h"

#import "L_GetViewController.h"
#import "L_SendViewController.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface F_ListViewController ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation F_ListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"交易记录";
    
    [self initWithScrollStyle];

}

//初始化分页控制器
- (void)initWithScrollStyle {

    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    
    style.showLine = YES;
    
    style.gradualChangeTitleColor = YES;
    
    style.scrollTitle = NO;
    
    style.normalTitleColor = [UIColor colorWithRed:57/255. green:57/255. blue:57/255. alpha:1.];
    
    style.selectedTitleColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.];
    
    style.scrollLineColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.];
    
    style.segmentHeight = 40;
    
    style.titleFont = [UIFont systemFontOfSize:17];
    
    self.titles = @[@"充值",@"赠送"];
    
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    //原parentViewController——[self getCurrentViewController]
    //现改为self，后面view可以push页面
    
    [self.view addSubview:scrollPageView];
    
}

- (NSInteger)numberOfChildViewControllers {
    
    return self.titles.count;
    
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (index == 0) {
        
        childVc = [[L_GetViewController alloc] init];
        
        childVc.view.backgroundColor = [UIColor whiteColor];
        
    }else if (index == 1) {
        
        childVc = [[L_SendViewController alloc] init];
        
        childVc.view.backgroundColor = [UIColor whiteColor];
        
    }
    
    return childVc;
    
}

/** 获取当前View的控制器对象 */
//-(UIViewController *)getCurrentViewController{
//    UIResponder *next = [self nextResponder];
//    do {
//        if ([next isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)next;
//        }
//        next = [next nextResponder];
//    } while (next != nil);
//    return nil;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
