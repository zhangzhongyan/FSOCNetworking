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
#import "FSNetSecurityPolicyUtils.h"
#import <FSOCNetworking/FSYTKNetworkConfig.h>

@implementation FSNetworkingConfigure

#pragma mark - Public Methods

+ (void)setupNetworkConfig {
    FSHTTPClient.shared.logUtils = [[FSNetLogUtils alloc] init];
    FSHTTPClient.shared.securityPolicyUtils = [[FSNetSecurityPolicyUtils alloc] init];
    FSHTTPClient.shared.netParamUtils = [[FSNetParamUtils alloc] init];
    FSHTTPClient.shared.netServerCommonModelUtils = [[FSNetCommonModelUtils alloc] init];
    FSHTTPClient.shared.netServerCodeHandler = [[FSNetServerCodeHandler alloc] init];
    FSHTTPClient.shared.netRequestHandler = [[FSNetRequestHandler alloc] init];
}

@end
