//
//  FSHTTPClient+FSClient.h
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import <FSOCNetworking/FSOCNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSHTTPClient (FSClient)

/// Post请求
- (FSBaseRequest *)postRequestWithUrl:(NSString *)url
                           parameters:(nullable NSDictionary *)parameters
                          entityClass:(nullable Class)entityClass
                        complateBlock:(nullable FSNetworkCompletedBlock)completedBlock;
/// Post上传文件
- (FSBaseRequest *)postRequestWithUrl:(NSString *)url
                           parameters:(nullable NSDictionary *)parameters
                          entityClass:(nullable Class)entityClass
                constructingBodyBlock:(nullable AFConstructingBlock)constructingBodyBlock
                        complateBlock:(nullable FSNetworkCompletedBlock)completedBlock;

/// Post下载文件
- (FSBaseRequest *)postDownloadFileWithURL:(NSString *)url
                                parameters:(nullable NSDictionary *)parameters
                     resumableDownloadPath:(nullable NSString *)resumableDownloadPath
                             complateBlock:(nullable FSNetworkCompletedBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
