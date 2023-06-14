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

@property (nonatomic, strong) FSYTKNetworkAgent *networkAgent;

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
        [self setupNotify];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Methods

- (void)setupAFNReachability {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyReachabilityStatusNotify object:@(status)];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)setupNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleReachabilityStatusNotify:) name:kNotifyReachabilityStatusNotify object:nil];
}

- (void)handleReachabilityStatusNotify:(NSNotification *)noti
{
    if ([noti.object isKindOfClass:NSNumber.class]) {
        NSNumber *status = noti.object;
        // 一共有四种状态
        switch (status.integerValue) {
            case AFNetworkReachabilityStatusNotReachable:
                self.reachabilityStatus = FSNetworkReachabilityStatusNotReachable;
                NSLog(@"AFNetworkReachability Not Reachable");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachability Reachable via WWAN");
                self.reachabilityStatus = FSNetworkReachabilityStatusWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.reachabilityStatus = FSNetworkReachabilityStatusWiFi;
                NSLog(@"AFNetworkReachability Reachable via WiFi");
                break;
            case AFNetworkReachabilityStatusUnknown:
            default:
                self.reachabilityStatus = FSNetworkReachabilityStatusUnknown;
                NSLog(@"AFNetworkReachability Unknown");
                break;
        }
    }
}

#pragma mark -- EVNetworkData

/** 处理request */
+ (FSNetworkData *)networkDataWithRequest:(FSYTKBaseRequest *)request
                                  succeed:(BOOL)succeed
                             requestError:(nullable NSError *)requestError
                netServerCommonModelUtils:(nullable id<FSNetServerCommonModelProtocol>)netServerCommonModelUtils
                        serverCodeHandler:(nullable id<FSNetServerCodeHandlerProtocol>)serverCodeHandler
                              entityClass:(nullable Class)entityClass {
    if (succeed) {
        
        FSNetworkData *data = [[FSNetworkData alloc] init];
        data.requestURL = request.requestUrl;
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
                
                id jsonObject = request.responseJSONObject;
                
                //键值映射
                if (netServerCommonModelUtils && [jsonObject isKindOfClass:NSDictionary.class]) {
                    jsonObject = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
                    NSDictionary *mapDict = [netServerCommonModelUtils mapingDictForServerCommonModel];
                    for (NSString *key in mapDict) {
                        NSString *value = [mapDict objectForKey:key];
                        id targetValue = [jsonObject objectForKey:value];
                        if (targetValue) {
                            [jsonObject setObject:targetValue forKey:key];
                        }
                    }
                }
                
                FSServerCommonModel *commonModel = [FSServerCommonModel fs_objectWithKeyValues:jsonObject];
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
        data.requestURL = request.requestUrl;
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
        [params addEntriesFromDictionary:[self.netParamUtils requestCommonParamsWithUrl:request.requestUrl]];
        if (requestArgument) {
            [params addEntriesFromDictionary:requestArgument];
        }
        request.fs_requestParams = params;
    }
    
    
    /** 打印开始日志 J.J */
    if (self.logUtils) {
        [self.logUtils.class performSelector:@selector(logStartRequest:) withObject:request];
    }
            
    /** 网络安全工具 */
    __weak __typeof__(self) weakSelf = self;
    request.requestNetworkAgentBlock = ^FSYTKNetworkAgent * _Nonnull{
        __strong __typeof__(self) self = weakSelf;
        return self.networkAgent;
    };
    
    [request startWithCompletionBlockWithSuccess:^(__kindof FSBaseRequest * _Nonnull request) {
        __strong __typeof__(self) self = weakSelf;
        
        /** 打印结束日志 J.J */
        if (self.logUtils) {
            [self.logUtils.class performSelector:@selector(logEndRequest:) withObject:request];
        }
        
        request.networkData = [FSHTTPClient networkDataWithRequest:request succeed:YES requestError:nil netServerCommonModelUtils:self.netServerCommonModelUtils serverCodeHandler:self.netServerCodeHandler entityClass:entityClass];
        
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
        
        request.networkData = [FSHTTPClient networkDataWithRequest:request succeed:NO requestError:request.error netServerCommonModelUtils:self.netServerCommonModelUtils  serverCodeHandler:self.netServerCodeHandler entityClass:entityClass];

        if (self.netRequestHandler && [self.netRequestHandler respondsToSelector:@selector(handleReqest:entityClass:completionBlock:)]) {
            [self.netRequestHandler handleReqest:request entityClass:entityClass completionBlock:completionBlock];
        } else {
            if (completionBlock) {
                completionBlock(request.networkData, request);
            }
        }
    }];
}

#pragma mark - property

- (FSYTKNetworkAgent *)networkAgent
{
    if (!_networkAgent) {
        _networkAgent = [[FSYTKNetworkAgent alloc] init];
        if (self.securityPolicyUtils) {
            _networkAgent.securityPolicy = [self.securityPolicyUtils requestSecurityPolicy];
        }
        if (self.baserUrlUtils) {
            _networkAgent.config.baseUrl = [self.baserUrlUtils baseURL];
        }
    }
    return _networkAgent;
}

@end
