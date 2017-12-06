//
//  shopFatherSoonData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-13.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "shopFatherSoonData.h"

@implementation shopFatherSoonData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)CityList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"CityList"];
    
    for (NSDictionary *dic in items) {
        
        shopFatherSoonDetailData *item = [[shopFatherSoonDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    return retArray;
    
}

@end



@implementation shopFatherSoonDetailData

- (NSString *)CityId{
    
    return [mDictionary objectForKey:@"CityId"];
    
}

- (NSString *)CityName{
    
    return [mDictionary objectForKey:@"CityName"];
    
}

- (NSString *)ParentId{
    
    return [mDictionary objectForKey:@"ParentId"];
    
}

@end