//
//  FSHTTPClient.h
//  Fargo
//
//  Created by 张忠燕 on 2022/4/24.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSBaseRequest.h"
//Helper
#import "FSNetLogProtocol.h"
#import "FSNetParamProtocol.h"
#import "FSNetServerCodeHandlerProtocol.h"
#import "FSNetRequestHandlerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EVNetworkReachabilityStatus) {
    /** 未知 */
    EVNetworkReachabilityStatusUnknown = 0,
    /** 无网络 */
    EVNetworkReachabilityStatusNotReachable = 1,
    /** 蜂窝网络 */
    EVNetworkReachabilityStatusWWAN = 2,
    /** WiFi */
    EVNetworkReachabilityStatusWiFi = 3,
};

// 请求完成回调block
typedef void(^EVNetworkCompletedBlock)(FSNetworkData *data,__kindof FSBaseRequest *request);

@interface FSHTTPClient : NSObject

/// 网络状态
@property (nonatomic, assign) EVNetworkReachabilityStatus reachabilityStatus;

/// 网络打印工具
@property (nonatomic, strong, nullable) id<FSNetLogProtocol> logUtils;

/// 网络参数工具
@property (nonatomic, strong, nullable) id<FSNetParamProtocol> netParamUtils;

/// 网络响应码处理器
@property (nonatomic, strong, nullable) id<FSNetServerCodeHandlerProtocol> netServerCodeHandler;

/// 网络请求处理器
@property (nonatomic, strong, nullable) id<FSNetRequestHandlerProtocol> netRequestHandler;


/** 单例 */
+ (FSHTTPClient *)shared;

/// 发送封装请求
- (void)sendRequest:(FSBaseRequest *)request
        entityClass:(nullable Class)entityClass
    completionBlock:(nullable EVNetworkCompletedBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END