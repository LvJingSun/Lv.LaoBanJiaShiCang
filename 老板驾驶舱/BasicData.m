//
//  BasicData.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-12-12.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BasicData.h"

@implementation BasicData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSDictionary *)Merchant{
    
    NSDictionary *items = [mDictionary getDictionary:@"Merchant"];
    
    
    return items;
    
}

@end



@implementation BasicDetailData


- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)MctShopList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    NSArray *array = [[mDictionary getDictionary:@"Merchant"] getArray:@"MctShopList"];
    
    for (NSDictionary*dic in array)
    {
        ShopDetailData *item = [[ShopDetailData alloc] initWithJsonObject:dic];
        [retArray addObject:item];
        
    }
    
    return retArray;
}




- (NSString *)ParentClassName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ParentClassName"];
    
}

- (NSString *)ParentClassId{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ParentClassId"];
    
}

- (NSString *)ClassName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ClassName"];
    
}

- (NSString *)CityName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"CityName"];
    
}


- (NSString *)AccountCategory{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"AccountCategory"];
    
}

- (NSString *)ModifyDate{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ModifyDate"];
    
}

- (NSString *)MerchantId{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"MerchantId"];
    
}

- (NSString *)MerchantCode{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"MerchantCode"];
    
}



- (NSString *)ClassId{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ClassId"];
    
}

- (NSString *)AllName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"AllName"];
    
}

- (NSString *)Abbreviation{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Abbreviation"];
    
}

- (NSString *)Tel{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Tel"];
    
}


- (NSString *)EnName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"EnName"];
    
}

- (NSString *)WebSite{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"WebSite"];
    
}

- (NSString *)MerchantTags{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"MerchantTags"];
    
}

- (NSString *)Cityid{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Cityid"];
    
}

- (NSString *)Briefintro{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Briefintro"];
    
}

- (NSString *)Status{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Status"];
    
}

- (NSString *)Businesslicense{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Businesslicense"];
    
}

- (NSString *)Taxcertificate{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Taxcertificate"];
    
}


- (NSString *)Legal{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Legal"];
    
}

- (NSString *)Officialcontacts{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Officialcontacts"];
    
}

- (NSString *)OfficialcontactsPhone{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"OfficialcontactsPhone"];
    
}

- (NSString *)Treasurer{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Treasurer"];
    
}



- (NSString *)TreasurerPhone{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"TreasurerPhone"];
    
}

- (NSString *)Fax{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Fax"];
    
}

- (NSString *)OfficialMail{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"OfficialMail"];
    
}

- (NSString *)MemberBankcardID{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"MemberBankcardID"];
    
}


- (NSString *)BankId{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"BankId"];
    
}

- (NSString *)BankName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"BankName"];
    
}

- (NSString *)BankCode{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"BankCode"];
    
}

- (NSString *)BranchCode{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"BranchCode"];
    
}

- (NSString *)ResMemAccount{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ResMemAccount"];
    
}

- (NSString *)MemberId{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"MemberId"];
    
}

- (NSString *)ResMemRealName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ResMemRealName"];
    
}



- (NSString *)ResMemSex{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ResMemSex"];
    
}

- (NSString *)Logo{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"Logo"];
    
}

- (NSString *)BusinesslicensePhoto{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"BusinesslicensePhoto"];
    
}

- (NSString *)ApplactionFormPhoto{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"ApplactionFormPhoto"];
    
}


- (NSString *)IdCard{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"IdCard"];
    
}

- (NSString *)CardNumber{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"CardNumber"];
    
}

- (NSString *)BankcardName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"BankcardName"];
    
}

- (NSString *)BranchName{
    
    return [[mDictionary getDictionary:@"Merchant"] objectForKey:@"BranchName"];
    
}


@end


@implementation ShopDetailData

- (NSString *)Districtame{
    
    return [mDictionary objectForKey:@"Districtame"];
    
}

- (NSString *)Areaname{
    
    return [mDictionary objectForKey:@"Areaname"];
    
}


- (NSString *)Hc{
    
    return [mDictionary objectForKey:@"Hc"];
    
}

- (NSString *)Businfo{
    
    return [mDictionary objectForKey:@"Businfo"];
    
}

- (NSString *)Districtid{
    
    return [mDictionary objectForKey:@"Districtid"];
    
}

- (NSString *)Areaid{
    
    return [mDictionary objectForKey:@"Areaid"];
    
}


- (NSString *)Cityid{
    
    return [mDictionary objectForKey:@"Cityid"];
    
}

- (NSString *)Merchantid{
    
    return [mDictionary objectForKey:@"Merchantid"];
    
}

- (NSString *)Modifydate{
    
    return [mDictionary objectForKey:@"Modifydate"];
    
}

- (NSString *)MerchantShopId{
    
    return [mDictionary objectForKey:@"MerchantShopId"];
    
}

- (NSString *)Logo{
    
    return [mDictionary objectForKey:@"Logo"];
    
}

- (NSString *)MctName{
    
    return [mDictionary objectForKey:@"MctName"];
    
}

- (NSString *)ShopName{
    
    return [mDictionary objectForKey:@"ShopName"];
    
}

- (NSString *)CityName{
    
    return [mDictionary objectForKey:@"CityName"];
    
}

- (NSString *)Address{
    
    return [mDictionary objectForKey:@"Address"];
    
}

- (NSString *)OpeningHours{
    
    return [mDictionary objectForKey:@"OpeningHours"];
    
}

- (NSString *)BeenCount{
    
    return [mDictionary objectForKey:@"BeenCount"];
    
}


- (NSString *)InterestedCount{
    
    return [mDictionary objectForKey:@"InterestedCount"];
    
}

- (NSString *)Phone{
    
    return [mDictionary objectForKey:@"Phone"];
    
}

- (NSString *)MapX{
    
    return [mDictionary objectForKey:@"MapX"];
    
}

- (NSString *)MapY{
    
    return [mDictionary objectForKey:@"MapY"];
    
}




@end