//
//  CommonUtil.h
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const ACCOUNT = @"account";

static NSString * const MEMBER_ID = @"memberId";

static NSString * const PWD = @"pwd";

static NSString * const NICK = @"nick";

static NSString * const SERVER_TIME_DIFF = @"serverTimeDiff";

static NSString * const CHECK_ACCOUNT = @"checkAccount";

static NSString * const CHECK_PWD = @"checkPassword";

static NSString * const OPERATION_INCOME = @"Income";

static NSString * const OPERATION_EXPENDITURE = @"Expenditure";

static NSString * const KEY_TYPE_ACTIVITY = @"Activity";//活动

static NSString * const KEY_TYPE_SERVICE = @"Service";//服务资源

static NSString * const LOCK_STATUS = @"lockStatus";

static NSString * const LOCK_MESSAGE = @"lockMessage";

static NSString * const VLD_STATUS_AUDIT = @"Audit";//审核中

static NSString * const VLD_STATUS_INVALID = @"Invalid";//无效

static NSString * const VLD_STATUS_VALID = @"Valid";//有效

static NSString * const VLD_STATUS_NOT_CERTIFIED = @"NotCertified";//未认证

static NSString * const REAL_ACCOUNT_NAME = @"realAccountName";

static NSString * const REAL_ACCOUNT_IDCARD = @"realAccountIdcard";

static NSString * const TYPE_CITY = @"city";

static NSString * const TYPE_CATEGORY = @"category";

// 用于微信支付那边的赋值
static NSString * const WEIXIN_NAME = @"weixinNameKey";
static NSString * const WEIXIN_PRICE = @"weixinPriceKey";
static NSString * const WEIXIN_OREDENO = @"weixinOrderNoKey";

// 判断是购买什么商品
static NSString * const WEIXIN_PAYTYPE = @"weixinPayTypeKey";


@interface CommonUtil : NSObject
 
//+ (NSString *) getServerKey;

+ (NSString *) getDocumentPath:(NSString *)fileName;

+ (id) getValueByKey:(NSString *)key;

+ (void) addValue:(id)object andKey:(NSString *)key;

+ (NSDictionary *) transactionTypeDict;

+ (NSDictionary *) operationsDict;

+ (NSDictionary *) statusDict;

+ (NSDictionary *) keyStatusDict;

+ (NSDictionary *) bankcardStatusDict;

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)selectBackgroundColor;

+ (UIColor *)selectTabBarTitleColor;

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)reSize;

@end
