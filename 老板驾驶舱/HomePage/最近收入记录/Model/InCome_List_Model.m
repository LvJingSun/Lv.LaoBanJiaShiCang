//
//  InCome_List_Model.m
//  BusinessCenter
//
//  Created by mac on 2017/11/1.
//  Copyright © 2017年 冯海强. All rights reserved.
//

#import "InCome_List_Model.h"

@implementation InCome_List_Model

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"OrderNumber"]] forKey:@"OrderNumber"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"NickName"]] forKey:@"NickName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TransactionDate"]] forKey:@"TransactionDate"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Amount"]] forKey:@"Amount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Description"]] forKey:@"Description"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Type"]] forKey:@"Type"];
        
    }
    
    return self;
    
}

@end
