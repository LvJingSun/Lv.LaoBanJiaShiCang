//
//  BankData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BankData.h"

@implementation BankData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}


- (NSDictionary *)MctBankCard{
    
    NSDictionary *items = [mDictionary getDictionary:@"MctBankCard"];
    
    return items;
    
}

@end




@implementation BankDetailData

- (NSString *)BankCardChangeApplicationID{
    
    return [mDictionary objectForKey:@"BankCardChangeApplicationID"];
    
}

- (NSString *)OldAccountCategory{
    
    return [mDictionary objectForKey:@"OldAccountCategory"];
    
}

- (NSString *)OldCardName{
    
    return [mDictionary objectForKey:@"OldCardName"];
    
}

- (NSString *)OldBankCode{
    
    return [mDictionary objectForKey:@"OldBankCode"];
    
}

- (NSString *)OldBankName{
    
    return [mDictionary objectForKey:@"OldBankName"];
    
}


- (NSString *)OldBranchCode{
    
    return [mDictionary objectForKey:@"OldBranchCode"];
    
}

- (NSString *)OldBranchName{
    
    return [mDictionary objectForKey:@"OldBranchName"];
    
}

- (NSString *)OldCardNumber{
    
    return [mDictionary objectForKey:@"OldCardNumber"];
    
}


- (NSString *)NewAccountCategory{
    
    return [mDictionary objectForKey:@"NewAccountCategory"];
    
}

- (NSString *)NewBankCode{
    
    return [mDictionary objectForKey:@"NewBankCode"];
    
}

- (NSString *)NewCardName{
    
    return [mDictionary objectForKey:@"NewCardName"];
    
}

- (NSString *)NewBankName{
    
    return [mDictionary objectForKey:@"NewBankName"];
    
}


- (NSString *)NewBranchCode{
    
    return [mDictionary objectForKey:@"NewBranchCode"];
    
}

- (NSString *)NewBranchName{
    
    return [mDictionary objectForKey:@"NewBranchName"];
    
}

- (NSString *)NewCardNumber{
    
    return [mDictionary objectForKey:@"NewCardNumber"];
    
}


- (NSString *)NewReasonChange{
    
    return [mDictionary objectForKey:@"NewReasonChange"];
    
}

- (NSString *)NewStatus{
    
    return [mDictionary objectForKey:@"NewStatus"];
    
}


- (NSString *)NewAppFormPhoto{
    
    return [mDictionary objectForKey:@"NewAppFormPhoto"];
    
}


- (NSString *)NewFeedBackMsg{
    
    return [mDictionary objectForKey:@"NewFeedBackMsg"];
    
}



@end

