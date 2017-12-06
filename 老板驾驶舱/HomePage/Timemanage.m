//
//  Timemanage.m
//  BusinessCenter
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import "Timemanage.h"

@interface Timemanage ()

@property (nonatomic, retain) NSTimer *timer;

@end

@implementation Timemanage

+ (Timemanage *)shareManage {

    static Timemanage *timemanageInstance = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        timemanageInstance = [[self alloc] init];
        
    });
    
    return timemanageInstance;
    
}

- (void)timerStart {

    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(UpdateUI) userInfo:nil repeats:YES];
        
    }
}

- (void)timerPause {

    if (_timer.valid) {
        
        [_timer invalidate];
        
    }
    
    _timer=nil;
    
}

- (void)UpdateUI {
    
    self.time --;

    [self.delegate changeLabelWithString:self.time];
    
}

@end
