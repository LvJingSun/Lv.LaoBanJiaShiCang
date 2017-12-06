//
//  ScrollView.m
//  BusinessCenter
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "ScrollView.h"
#import "WaringView.h"
#import "AppHttpClient.h"
#define HOME_BACK_COLOR [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.]

@interface ScrollView ()

@property (nonatomic, weak) WaringView *waringView;

@property (nonatomic, strong) NSArray *yujingtishiArray;

@end

@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
        
        NSArray *yujingarray = [userDefau objectForKey:@"setArr"];
        
        UIImageView *tTImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, frame.size.width * 0.25-15, frame.size.height-13)];
        
        tTImageView.image = [UIImage imageNamed:@"TBHL_logo-1"];
        
        [self addSubview:tTImageView];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width * 0.25, 3, 1, frame.size.height-7)];
        
        line2.backgroundColor = HOME_BACK_COLOR;
        
        [self addSubview:line2];
        
        WaringView *waringview = [[WaringView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line2.frame), 1, frame.size.width - CGRectGetMaxX(line2.frame), frame.size.height -1)];
        
        self.waringView = waringview;
        
        waringview.waringArr = yujingarray;
        
//        waringview.waringArr = self.scrArray;
        
        [self addSubview:waringview];
        
    }
    
    return self;
    
}


@end
