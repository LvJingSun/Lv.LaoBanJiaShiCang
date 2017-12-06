//
//  xitongxiaoxiData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "xitongxiaoxiData.h"

@implementation xitongxiaoxiData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)MerchantMessageList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"MerchantMessageList"];
    
    
    for (NSDictionary *dic in items) {
        
        xitongxiaoxiDetailData *item = [[xitongxiaoxiDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}


@end



@implementation xitongxiaoxiDetailData

- (NSString *)MsgTitle{
    
    return [mDictionary objectForKey:@"MsgTitle"];
    
}

- (NSString *)MsgCot{
    
    return [mDictionary objectForKey:@"MsgCot"];
    
}

- (NSString *)CreateDate{
    
    return [mDictionary objectForKey:@"CreateDate"];
    
}
- (NSString *)MsgLink{
    
    return [mDictionary objectForKey:@"MsgLink"];
    
}

- (NSString *)NickName{
    
    return [mDictionary objectForKey:@"NickName"];
    
}




@end






















