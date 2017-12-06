//
//  AlertUtil.m
//  baozhifu
//
//  Created by mac on 13-6-12.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "AlertUtil.h"
#import "SVProgressHUD.h"

@implementation AlertUtil

+ (AlertUtil *) sharedAlert {
    static AlertUtil *_sharedAlert = nil;
    if (!_sharedAlert) {
        _sharedAlert = [[AlertUtil alloc] init];
    }
    return _sharedAlert;
}

- (void)show {
	[SVProgressHUD show];
}

- (void)showWithStatus:(NSString *)status {
    [SVProgressHUD showWithStatus:status];
};

- (void)dismiss {
	[SVProgressHUD dismiss];
}

- (void)dismissSuccess:(NSString *)sucess {
	[SVProgressHUD showSuccessWithStatus:sucess];
}

- (void)dismissError:(NSString *)error {
	[SVProgressHUD showErrorWithStatus:error];
}

- (void) showAlertViewWithTitle:(NSString *)title message:(NSString *)msg {
    UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alerView show];
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:alerView, @"alerView", nil];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dismissAlertView:) userInfo:userInfo repeats:NO];
}

- (void)dismissAlertView:(NSTimer *)timer {
    UIAlertView * alerView = [timer.userInfo objectForKey:@"alerView"];
    [alerView dismissWithClickedButtonIndex:0 animated:YES];
}

@end
