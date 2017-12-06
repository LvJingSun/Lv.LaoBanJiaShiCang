//
//  AppHttpClient.h
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface AppHttpClient : AFHTTPClient

+ (AppHttpClient *) sharedClient;

- (void)request:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;


- (void)multiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure;

@end
