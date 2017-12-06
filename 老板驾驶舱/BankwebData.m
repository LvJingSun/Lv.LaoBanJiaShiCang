//
//  BankwebData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-20.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BankwebData.h"

@implementation BankwebData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)cNAPSInfo{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"cNAPSInfo"];
    
    for (NSDictionary *dic in items) {
        
        BankwebDetailData *item = [[BankwebDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    return retArray;
    
}
@end




@implementation BankwebDetailData

- (NSString *)OrgValue{
    
    return [mDictionary objectForKey:@"OrgValue"];
    
}


- (NSString *)OrgName{
    
    return [mDictionary objectForKey:@"OrgName"];
    
}



@end