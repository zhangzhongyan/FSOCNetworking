//
//  FSNetworkingConfigure.h
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FSOCNetworking/FSOCNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSNetworkingConfigure : NSObject

/** 网络配置 */
+ (void)setupNetworkConfig;

/// 网络证书政策
+ (FSSecurityPolicy *)shareSecurityPolicy;

@end

NS_ASSUME_NONNULL_END
