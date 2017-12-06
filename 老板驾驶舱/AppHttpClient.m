//
//  AppHttpClient.m
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013Âπ?mac. All rights reserved.
//
//Mainviewcontroller中tabbar消息数和Homepage中进入一次刷一下的未读消息数采用，，以及本月，本周。。收入汇总金额采用
//加上14.2.10的微网站采用。。。
//http://221.228.197.77:8010/MerchantCenterApple/
//测试http://222.191.251.180:8010/MerchantCenterApple/
#import "AppHttpClient.h"
#import "AFJSONRequestOperation.h"
#import "SVProgressHUD.h"


// 221.228.197.77:8010
static NSString * const kAFAppDotNetAPIBaseURLString = @"http://221.228.197.77:8010/MerchantCenterApple/";

@implementation AppHttpClient

+ (AppHttpClient *)sharedClient {
    static AppHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"text/plain"];//text/plain
    
    return self;
}

- (void)request:(NSString *) path parameters:(NSDictionary *)parameters success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient];
    [httpClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            
            [SVProgressHUD showErrorWithStatus:(NSString *)error];

            if (failure) {
                failure(error);
            }
            return;
        }

        if (success) {
            success(json);
            
//            [SVProgressHUD showSuccessWithStatus:((NSDictionary *)json)[@"msg"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        
        
        // 判断服务器返回的错误码
        if ( operation.response.statusCode == 500 ) {
            
            [SVProgressHUD showErrorWithStatus:@"内部服务器错误"];
            
            return;
        }
        
        if ( operation.response.statusCode == 404 ) {
            
            [SVProgressHUD showErrorWithStatus:@"无法找到文件"];
            
            return;
        }
        
        if ( operation.response.statusCode == 400 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请求无效"];
            
            return;
        }
        
        
        return;
   
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void)multiRequest:(NSString *) path parameters:(NSDictionary *)parameters files:(NSDictionary *)files success:(void (^)(NSJSONSerialization *json))success failure:(void (^)(NSError *error))failure {
    AFHTTPClient* httpClient = [AppHttpClient sharedClient];
    NSMutableURLRequest* multiRequest = [httpClient multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        NSEnumerator *keys = files.keyEnumerator;
        for (NSString *key in keys) {
            [formData appendPartWithFileData:[files objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.jpg", key] mimeType:@"image/jpg"];
            //[formData appendPartWithFormData:[files objectForKey:key] name:key];
        }
    }];
    NSDictionary *info = [multiRequest allHTTPHeaderFields];
    for (NSString *key in info.keyEnumerator) {

    }
    
	AFHTTPRequestOperation *operation = [httpClient HTTPRequestOperationWithRequest:multiRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSError* error;
        NSJSONSerialization* json = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:&error];
        if (error) {

            if (failure) {
                failure(error);
            }
            return;
        }

        if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 判断服务器返回的错误码
        if ( operation.response.statusCode == 500 ) {
            
            [SVProgressHUD showErrorWithStatus:@"内部服务器错误"];
            
            return;
        }
        
        if ( operation.response.statusCode == 404 ) {
            
            [SVProgressHUD showErrorWithStatus:@"无法找到文件"];
            
            return;
        }
        
        if ( operation.response.statusCode == 400 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请求无效"];
            
            return;
        }

        if (failure) {
            failure(error);
        }
        
    }];
    [self enqueueHTTPRequestOperation:operation];
}

@end
