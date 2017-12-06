//
//  DingdangData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-9.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "DingdangData.h"

@implementation DingdangData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)PrOrderList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"PrOrderList"];
    
    NSLog(@"dic = %@,count = %i",mDictionary,items.count);
    
    for (NSDictionary *dic in items) {
        
        DingdangDetailData *item = [[DingdangDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    NSLog(@"retarray .count = %i",retArray.count);
    
    return retArray;
    
}

@end



@implementation DingdangDetailData



- (NSString *)OrdersCode{
    
    return [mDictionary objectForKey:@"OrdersCode"];
    
}

- (NSString *)NickName{
    
    return [mDictionary objectForKey:@"NickName"];
    
}

- (NSString *)UseDescript{
    
    return [mDictionary objectForKey:@"UseDescript"];
    
}

- (NSString *)Amount{
    
    return [mDictionary objectForKey:@"Amount"];
    
}

- (NSString *)UseDate{
    
    return [mDictionary objectForKey:@"UseDate"];
    
}

- (NSString *)UnitPrice{
    
    return [mDictionary objectForKey:@"UnitPrice"];
    
}

- (NSString *)TotalAmount{
    
    return [mDictionary objectForKey:@"TotalAmount"];
    
}

@end
