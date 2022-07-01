//
//  FSNetServerCodeHandlerProtocol.h
//  Fargo
//
//  Created by 张忠燕 on 2022/6/21.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FSNetworkData;
@protocol FSNetServerCodeHandlerProtocol <NSObject>

/// 本地错误-网络超时提示
- (NSString *)localNetworkTimeOutMessage;

/// 本地错误-其他提示
- (NSString *)localNetworkErrorMessage;

/// 远程服务错误信息提示
- (nullable NSString *)serverErrorMessageWithCode:(NSInteger)serverCode;

/// 全局处理网络信息
- (void)handleNetworkData:(FSNetworkData *)networkData;

@end

NS_ASSUME_NONNULL_END
