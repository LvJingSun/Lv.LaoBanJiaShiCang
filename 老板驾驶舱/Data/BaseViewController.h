//
//  BaseViewController.h
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>





#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define  viewsize [ UIScreen mainScreen ].applicationFrame

#define HANZI_START 19968
#define HANZI_COUNT 20902


@interface BaseViewController : UIViewController<UITextFieldDelegate> {
    BOOL keyboardShow;
}

@property(strong, nonatomic) UIButton *doneInKeyboardButton;

@property(weak, nonatomic) UITextField *activeField;

@property(assign, nonatomic) BOOL needHiddenDone;

@property(weak, nonatomic) IBOutlet UIScrollView *rootScrollView;

@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;


// 返回上一级
- (void)goBack;

-(void)ViewFrame;

-(void)hidenKeyboard;

- (BOOL)textFieldShouldReturn:(UITextField *)sender;//return


- (IBAction)showNumPadDone:(id)sender;

- (IBAction)hiddenNumPadDone:(id)sender;

- (void)setUpForDismissKeyboard;

// 检查网络
- (BOOL)isConnectionAvailable;

- (float)textLength:(NSString *)text;

// 判断手机号码是否正确的格式
- (BOOL)isMobileNumber:(NSString *)mobileNum;
// webview上拉下拉时显示的区域为白色的背景
- (void) hideGradientBackground:(UIView*)theView;
// 判断邮箱格式是否正确
- (BOOL)isValidateEmail:(NSString *)email;

- (void)setExtraCellLineHidden: (UITableView *)tableView;


@end
