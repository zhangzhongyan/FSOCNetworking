//
//  FSNetworkData.h
//  Fargo
//
//  Created by 张忠燕 on 2022/4/24.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FSConnectErrorType) {
    /** 未知 */
    FSConnectErrorType_Unknow,
    /** 本地错误 */
    FSConnectErrorType_Local,
    /** 服务器错误 */
    FSConnectErrorType_Server_Error,
    /** 超时 */
    FSConnectErrorType_TimeOut,
};

@interface FSNetworkData : NSObject

/// 业务请求成功时，为YES, 否则NO
@property (nonatomic, assign) BOOL isSuccess;

/// 网络返回的状态码,例:404
@property (nonatomic, copy, nullable) NSString *errCode;

/// 出错类型（FSConnectErrorType）
@property (nonatomic, assign) FSConnectErrorType errorType;

/// FSConnectErrorType_Local时，对应的错误信息
@property (nonatomic, strong, nullable) NSError *localReqestError;

/// 文件下载时，客户端配置的本地URL
@property (nonatomic, strong, nullable) NSURL *fileURL;

/// 服务端返回的状态码,例:1000
@property (nonatomic, assign) NSInteger serverStatus;

/// 服务端返回的errMsg、或者 客户端配置本地信息
@property (nonatomic, copy, nullable) NSString *errMsg;

/// entityClass对应的模型
@property (nonatomic, strong, nullable) id modelObject;

/// 服务端返回的datas字段数据
@property (nonatomic, strong, nullable) id datasObject;

@end

NS_ASSUME_NONNULL_END
