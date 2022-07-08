//
//  FSHTTPClient+FSClient.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSHTTPClient+FSClient.h"
#import "FSEnvironmentUtils.h"

@implementation FSHTTPClient (FSClient)


- (FSBaseRequest *)postRequestWithUrl:(NSString *)url
                           parameters:(nullable NSDictionary *)parameters
                          entityClass:(nullable Class)entityClass
                        complateBlock:(nullable FSNetworkCompletedBlock)completedBlock
{
    return [self postRequestWithUrl:url parameters:parameters entityClass:entityClass constructingBodyBlock:nil complateBlock:completedBlock];
}

- (FSBaseRequest *)postRequestWithUrl:(NSString *)url
                           parameters:(nullable NSDictionary *)parameters
                          entityClass:(nullable Class)entityClass
                constructingBodyBlock:(nullable AFConstructingBlock)constructingBodyBlock
                        complateBlock:(nullable FSNetworkCompletedBlock)completedBlock
{
    FSBaseRequest *request = [[FSBaseRequest alloc] initWithURL:url method:FSYTKRequestMethodPOST params:parameters headersBlock:^NSDictionary * _Nonnull{
        return @{};
    } timeout:15 requestSerializerBlock:^AFHTTPRequestSerializer * _Nonnull{
        return [AFJSONRequestSerializer serializer];
    } responseSerializerBlock:^AFHTTPResponseSerializer * _Nonnull{
        return [AFJSONResponseSerializer serializer];
    } baseURL:[FSEnvironmentUtils baseAPIURL] resumableDownloadPath:nil];
    
    //POST媒体流（文件）
    request.constructingBodyBlock = constructingBodyBlock;
    
    [self sendRequest:request entityClass:entityClass completionBlock:completedBlock];
    return request;
}

- (FSBaseRequest *)postRequestWithUrl:(NSString *)url
                           parameters:(nullable NSDictionary *)parameters
                          entityClass:(nullable Class)entityClass
                constructingBodyBlock:(nullable AFConstructingBlock)constructingBodyBlock
                  uploadProgressBlock:(nullable AFURLSessionTaskProgressBlock)uploadProgressBlock
                        complateBlock:(nullable FSNetworkCompletedBlock)completedBlock
{
    FSBaseRequest *request = [[FSBaseRequest alloc] initWithURL:url method:FSYTKRequestMethodPOST params:parameters headersBlock:^NSDictionary * _Nonnull{
        return @{};
    } timeout:15 requestSerializerBlock:^AFHTTPRequestSerializer * _Nonnull{
        return [AFJSONRequestSerializer serializer];
    } responseSerializerBlock:^AFHTTPResponseSerializer * _Nonnull{
        return [AFJSONResponseSerializer serializer];
    } baseURL:[FSEnvironmentUtils baseAPIURL] resumableDownloadPath:nil];
    
    //POST媒体流（文件）
    request.constructingBodyBlock = constructingBodyBlock;
    
    request.uploadProgressBlock = uploadProgressBlock;
    
    [self sendRequest:request entityClass:entityClass completionBlock:completedBlock];
    return request;
}

- (FSBaseRequest *)postDownloadFileWithURL:(NSString *)url
                                parameters:(nullable NSDictionary *)parameters
                     resumableDownloadPath:(nullable NSString *)resumableDownloadPath
                             complateBlock:(nullable FSNetworkCompletedBlock)completedBlock
{
    FSBaseRequest *request = [[FSBaseRequest alloc] initWithURL:url method:FSYTKRequestMethodPOST params:parameters headersBlock:^NSDictionary * _Nonnull{
        return [FSHTTPClient.shared.netParamUtils requestHeaderFields] ?: @{};
    } timeout:15 requestSerializerBlock:^AFHTTPRequestSerializer * _Nonnull{
        return [AFJSONRequestSerializer serializer];
    } responseSerializerBlock:^AFHTTPResponseSerializer * _Nonnull{
        return [AFHTTPResponseSerializer serializer];
    } baseURL:[FSEnvironmentUtils baseAPIURL] resumableDownloadPath:resumableDownloadPath];
    [self sendRequest:request entityClass:nil completionBlock:completedBlock];
    return request;
}

@end
