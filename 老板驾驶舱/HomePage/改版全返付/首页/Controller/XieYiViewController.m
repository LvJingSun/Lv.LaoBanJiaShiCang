//
//  XieYiViewController.m
//  BusinessCenter
//
//  Created by mac on 2016/12/7.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "XieYiViewController.h"

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface XieYiViewController ()

@end

@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"协议";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.9, SCREEN_HEIGHT - 84)];
    
    textview.textColor = [UIColor darkGrayColor];
    
    if ([self.type isEqualToString:@"1"]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *fensibaoExtension = [defaults objectForKey:@"fensibao_extension"];
        
        textview.text = fensibaoExtension;
        
    }else if ([self.type isEqualToString:@"2"]) {
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *fensibaoExtension = [defaults objectForKey:@"yangchebao_extension"];
        
        textview.text = fensibaoExtension;
        
    }
    
    [self.view addSubview:textview];

}

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
