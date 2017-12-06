//
//  PIPBankData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-9.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "PIPBankData.h"

@implementation PIPBankData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSDictionary *)BZFInfo{
    
    //NSMutableDictionary *retDic = [[NSMutableDictionary alloc] init];
    
    NSDictionary *items = [mDictionary getDictionary:@"BZFInfo"];
    
    
   // NSLog(@"retarray .count = %i",retDic.count);
    
    return items;
    
}

@end


@implementation PIPBankDetailData



- (NSString *)TotalNumber{
    
    return [mDictionary objectForKey:@"TotalNumber"];
    
}

- (NSString *)TotalAmount{
    
    return [mDictionary objectForKey:@"TotalAmount"];
    
}

- (NSString *)CardNumber{
    
    return [mDictionary objectForKey:@"CardNumber"];
    
}



@end
