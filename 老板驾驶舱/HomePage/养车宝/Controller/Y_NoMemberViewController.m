//
//  Y_NoMemberViewController.m
//  BusinessCenter
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "Y_NoMemberViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface Y_NoMemberViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webview;

@end

@implementation Y_NoMemberViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"养车宝";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    webview.delegate = self;
    
    self.webview = webview;
    
    //加载请求的时候忽略缓存
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    
    [self.view addSubview:webview];
    
    [webview loadRequest:request];
    
    [webview setMediaPlaybackRequiresUserAction:NO];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    __weak typeof(self) weakself = self;
    
    JSContext *contect = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    contect[@"backappactivity"] = ^() {
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
    };
    
    contect[@"telappactivity"] = ^() {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.photoNum]]];
        
    };
    
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
