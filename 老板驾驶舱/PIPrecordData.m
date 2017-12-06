//
//  PIPrecordData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-9.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "PIPrecordData.h"

@implementation PIPrecordData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)MctWithdrawalList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"MctWithdrawalList"];
    
    
    for (NSDictionary *dic in items) {
        
        PiprecordDetailData *item = [[PiprecordDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}

@end



@implementation PiprecordDetailData



- (NSString *)Amount{
    
    return [mDictionary objectForKey:@"Amount"];
    
}

- (NSString *)CreateTime{
    
    return [mDictionary objectForKey:@"CreateTime"];
    
}

@end
