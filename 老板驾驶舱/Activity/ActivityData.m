//
//  ActivityData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-11.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ActivityData.h"

@implementation ActivityData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)ActivityList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"ActivityList"];
    
    for (NSDictionary *dic in items) {
        
        ActivityDetailData *item = [[ActivityDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    
    return retArray;
    
}

@end


@implementation ActivityDetailData


- (NSArray *)ActivityPosterList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    NSArray *array = [mDictionary getArray:@"ActivityPosterList"];
    
    for (NSDictionary*dic in array)
    {
        ActivityPhontoData *item = [[ActivityPhontoData alloc] initWithJsonObject:dic];
        [retArray addObject:item];
        
    }
    
    return retArray;
}



- (NSString *)ActivityId{
    
    return [mDictionary objectForKey:@"ActivityId"];
    
}

- (NSString *)ActivityCode{
    
    return [mDictionary objectForKey:@"ActivityCode"];
    
}

- (NSString *)MerchantId{
    
    return [mDictionary objectForKey:@"MerchantId"];
    
}

- (NSString *)ActivityName{
    
    return [mDictionary objectForKey:@"ActivityName"];
    
}

- (NSString *)ActStartDate{
    
    return [mDictionary objectForKey:@"ActStartDate"];
    
}

- (NSString *)ActEndDate{
    
    return [mDictionary objectForKey:@"ActEndDate"];
    
}

- (NSString *)ActStartTime{
    
    return [mDictionary objectForKey:@"ActStartTime"];
    
}

- (NSString *)ActEndtTime{
    
    return [mDictionary objectForKey:@"ActEndtTime"];
    
}

- (NSString *)OriginalPrice{
    
    return [mDictionary objectForKey:@"OriginalPrice"];
    
}

- (NSString *)Price{
    
    return [mDictionary objectForKey:@"Price"];
    
}

- (NSString *)Brokerage{
    
    return [mDictionary objectForKey:@"Brokerage"];
    
}

- (NSString *)BrokerageAmount{
    
    return [mDictionary objectForKey:@"BrokerageAmount"];
    
}


- (NSString *)Content{
    
    return [mDictionary objectForKey:@"Content"];
    
}

- (NSString *)Explain{
    
    return [mDictionary objectForKey:@"Explain"];
    
}

- (NSString *)ActivityType{
    
    return [mDictionary objectForKey:@"ActivityType"];
    
}

- (NSString *)MemberId{
    
    return [mDictionary objectForKey:@"MemberId"];
    
}

- (NSString *)NickName{
    
    return [mDictionary objectForKey:@"NickName"];
    
}

- (NSString *)CityId{
    
    return [mDictionary objectForKey:@"CityId"];
    
}

- (NSString *)CityName{
    
    return [mDictionary objectForKey:@"CityName"];
    
}

- (NSString *)AreaId{
    
    return [mDictionary objectForKey:@"AreaId"];
    
}

- (NSString *)AreaName{
    
    return [mDictionary objectForKey:@"AreaName"];
    
}

- (NSString *)DistrictId{
    
    return [mDictionary objectForKey:@"DistrictId"];
    
}


- (NSString *)DistrictName{
    
    return [mDictionary objectForKey:@"DistrictName"];
    
}

- (NSString *)ActivityTags{
    
    return [mDictionary objectForKey:@"ActivityTags"];
    
}

- (NSString *)MapX{
    
    return [mDictionary objectForKey:@"MapX"];
    
}

- (NSString *)MapY{
    
    return [mDictionary objectForKey:@"MapY"];
    
}

- (NSString *)HC{
    
    return [mDictionary objectForKey:@"HC"];
    
}

- (NSString *)Address{
    
    return [mDictionary objectForKey:@"Address"];
    
}

- (NSString *)PeoperNumMin{
    
    return [mDictionary objectForKey:@"PeoperNumMin"];
    
}

- (NSString *)PeoperNumMax{
    
    return [mDictionary objectForKey:@"PeoperNumMax"];
    
}

- (NSString *)RegStopTime{
    
    return [mDictionary objectForKey:@"RegStopTime"];
    
}


- (NSString *)AgeMin{
    
    return [mDictionary objectForKey:@"AgeMin"];
    
}

- (NSString *)AgeMax{
    
    return [mDictionary objectForKey:@"AgeMax"];
    
}


- (NSString *)Sex{
    
    return [mDictionary objectForKey:@"Sex"];
    
}

- (NSString *)Status{
    
    return [mDictionary objectForKey:@"Status"];
    
}

- (NSString *)ViolationdeScription{
    
    return [mDictionary objectForKey:@"ViolationdeScription"];
    
}

- (NSString *)IsAnyTimeReturn{
    
    return [mDictionary objectForKey:@"IsAnyTimeReturn"];
    
}

- (NSString *)IsExpiredReturn{
    
    return [mDictionary objectForKey:@"IsExpiredReturn"];
    
}

- (NSString *)IsReservation{
    
    return [mDictionary objectForKey:@"IsReservation"];
    
}

- (NSString *)KeyVaildDateS{
    
    return [mDictionary objectForKey:@"KeyVaildDateS"];
    
}

- (NSString *)KeyVaildDateE{
    
    return [mDictionary objectForKey:@"KeyVaildDateE"];
    
}

- (NSString *)CreateDate{
    
    return [mDictionary objectForKey:@"CreateDate"];
    
}

@end




@implementation ActivityPhontoData


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










