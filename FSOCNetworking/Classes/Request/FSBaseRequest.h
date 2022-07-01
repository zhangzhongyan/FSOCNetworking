//
//  FSBaseRequest.h
//  Fargo
//
//  Created by 张忠燕 on 2022/4/24.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import "FSYTKRequest.h"
#import "FSNetworkData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSBaseRequest : FSYTKRequest

/// 请求URL
@property (nonatomic, copy) NSString *fs_URL;

/// 请求方法
@property (nonatomic, assign) FSYTKRequestMethod fs_requestMethod;

/// 请求参数
@property (nonatomic, strong, nullable) id fs_requestParams;

/// 请求头
@property (nonatomic, copy, nullable) NSDictionary * (^fs_requestHeadersBlock) (void);

/// 请求时间
@property (nonatomic, assign) NSTimeInterval fs_timeoutInterval;

/// 请求数据形式
@property (nonatomic, copy, nullable) AFHTTPRequestSerializer * (^fs_requestSerializerBlock) (void);

/// 响应数据形式
@property (nonatomic, copy, nullable) AFHTTPResponseSerializer * (^fs_responseSerializerBlock) (void);

/// 请求基础URL
@property (nonatomic, copy) NSString *fs_baseUrl;

/// 续点下载文件地址
@property (nonatomic, copy, nullable) NSString *fs_resumableDownloadPath;

/// 网络返回数据
@property (nonatomic, strong, nullable) FSNetworkData *networkData;

//@property (nonatomic, copy, nullable) void *fs_requestCompleteFilter;

/// 指定构造函数
- (instancetype)initWithURL:(NSString *)url
                     method:(FSYTKRequestMethod)method
                     params:(nullable id)params
               headersBlock:(nullable NSDictionary* (^) (void))headersBlock
                    timeout:(NSTimeInterval)timeout
     requestSerializerBlock:(nullable AFHTTPRequestSerializer * (^) (void))requestSerializerBlock
    responseSerializerBlock:(nullable AFHTTPResponseSerializer * (^) (void))responseSerializerBlock
                    baseURL:(NSString *)baseURL
      resumableDownloadPath:(nullable NSString *)resumableDownloadPath;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
