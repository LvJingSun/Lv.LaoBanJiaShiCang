//
//  BasicFatherSoonData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-12.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BasicFatherSoonData.h"

@implementation BasicFatherSoonData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)MerchantClassList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"MerchantClassList"];
    
    
    for (NSDictionary *dic in items) {
        
        BasicFatherSoonDetailData *item = [[BasicFatherSoonDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}

@end



@implementation BasicFatherSoonDetailData

- (NSString *)ClassID{
    
    return [mDictionary objectForKey:@"ClassID"];
    
}

- (NSString *)ClassName{
    
    return [mDictionary objectForKey:@"ClassName"];
    
}

@end