//
//  LandingData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-19.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "LandingData.h"

@implementation LandingData

- (NSString *)sDatetime{
    
    return [mDictionary objectForKey:@"sDatetime"];
    
}


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

-(NSString *)Istype {

    return [mDictionary objectForKey:@"Istype"];
    
}

-(NSString *)Anzhuo {
    
    return [mDictionary objectForKey:@"Anzhuo"];
    
}

-(NSString *)Iphone {
    
    return [mDictionary objectForKey:@"Iphone"];
    
}

-(NSString *)Phone {
    
    return [mDictionary objectForKey:@"Phone"];
    
}

- (NSDictionary *)member{
    
    NSDictionary *items = [mDictionary getDictionary:@"member"];
    
    
    return items;
    
}
@end
@implementation landingDetailData

- (NSString *)PhotoMidUrl{
    
    return [mDictionary objectForKey:@"PhotoMidUrl"];
    
}

- (NSString *)memberId{
    
    return [mDictionary objectForKey:@"memberId"];
    
}
- (NSString *)account{
    
    return [mDictionary objectForKey:@"account"];
    
}

- (NSString *)name{
    
    return [mDictionary objectForKey:@"name"];
    
}
- (NSString *)nick{
    
    return [mDictionary objectForKey:@"nick"];
    
}

- (NSString *)versionNumber{
    
    return [mDictionary objectForKey:@"versionNumber"];
    
}
- (NSString *)appPkgUrl{
    
    return [mDictionary objectForKey:@"appPkgUrl"];
    
}

- (NSString *)coreIntro{
    
    return [mDictionary objectForKey:@"coreIntro"];
    
}

@end
