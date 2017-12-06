//
//  AlertUtil.h
//  baozhifu
//
//  Created by mac on 13-6-12.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertUtil : NSObject

+ (AlertUtil *) sharedAlert;

- (void)show;

- (void)showWithStatus:(NSString *)status;

- (void)dismiss;

- (void)dismissSuccess:(NSString *)sucess;

- (void)dismissError:(NSString *)error;

@end
