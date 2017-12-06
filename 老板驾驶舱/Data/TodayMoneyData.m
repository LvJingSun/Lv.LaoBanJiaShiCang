//
//  TodayMoneyData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "TodayMoneyData.h"

@implementation TodayMoneyData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)MerchantTranRcdsList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"MerchantTranRcdsList"];
    
//    NSLog(@"dic = %@,count = %i",mDictionary,items.count);
    
    for (NSDictionary *dic in items) {
        
        TodayDetailData *item = [[TodayDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
//    NSLog(@"retarray .count = %i",retArray.count);
    
    return retArray;
    
}

@end



@implementation TodayDetailData

- (NSString *)TransactionDate{
    
    return [mDictionary objectForKey:@"TransactionDate"];
    
}

- (NSString *)Amount{
    
    return [mDictionary objectForKey:@"Amount"];
    
}

- (NSString *)Description{
    
    return [mDictionary objectForKey:@"Description"];
    
}

@end
