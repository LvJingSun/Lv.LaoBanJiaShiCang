//
//  PIPinorexData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-9.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "PIPinorexData.h"

@implementation PIPinorexData



- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)MerchantTranRcdsList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"MerchantTranRcdsList"];
    
    
    for (NSDictionary *dic in items) {
        
        PIPinorexDetailData *item = [[PIPinorexDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}

@end



@implementation PIPinorexDetailData

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
