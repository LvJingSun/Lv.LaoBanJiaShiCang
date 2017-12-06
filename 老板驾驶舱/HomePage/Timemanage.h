//
//  Timemanage.h
//  BusinessCenter
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChangeLabel <NSObject>

- (void)changeLabelWithString:(int)time;

@end

@interface Timemanage : NSObject

//@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int time;

@property (nonatomic, retain) id<ChangeLabel> delegate;

+ (Timemanage *)shareManage;

- (void)timerStart;

- (void)timerPause;

@end
