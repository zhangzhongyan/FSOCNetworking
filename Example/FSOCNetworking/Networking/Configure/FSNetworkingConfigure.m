//
//  FSNetworkingConfigure.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSNetworkingConfigure.h"
#import "FSNetLogUtils.h"
#import "FSNetParamUtils.h"
#import "FSNetCommonModelUtils.h"
#import "FSNetServerCodeHandler.h"
#import "FSNetRequestHandler.h"
#import <FSOCNetworking/FSYTKNetworkConfig.h>

@implementation FSNetworkingConfigure

#pragma mark - Public Methods

+ (void)setupNetworkConfig {

    FSYTKNetworkConfig.sharedConfig.securityPolicy = [FSNetworkingConfigure shareSecurityPolicy];

    FSHTTPClient.shared.logUtils = [[FSNetLogUtils alloc] init];
    FSHTTPClient.shared.netParamUtils = [[FSNetParamUtils alloc] init];
    FSHTTPClient.shared.netServerCommonModelUtils = [[FSNetCommonModelUtils alloc] init];
    FSHTTPClient.shared.netServerCodeHandler = [[FSNetServerCodeHandler alloc] init];
    FSHTTPClient.shared.netRequestHandler = [[FSNetRequestHandler alloc] init];
}

+ (FSSecurityPolicy *)shareSecurityPolicy
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
