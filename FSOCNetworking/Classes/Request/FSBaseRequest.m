//
//  EVBaseRequest.m
//  Fargo
//
//  Created by 张忠燕 on 2022/4/24.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import "FSBaseRequest.h"

@implementation FSBaseRequest

#pragma mark - Initialize Methods

/// 指定构造函数
- (instancetype)initWithURL:(NSString *)url
                     method:(FSYTKRequestMethod)method
                     params:(nullable id)params
               headersBlock:(nullable NSDictionary* (^) (void))headersBlock
                    timeout:(NSTimeInterval)timeout
     requestSerializerBlock:(nullable AFHTTPRequestSerializer * _Nonnull (^)(void))requestSerializerBlock
    responseSerializerBlock:(nullable AFHTTPResponseSerializer * _Nonnull (^)(void))responseSerializerBlock
                    baseURL:(nonnull NSString *)baseURL
      resumableDownloadPath:(nullable NSString *)resumableDownloadPath
{
    self = [super init];
    if (self) {
        _fs_URL = url.copy;
        _fs_requestMethod = method;
        _fs_requestParams = params;
        _fs_requestHeadersBlock = [headersBlock copy];
        _fs_timeoutInterval = timeout;
        _fs_requestSerializerBlock = [requestSerializerBlock copy];
        _fs_responseSerializerBlock = [responseSerializerBlock copy];
        _fs_baseUrl = baseURL.copy;
        _fs_resumableDownloadPath = resumableDownloadPath.copy;
    }
    return self;
}

#pragma mark - Overwrite Methods

- (NSString *)requestUrl {
    return self.fs_URL ?: @"";
}

- (FSYTKRequestMethod)requestMethod {
    return self.fs_requestMethod;
}

- (id)requestArgument {
    return self.fs_requestParams;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    if (self.fs_requestHeadersBlock) {
        return self.fs_requestHeadersBlock();
    } else {
        return nil;
    }
}

- (NSTimeInterval)requestTimeoutInterval {
    return self.fs_timeoutInterval? self.fs_timeoutInterval: 60;
}

- (AFHTTPRequestSerializer *)requestSerializer {
    if (self.fs_requestSerializerBlock) {
        return self.fs_requestSerializerBlock();
    } else {
        return [AFJSONRequestSerializer serializer];
    }
}

- (AFHTTPResponseSerializer *)responseSerializer {
    if (self.fs_responseSerializerBlock) {
        return self.fs_responseSerializerBlock();
    } else {
        return [AFJSONResponseSerializer serializer];
    }
}

- (NSString *)baseUrl {
    return self.fs_baseUrl;
}

- (nullable NSString *)resumableDownloadPath {
    return self.fs_resumableDownloadPath;
}

//- (void)requestCompleteFilter {
//
//}

@end
