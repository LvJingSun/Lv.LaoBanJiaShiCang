//
//  ProductData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-6.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ProductData.h"

@implementation ProductData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)ProductsList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"ProductsList"];

    for (NSDictionary *dic in items) {
        
        ProductDetailData *item = [[ProductDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}



@end



@implementation ProductDetailData


- (NSArray *)ProductPostersList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    NSArray *array = [mDictionary getArray:@"ProductPostersList"];
    
    for (NSDictionary*dic in array)
    {
        ProductPhontoData *item = [[ProductPhontoData alloc] initWithJsonObject:dic];
        [retArray addObject:item];
        
    }
    
    return retArray;
}



- (NSString *)PClassValue{
    
    return [mDictionary objectForKey:@"PClassValue"];
    
}

- (NSString *)PClassId{
    
    return [mDictionary objectForKey:@"PClassId"];
    
}

- (NSString *)ServiceId{
    
    return [mDictionary objectForKey:@"ServiceId"];
    
}

- (NSString *)MerchantId{
    
    return [mDictionary objectForKey:@"MerchantId"];
    
}

- (NSString *)SvcName{
    
    return [mDictionary objectForKey:@"SvcName"];
    
}

- (NSString *)SvcSimpleName{
    
    return [mDictionary objectForKey:@"SvcSimpleName"];
    
}
- (NSString *)ServiceCode{
    
    return [mDictionary objectForKey:@"ServiceCode"];
    
}

- (NSString *)ClassId{
    
    return [mDictionary objectForKey:@"ClassId"];
    
}

- (NSString *)ClassValue{
    
    return [mDictionary objectForKey:@"ClassValue"];
    
}

- (NSString *)SvcSoldAmount{
    
    return [mDictionary objectForKey:@"SvcSoldAmount"];
}


- (NSString *)Quantity{
    
    return [mDictionary objectForKey:@"Quantity"];
    
}

- (NSString *)CreateDate{
    
    return [mDictionary objectForKey:@"CreateDate"];
    
}

- (NSString *)CreateBy{
    
    return [mDictionary objectForKey:@"CreateBy"];
    
}


- (NSString *)ShelfTime{
    
    return [mDictionary objectForKey:@"ShelfTime"];
    
}

- (NSString *)Price{
    
    return [mDictionary objectForKey:@"Price"];
    
}

- (NSString *)OriginalPrice{
    
    return [mDictionary objectForKey:@"OriginalPrice"];
    
}

- (NSString *)Commissionrate{
    
    return [mDictionary objectForKey:@"Commissionrate"];
    
}

- (NSString *)KeyvaildDateS{
    
    return [mDictionary objectForKey:@"KeyvaildDateS"];
    
}

- (NSString *)KeyvaildDateE{
    
    return [mDictionary objectForKey:@"KeyvaildDateE"];
    
}

- (NSString *)Introduction{
    
    return [mDictionary objectForKey:@"Introduction"];
    
}

- (NSString *)Explain{
    
    return [mDictionary objectForKey:@"Explain"];
    
}

- (NSString *)Tags{
    
    return [mDictionary objectForKey:@"Tags"];
    
}

- (NSString *)IsAnytimeReturn{
    
    return [mDictionary objectForKey:@"IsAnytimeReturn"];
    
}

- (NSString *)IsExpiredReturn{
    
    return [mDictionary objectForKey:@"IsExpiredReturn"];
    
}

- (NSString *)ViolationDescription{
    
    return [mDictionary objectForKey:@"ViolationDescription"];
    
}

- (NSString *)IsReservation{
    
    return [mDictionary objectForKey:@"IsReservation"];
    
}

- (NSString *)Status{
    
    return [mDictionary objectForKey:@"Status"];
    
}

- (NSString *)MemberId{
    
    return [mDictionary objectForKey:@"MemberId"];
    
}

- (NSString *)ResNickName{
    
    return [mDictionary objectForKey:@"ResNickName"];
    
}



@end




@implementation ProductPhontoData

- (NSString *)BigPoster{
    
    return [mDictionary objectForKey:@"BigPoster"];
    
}

- (NSString *)MidPoster{
    
    return [mDictionary objectForKey:@"MidPoster"];
    
}

- (NSString *)SmlPoster{
    
    return [mDictionary objectForKey:@"SmlPoster"];
    
}

- (NSString *)IsFrontCover{
    
    return [mDictionary objectForKey:@"IsFrontCover"];
    
}

- (NSString *)Description{
    
    return [mDictionary objectForKey:@"Description"];
    
}




@end




