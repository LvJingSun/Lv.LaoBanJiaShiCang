//
//  salesrecordData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "salesrecordData.h"

@implementation salesrecordData



- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)OrderList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"OrderList"];
    
    
    for (NSDictionary *dic in items) {
        
        salesrecordDetailData *item = [[salesrecordDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}


@end



@implementation salesrecordDetailData

- (NSString *)OrdCode{
    
    return [mDictionary objectForKey:@"OrdCode"];
    
}

- (NSString *)NickName{
    
    return [mDictionary objectForKey:@"NickName"];
    
}

- (NSString *)SvcName{
    
    return [mDictionary objectForKey:@"SvcName"];
    
}
- (NSString *)ServiceID{
    
    return [mDictionary objectForKey:@"ServiceID"];
    
}

- (NSString *)UnitPrice{
    
    return [mDictionary objectForKey:@"UnitPrice"];
    
}

- (NSString *)Amount{
    
    return [mDictionary objectForKey:@"Amount"];
    
}
- (NSString *)TotalAmount{
    
    return [mDictionary objectForKey:@"TotalAmount"];
    
}



@end
