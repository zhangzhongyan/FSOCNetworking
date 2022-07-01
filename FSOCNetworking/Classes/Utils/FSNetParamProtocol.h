//
//  FSNetParamProtocol.h
//  Fargo
//
//  Created by 张忠燕 on 2022/6/20.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FSNetParamProtocol <NSObject>

/** 请求头 */
- (NSMutableDictionary *)requestHeaderFields;

/// 请求公共参数
- (NSMutableDictionary *)requestCommonParamsWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
