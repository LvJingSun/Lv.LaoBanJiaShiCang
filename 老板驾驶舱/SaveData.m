//
//  passwordData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-15.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "SaveData.h"

@implementation SaveData
- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}


@end


