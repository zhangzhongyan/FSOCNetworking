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

/** 服务器返回10000 YES, 否则NO */
@property (nonatomic, assign) BOOL isSuccess;

/** 网络返回的状态码,例:404 */
@property (nonatomic, copy, nullable) NSString *errCode;

/** FSConnectErrorType */
@property (nonatomic, assign) FSConnectErrorType errorType;

/// FSConnectErrorType_Local时，对应的错误
@property (nonatomic, strong, nullable) NSError *localReqestError;

/** 下载对应本地的URL */
@property (nonatomic, strong, nullable) NSURL *fileURL;

/** 服务端返回的状态码,例:00000 */
@property (nonatomic, assign) NSInteger serverStatus;

/** 服务端返回的errMsg */
@property (nonatomic, copy, nullable) NSString *errMsg;

/** modelClass对应的Object */
@property (nonatomic, strong, nullable) id modelObject;

/**
 datas对应的数组-字典-字符串
 兼容目前处理字典的场景，重构完成删除该字段
 */
@property (nonatomic, strong, nullable) id datasObject;

@end

NS_ASSUME_NONNULL_END
