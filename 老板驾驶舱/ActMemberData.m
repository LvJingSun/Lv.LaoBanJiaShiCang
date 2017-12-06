//
//  ActMemberData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-11.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ActMemberData.h"

@implementation MemberData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)ActMemberList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"ActMemberList"];
    
    for (NSDictionary *dic in items) {
        
        MemberDetailData *item = [[MemberDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}

@end


@implementation MemberDetailData




- (NSString *)NickName{
    
    return [mDictionary objectForKey:@"NickName"];
    
}

- (NSString *)FenSi{
    
    return [mDictionary objectForKey:@"FenSi"];
    
}

- (NSString *)GuanZhu{
    
    return [mDictionary objectForKey:@"GuanZhu"];
    
}

- (NSString *)FenXiang{
    
    return [mDictionary objectForKey:@"FenXiang"];
    
}

- (NSString *)PhotoHead{
    
    return [mDictionary objectForKey:@"PhotoHead"];
    
}



@end