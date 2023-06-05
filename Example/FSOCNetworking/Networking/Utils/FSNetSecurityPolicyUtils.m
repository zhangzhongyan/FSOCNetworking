//
//  FSNetSecurityPolicyUtils.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2023/6/5.
//  Copyright © 2023 张忠燕. All rights reserved.
//

#import "FSNetSecurityPolicyUtils.h"

@implementation FSNetSecurityPolicyUtils

#pragma mark - <FSNetSecurityPolicyProtocol>

- (AFSecurityPolicy *)requestSecurityPolicy
{
    static FSSecurityPolicy *securityPolicy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifdef DEBUG
        // 设置校验证书模式(不校验证书，可以抓包, 用于调试)
        securityPolicy = [FSSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 客户端是否信任非法证书
        securityPolicy.allowInvalidCertificates = YES;
        // 是否在证书域字段中验证域名
        securityPolicy.validatesDomainName = NO;
#else
        // 设置校验证书模式(校验证书，不可以抓包, 用于发布)
        securityPolicy = [FSSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        // 客户端是否信任非法证书
        securityPolicy.allowInvalidCertificates = NO;
        // 是否在证书域字段中验证域名
        securityPolicy.validatesDomainName = YES;
#endif
    });
    return securityPolicy;
}

@end
