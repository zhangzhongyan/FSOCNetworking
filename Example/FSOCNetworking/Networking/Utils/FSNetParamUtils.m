//
//  FSNetParamUtils.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSNetParamUtils.h"
//Helper
#import <FSOCUtils/FSSafeUtils.h>

@implementation FSNetParamUtils

#pragma mark - <FSNetParamProtocol>

- (NSMutableDictionary *)requestHeaderFields {
    NSMutableDictionary *headParamDic = [NSMutableDictionary dictionary];
    //定制化请求头（eg:标识请求类型）
    return headParamDic;
}

- (NSMutableDictionary *)requestCommonParamsWithUrl:(NSString *)url {
    NSMutableDictionary *commonParams = [NSMutableDictionary dictionary];
    //语言
    [commonParams safeSetObject:@"cn" forKey:@"language"];
    //appType
    [commonParams safeSetObject:@(1) forKey:@"appType"];
    //版本号
    [commonParams safeSetObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    //BundleId
    [commonParams safeSetObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"appBundleId"];
    // 用户ID
    [commonParams safeSetObject:@(1) forKey:@"userId"];
    // 随机数
    int random = arc4random() % 100 ;
    [commonParams safeSetObject:@(random) forKey:@"nonce"];
    // 时间戳
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970] * 1000];
    [commonParams safeSetObject:timestamp forKey:@"timestamp"];
    //设备类型
    [commonParams safeSetObject:@(1) forKey:@"deviceType"];
    // 签名
    [commonParams safeSetObject:@"gn;eabgebg;b" forKey:@"signature"];
    return commonParams;
}

@end
