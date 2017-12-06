//
//  DelegatepeopleData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-17.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "DelegatepeopleData.h"

@implementation DelegatepeopleData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSDictionary *)ResMember{
    
    NSDictionary *items = [mDictionary getDictionary:@"ResMember"];
    
    return items;
    
}

@end



@implementation DelegateDetailData

- (NSString *)NewAgentChangeApplicationID{
    
    return [mDictionary objectForKey:@"NewAgentChangeApplicationID"];
    
}

- (NSString *)OldRealName{
    
    return [mDictionary objectForKey:@"OldRealName"];
    
}

- (NSString *)OldMemberID{
    
    return [mDictionary objectForKey:@"OldMemberID"];
    
}

- (NSString *)OldNickName{
    
    return [mDictionary objectForKey:@"OldNickName"];
    
}

- (NSString *)OldPhone{
    
    return [mDictionary objectForKey:@"OldPhone"];
    
}

- (NSString *)OldEmail{
    
    return [mDictionary objectForKey:@"OldEmail"];
    
}

- (NSString *)OldSex{
    
    return [mDictionary objectForKey:@"OldSex"];
    
}

- (NSString *)NewRealName{
    
    return [mDictionary objectForKey:@"NewRealName"];
    
}

- (NSString *)NewMemberID{
    
    return [mDictionary objectForKey:@"NewMemberID"];
    
}

- (NSString *)NewNickName{
    
    return [mDictionary objectForKey:@"NewNickName"];
    
}

- (NSString *)NewPhone{
    
    return [mDictionary objectForKey:@"NewPhone"];
    
}

- (NSString *)NewEmail{
    
    return [mDictionary objectForKey:@"NewEmail"];
    
}

- (NSString *)NewSex{
    
    return [mDictionary objectForKey:@"NewSex"];
    
}

- (NSString *)NewReasonChange{
    
    return [mDictionary objectForKey:@"NewReasonChange"];
    
}

- (NSString *)NewFeedBackMsg{
    
    return [mDictionary objectForKey:@"NewFeedBackMsg"];
    
}

- (NSString *)NewStatus{
    
    return [mDictionary objectForKey:@"NewStatus"];
    
}

- (NSString *)NewAppFormPhoto{
    
    return [mDictionary objectForKey:@"NewAppFormPhoto"];
    
}



@end
