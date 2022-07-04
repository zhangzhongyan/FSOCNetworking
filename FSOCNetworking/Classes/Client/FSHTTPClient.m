//
//  FSHTTPClient.m
//  Fargo
//
//  Created by 张忠燕 on 2022/4/24.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import "FSHTTPClient.h"
//Helper
#import "FSServerCommonModel.h"
#import <FSOCUtils/NSObject+FSMJKeyValue.h>
#import <MJExtension/MJExtension.h>

@interface FSHTTPClient ()

@end

@implementation FSHTTPClient

#pragma mark - Initialize Methods

+ (FSHTTPClient *)shared {
    static dispatch_once_t token;
    static FSHTTPClient *client;
    dispatch_once(&token, ^ {
        client = [[FSHTTPClient alloc] init];
    });
    return client;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupAFNReachability];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setupAFNReachability {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 一共有四种状态
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                self.reachabilityStatus = EVNetworkReachabilityStatusNotReachable;
                NSLog(@"AFNetworkReachability Not Reachable");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachability Reachable via WWAN");
                self.reachabilityStatus = EVNetworkReachabilityStatusWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.reachabilityStatus = EVNetworkReachabilityStatusWiFi;
                NSLog(@"AFNetworkReachability Reachable via WiFi");
                break;
            case AFNetworkReachabilityStatusUnknown:
            default:
                self.reachabilityStatus = EVNetworkReachabilityStatusUnknown;
                NSLog(@"AFNetworkReachability Unknown");
                break;
        }
        
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark -- EVNetworkData

/** 处理request */
+ (FSNetworkData *)networkDataWithRequest:(FSYTKBaseRequest *)request
                                  succeed:(BOOL)succeed
                             requestError:(nullable NSError *)requestError
                        serverCodeHandler:(id<FSNetServerCodeHandlerProtocol>)serverCodeHandler
                              entityClass:(nullable Class)entityClass {
    if (succeed) {
        
        FSNetworkData *data = [[FSNetworkData alloc] init];
        data.isSuccess = YES;
        data.errCode = [NSString stringWithFormat:@"%ld", (long)requestError.code];
        data.errorType = FSConnectErrorType_Unknow;
        
        //文件处理(YTK框架特有特征)
        if (request.resumableDownloadPath) {
            if ([request.responseObject isKindOfClass:[NSURL class]]) {
                data.fileURL = request.responseObject;
            }
        }
        
        //解析JSON数据(YTK框架特有特征)
        if ([request.responseData isKindOfClass:[NSData class]]) {
            if ([request.responseSerializer isKindOfClass:AFJSONResponseSerializer.class]) {
                
                FSServerCommonModel *commonModel = [FSServerCommonModel fs_objectWithKeyValues:request.responseJSONObject];
                data.serverStatus = commonModel.status;
                data.errMsg = commonModel.message;
                id datas = commonModel.datas;
                data.datasObject = datas;
                
                NSString *serverErrorMessage = [serverCodeHandler serverErrorMessageWithCode:data.serverStatus];
                if (!serverErrorMessage) {
                    if (entityClass) {
                        if ([datas isKindOfClass:[NSDictionary class]]) {
                            data.modelObject = [entityClass mj_objectWithKeyValues:datas];
                        }
                        else if ([datas isKindOfClass:[NSArray class]]) {
                            __block NSString *arrayPropretyKey = @"";
                            [entityClass mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
                                if ([property.type.typeClass isSubclassOfClass:NSArray.class]) {
                                    arrayPropretyKey = property.name.copy;
                                    *stop = YES;
                                }
                            }];
                            NSDictionary *datasDic = [NSDictionary dictionaryWithObject:datas forKey:arrayPropretyKey ?: @""];
                            data.modelObject = [entityClass mj_objectWithKeyValues:datasDic];
                        }
                    }
                } else {
                    data.isSuccess = NO;
                    data.errorType = FSConnectErrorType_Server_Error;
                    data.errMsg = data.errMsg.length? data.errMsg: serverErrorMessage;
                }
            }
        }
        
        [serverCodeHandler handleNetworkData:data];
        
        return data;

    } else {
        
        FSNetworkData *data = [[FSNetworkData alloc] init];
        data.isSuccess = NO;
        data.localReqestError = requestError;
        data.errCode = [NSString stringWithFormat:@"%ld", (long)requestError.code]; //暂时方案，其实没啥用
        data.errorType = FSConnectErrorType_Local;
        
        //处理本地网络出错
        if (requestError) {
            if (requestError.code == NSURLErrorTimedOut) {
                data.errorType = FSConnectErrorType_TimeOut;
                data.errMsg = [serverCodeHandler localNetworkTimeOutMessage];
            } else {
                data.errorType = FSConnectErrorType_Local;
                data.errMsg = [serverCodeHandler localNetworkErrorMessage];
            }
        }
        
        [serverCodeHandler handleNetworkData:data];

        return data;
    }
}

#pragma mark - Public Methods

- (void)sendRequest:(FSBaseRequest *)request
        entityClass:(nullable Class)entityClass
    completionBlock:(nullable FSNetworkCompletedBlock)completionBlock
{
    //处理请求参数
    id requestArgument = request.requestArgument;
    if ([requestArgument isKindOfClass:[NSDictionary class]] || !requestArgument) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (requestArgument) {
            [params addEntriesFromDictionary:requestArgument];
        }
        [params addEntriesFromDictionary:[self.netParamUtils requestCommonParamsWithUrl:request.requestUrl]];
        request.fs_requestParams = params;
    }
    
    
    /** 打印开始日志 J.J */
    if (self.logUtils) {
        [self.logUtils.class performSelector:@selector(logStartRequest:) withObject:request];
    }
            
    __weak __typeof__(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof FSBaseRequest * _Nonnull request) {
        __strong __typeof__(self) self = weakSelf;
        
        /** 打印结束日志 J.J */
        if (self.logUtils) {
            [self.logUtils.class performSelector:@selector(logEndRequest:) withObject:request];
        }
        
        request.networkData = [FSHTTPClient networkDataWithRequest:request succeed:YES requestError:nil serverCodeHandler:self.netServerCodeHandler entityClass:entityClass];
        
        if (self.netRequestHandler && [self.netRequestHandler respondsToSelector:@selector(handleReqest:entityClass:completionBlock:)]) {
            [self.netRequestHandler handleReqest:request entityClass:entityClass completionBlock:completionBlock];
        } else {
            if (completionBlock) {
                completionBlock(request.networkData, request);
            }
        }
        
    } failure:^(__kindof FSBaseRequest * _Nonnull request) {
        __strong __typeof__(self) self = weakSelf;
        
        /** 打印结束日志 J.J */
        if (self.logUtils) {
            [self.logUtils.class performSelector:@selector(logEndRequest:) withObject:request];
        }
        
        request.networkData = [FSHTTPClient networkDataWithRequest:request succeed:NO requestError:request.error serverCodeHandler:self.netServerCodeHandler entityClass:entityClass];
        
        if (self.netRequestHandler && [self.netRequestHandler respondsToSelector:@selector(handleReqest:entityClass:completionBlock:)]) {
            [self.netRequestHandler handleReqest:request entityClass:entityClass completionBlock:completionBlock];
        } else {
            if (completionBlock) {
                completionBlock(request.networkData, request);
            }
        }
    }];
}


@end
