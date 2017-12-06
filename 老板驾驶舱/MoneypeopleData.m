//
//  MoneypeopleData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-16.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "MoneypeopleData.h"

@implementation MoneypeopleData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)CashierInfoList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"CashierInfoList"];
    
    for (NSDictionary *dic in items) {
        
        MoneypeopleDetailData *item = [[MoneypeopleDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    return retArray;
    
}
@end




@implementation MoneypeopleDetailData

- (NSString *)CashierAccountID{
    
    return [mDictionary objectForKey:@"CashierAccountID"];
    
}


- (NSString *)LoginIp{
    
    return [mDictionary objectForKey:@"LoginIp"];
    
}

- (NSString *)LoginTime{
    
    return [mDictionary objectForKey:@"LoginTime"];
    
}

- (NSString *)CreateTime{
    
    return [mDictionary objectForKey:@"CreateTime"];
    
}

- (NSString *)ShopId{
    
    return [mDictionary objectForKey:@"ShopId"];
    
}

- (NSString *)ShopName{
    
    return [mDictionary objectForKey:@"ShopName"];
    
}

- (NSString *)Account{
    
    return [mDictionary objectForKey:@"Account"];
    
}

- (NSString *)Status{
    
    return [mDictionary objectForKey:@"Status"];
    
}

- (NSString *)Name{
    
    return [mDictionary objectForKey:@"Name"];
    
}

- (NSString *)PhotoHead{
    
    return [mDictionary objectForKey:@"PhotoHead"];
    
}


- (NSString *)Phone{
    
    return [mDictionary objectForKey:@"Phone"];
    
}
@end
