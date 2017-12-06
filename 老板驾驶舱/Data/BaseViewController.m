//
//  BaseViewController.m
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "Reachability.h"
#import "SVProgressHUD.h"


@interface BaseViewController ()


@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.needHiddenDone = YES;
        keyboardShow = NO;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    
    [self setUpForDismissKeyboard];
    

}

- (void)setUpForDismissKeyboard {
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self hidenKeyboard];
}

- (void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    if ( isIOS7 ) {
        
        self.navigationController.navigationBar.translucent = NO;
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    self.rootScrollView.contentOffset = CGPointMake(0, 0);

}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}


-(void)ViewFrame
{
    if ( isIOS7 ) {
        
        self.navigationController.view.frame = CGRectMake(0, 20, viewsize.size.width, viewsize.size.height);
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    return YES;
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneInKeyboardButton.superview)
    {
        [self.doneInKeyboardButton removeFromSuperview];
    }
    if (!keyboardShow) {
        return;
    }
    if (self.rootScrollView != nil) {
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keybroundSize = [value CGRectValue].size;
        CGRect viewFrame = [self.rootScrollView frame];
        viewFrame.size.height += keybroundSize.height;
        self.rootScrollView.frame = viewFrame;
    }
    keyboardShow = NO;
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneInKeyboardButton == nil)
    {
        self.doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        if (screenHeight==568.0f) {//爱疯5
            self.doneInKeyboardButton.frame = CGRectMake(0, 568 - 53, 106, 53);
        } else {//3.5寸
            self.doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
        }
        self.doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        self.doneInKeyboardButton.hidden=self.needHiddenDone;
        [self.doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up.png"] forState:UIControlStateNormal];
        [self.doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down.png"] forState:UIControlStateHighlighted];
        [self.doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:2];
    if (self.doneInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:self.doneInKeyboardButton];    // 注意这里直接加到window上
    }
    self.doneInKeyboardButton.hidden=self.needHiddenDone;
    if (keyboardShow) {
        return;
    }
    if (self.rootScrollView != nil) {
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keybroundSize = [value CGRectValue].size;
        CGRect viewFrame = [self.rootScrollView frame];
        viewFrame.size.height -= keybroundSize.height;
        self.rootScrollView.frame = viewFrame;
        //[self performSelector:@selector(moveToActiveView) withObject:nil afterDelay:0.5];
        [self moveToActiveView];
    }
    keyboardShow = YES;
}

- (void)moveToActiveView {
    if (self.activeField != nil) {
        //CGRect textFieldRect = [self.activeField frame];
        CGRect textFieldRect = [self.activeField.superview frame];
        //NSLog(@"(%.0f,%.0f,%.0f,%.0f,)", textFieldRect.origin.x, textFieldRect.origin.y, textFieldRect.size.width, textFieldRect.size.height);
        [self.rootScrollView scrollRectToVisible:textFieldRect animated:YES];
    }
}

- (void)finishAction {
    [self hidenKeyboard];
}

- (IBAction)showNumPadDone:(id)sender {
    self.needHiddenDone = NO;
    self.doneInKeyboardButton.hidden=self.needHiddenDone;
}

- (IBAction)hiddenNumPadDone:(id)sender {
    self.needHiddenDone = YES;
    self.doneInKeyboardButton.hidden=self.needHiddenDone;
}

// 判断网络不好
- (BOOL)isConnectionAvailable{
    
    BOOL  isExistenceNetWork = YES;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ( [reach currentReachabilityStatus] ) {
        case NotReachable:
            isExistenceNetWork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetWork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetWork = YES;
            break;
            
        default:
            break;
    }
    
    if ( !isExistenceNetWork ) {
        
        [SVProgressHUD showErrorWithStatus:@"网络不给力，请稍后再试！"];        
        
    }
    
    
    return isExistenceNetWork;
    
}

// 判断手机号码是否正确的格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    NSString  *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSString  *MOBILENWE = @"^1(4[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    
    //添加电信 新的手机号码格式字段
    NSPredicate *regextestmobilenew = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILENWE];
    
    if (([regextestmobile  evaluateWithObject:mobileNum] == YES) ||
        ([regextestcm evaluateWithObject:mobileNum] == YES) ||
        ([regextestmobilenew evaluateWithObject:mobileNum] == YES)|| ([regextestct
                                                                       evaluateWithObject:mobileNum] == YES) || ([regextestcu
                                                                                                                  evaluateWithObject:mobileNum] == YES )){
        
        return  YES;
        
    } else{
        
        return  NO;
        
        
    }
    
    
}




- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

- (BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}



// 计算字数的多少 - 如果为汉字则加2，否则加1
- (float)textLength:(NSString *)text{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        if ( [self isHaveChineseCharacters:[text substringWithRange:NSMakeRange(index, 1)]] ) {
            number = number + 2;
        }else{
            number = number + 1;
        }
    }
    return number;
}

- (BOOL)isHaveChineseCharacters:(NSString *)_text
{
    for(int i = 0; i < [(NSString *)_text length]; ++i) {
        int a = [(NSString *)_text characterAtIndex:i];
        
        if ([self isChineseCharacters_utf8:a]) {
            return YES;
        } else {
            continue;
        }
    }
    return NO;
}

- (BOOL)isChineseCharacters_utf8:(NSInteger)characterAtIndex {
    if(characterAtIndex >= HANZI_START && characterAtIndex <= HANZI_COUNT+HANZI_START) {
        return YES;
    } else {
        return NO;
    }
    //acoutnt++;
    //acount*2+bcount;
}


//隐藏多余分栏线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
