#FSOCNetworking

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/FSOCNetworking.svg)](https://img.shields.io/cocoapods/v/FSOCNetworking.svg)
[![Platform](https://img.shields.io/cocoapods/p/FSOCNetworking.svg?style=flat)](http://cocoadocs.org/docsets/FSOCNetworking)


<!--[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)-->
在AFNetworking基础上，封装YTKRequest，提供更面向业务处理的网络层


## 如何安装
- [下载Zip包](https://github.com/zhangzhongyan/FSOCNetworking/archive/master.zip) 将FSOCNetworking文件夹内源码copy到项目集成
- 通过Pod进行安装：

```ruby
pod 'FSOCNetworking'
```
## 依赖库

|依赖库|版本|备注|
|:-:|:-:|:-:|
| AFNetworking |  4.0.1 | 网络基础 | 
| MJExtension | 未指定 | 数据模型 | 
| FSOCUtils/JSONUtils | 未指定 | 安全JSON数据模型 | 

## 说明
### 适用场景

- 服务端返回数据为JSON

```
//ResponseModel
{
    "status":10000,
    "message":"Success", 
    "datas":id
}
```
- 文件上传/文件下载

### 请求模型
FSBaseRequest：网络请求胖模型

- 按照业务抽象出来的实体模型
- 处理服务端和本地错误
- 兼容文件下载
- 兼容数据类型

```
@interface FSBaseRequest : FSYTKRequest
/// 便捷构造方法
/// @param url 请求URL
/// @param method 请求方法
/// @param params 请求参数
/// @param headersBlock 请求头
/// @param timeout 请求超时时间
/// @param requestSerializerBlock 请求数据形式
/// @param responseSerializerBlock 响应数据形式
/// @param baseURL 基础URL
/// @param resumableDownloadPath 下载文件地址
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
```


### 响应模型

FSServerCommonModel:服务端响应JSON数据模型

- status：服务端状态码
- message：服务端
- datas：服务端数据

FSNetworkData：网络响应模型

- 按照业务抽象出来的实体模型
- 处理服务端和本地错误
- 兼容文件下载
- 兼容数据类型


## 配置网络

#### 1、配置FSHTTPClient

**注意：按需选择实现**

```
#import <FSOCNetworking/FSOCNetworking.h>
#import <FSOCNetworking/FSYTKNetworkConfig.h>

+ (void)setupNetworkConfig {

    FSYTKNetworkConfig.sharedConfig.securityPolicy = [FSNetworkingConfigure shareSecurityPolicy];

    FSHTTPClient.shared.logUtils = [[FSNetLogUtils alloc] init];
    FSHTTPClient.shared.netParamUtils = [[FSNetParamUtils alloc] init];
    FSHTTPClient.shared.netServerCommonModelUtils = [[FSNetCommonModelUtils alloc] init];
    FSHTTPClient.shared.netServerCodeHandler = [[FSNetServerCodeHandler alloc] init];
    FSHTTPClient.shared.netRequestHandler = [[FSNetRequestHandler alloc] init];
}
```

#### 2、实现协议FSNetLogProtocol

```
/** 打印开始Log */
+ (void)logStartRequest:(FSYTKBaseRequest *)request {
    
#ifdef DEBUG
    
    FSYTKRequestMethod method = [request requestMethod];
    NSString *methodString = @"--";
    if (method == FSYTKRequestMethodGET) {
        methodString = @"GET";
    }
    else if (method == FSYTKRequestMethodPOST) {
        methodString = @"POST";
    }
    else if (method == FSYTKRequestMethodHEAD) {
        methodString = @"HEAD";
    }
    else if (method == FSYTKRequestMethodPUT) {
        methodString = @"PUT";
    }
    else if (method == FSYTKRequestMethodDELETE) {
        methodString = @"DELETE";
    }
    else if (method == FSYTKRequestMethodPATCH) {
        methodString = @"PATCH";
    }
    
    NSMutableString *logStr = [NSMutableString string];
    [logStr appendFormat:@"\n\n--------------------------请求开始--------------------------\n"];
    [logStr appendFormat:@"请求方式:%@\n", methodString];
    [logStr appendFormat:@"请求地址:%@\n", request.requestUrl];
    [logStr appendFormat:@"请求参数:\n%@\n", [request.requestArgument mj_JSONString] ? : @""];
    [logStr appendFormat:@"------------------------------------------------------------\n\n. "];
    
    NSLog(@"%@", logStr);
#endif
    
}

/** 打印结束Log */
+ (void)logEndRequest:(FSYTKBaseRequest *)request {
    
#ifdef DEBUG
    NSMutableString *logStr = [NSMutableString string];
    [logStr appendFormat:@"\n\n===========================请求结束==========================\n"];
    
    NSURLRequest *URLRequest = request.originalRequest;
    [logStr appendFormat:@"请求地址:%@\n", URLRequest.URL];
    [logStr appendFormat:@"GET子串:%@\n", URLRequest.URL.query ? : @""];
    [logStr appendFormat:@"网络状态码:%ld\n", (long)request.responseStatusCode];
    [logStr appendFormat:@"errMsg:%@\n", request.error];
    
    [logStr appendFormat:@"返回responseJSON:\n%@\n", [request.responseJSONObject mj_JSONString]];
    NSError *error = request.requestTask.error;
    if (error) {
        [logStr appendFormat:@"Error Domain:%@\n", error.domain];
        [logStr appendFormat:@"Error Domain Code:%ld\n", (long)error.code];
        [logStr appendFormat:@"Error Localized Description:%@\n", error.localizedDescription];
        [logStr appendFormat:@"Error Localized Failure Reason:%@\n", error.localizedFailureReason];
        [logStr appendFormat:@"Error Localized Recovery Suggestion:%@\n", error.localizedRecoverySuggestion];
    }
    [logStr appendFormat:@"=============================================================\n\n."];
    
    NSLog(@"%@", logStr);
#endif
    
}
```

#### 3、实现协议FSNetParamProtocol

```
- (NSMutableDictionary *)requestHeaderFields {
    NSMutableDictionary *headParamDic = [NSMutableDictionary dictionary];
    //定制化请求头（eg:标识请求类型）
    return headParamDic;
}

- (NSMutableDictionary *)requestCommonParamsWithUrl:(NSString *)url {
    NSMutableDictionary *commonParams = [NSMutableDictionary dictionary];
    //语言
    [commonParams safeSetObject:@"cn" forKey:@"language"];
    //appType
    [commonParams safeSetObject:@(1) forKey:@"appType"];
    //版本号
    [commonParams safeSetObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    //BundleId
    [commonParams safeSetObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"appBundleId"];
    // 用户ID
    [commonParams safeSetObject:@(1) forKey:@"userId"];
    // 随机数
    int random = arc4random() % 100 ;
    [commonParams safeSetObject:@(random) forKey:@"nonce"];
    // 时间戳
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970] * 1000];
    [commonParams safeSetObject:timestamp forKey:@"timestamp"];
    //设备类型
    [commonParams safeSetObject:@(1) forKey:@"deviceType"];
    // 签名
    [commonParams safeSetObject:@"gn;eabgebg;b" forKey:@"signature"];
    return commonParams;
}
```

#### 4、实现协议FSNetServerCommonModelProtocol

**注意**：键值对映射，主要用于JSON—>FSServerCommonModel模型，根据服务端返回进行映射

```
/// 例如返回数据为{"status":10000,"message":"Success", "data":id}
- (nullable NSDictionary *)mapingDictForServerCommonModel
{
    return @{@"status": @"status",
             @"message": @"message",
             @"datas": @"data" 
    };
}
```
#### 5、实现协议FSNetServerCodeHandlerProtocol

**注意**：如果serverErrorMessageWithCode返回nil，则业务成功


```
- (NSString *)localNetworkTimeOutMessage
{
    return @"网络超时\n请稍后重试";
}

- (NSString *)localNetworkErrorMessage
{
    return @"网络异常\n请更换网络或稍后重试";
}

- (nullable NSString *)serverErrorMessageWithCode:(NSInteger)serverCode
{
    if (serverCode == 10000) {
        return nil;
    } else {
        if (serverCode == 10001) {
            return @"Token失效";
        }
        else if (serverCode == 10003) {
            return @"服务器维护中";
        }
        else {
            return @"服务器异常，请稍后重试";
        }
    }
}

- (void)handleNetworkData:(FSNetworkData *)networkData
{
    // Token失效
    if (networkData.serverStatus == 10001) {
        dispatch_async(dispatch_get_main_queue(), ^{
            /// 进行统一界面交互
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyTokenInvalid object:nil];
        });
    }
    
    // 本地网络错误
    if (networkData.localReqestError) {
        //网络不安全
        if (networkData.localReqestError.code == NSURLErrorServerCertificateUntrusted ||
            networkData.localReqestError.code == NSURLErrorUserCancelledAuthentication) {
            dispatch_async(dispatch_get_main_queue(), ^{
                /// 进行统一界面交互、防止抓包
            });
        }
    }
}

```

#### 6、实现协议FSNetRequestHandlerProtocol

```
- (void)handleReqest:(FSBaseRequest *)request entityClass:(nullable Class)entityClass completionBlock:(nullable void (^)(FSNetworkData * _Nonnull, __kindof FSBaseRequest * _Nonnull))completionBlock
{
    if (request.networkData.serverStatus == 10005 ||
             request.networkData.serverStatus == 10006 ||
             request.networkData.serverStatus == 10007) {
        //重新生成密钥，进行密钥交换
    }
    else if (request.networkData.serverStatus) {
        if (completionBlock) {
            completionBlock(request.networkData, request);
        }
    }
    else {
        
        // 密匙交换第一步成功、但是第二步失败
        if (0) {
        }
        else {
            if (completionBlock) {
                completionBlock(request.networkData, request);
            }
        }
    }
}
```

## 使用例子



### Post请求
聚焦业务URL、参数、数据模型

```objective-c
@weakify(self);
[MBProgressHUD showLoadingInView:self.view];
[[FSHTTPClient shared] postRequestWithUrl:@"api/userInfo" parameters:params entityClass:FSUserInfoEntity.class complateBlock:^(FSNetworkData * _Nonnull data, __kindof FSBaseRequest * _Nonnull request) {
    @strongify(self);
    [MBProgressHUD hidenLoadingInView:self.view];

    if (data.isSuccess) {
        //处理数据、刷新界面
        [self.viewModel handleData:data.modelObject];
        [self.tableView reaload];
    } else {
        [MBProgressHUD showToastMessage:data.errMsg];
    }
}];
```

### Post上传文件

```objective-c
NSData *imageData = [NSData data];
NSString *fileName = [NSString stringWithFormat:@"%ld_iOS.jpg", (long)[[NSDate date] timeIntervalSince1970] * 1000];;
    
@weakify(self);
[MBProgressHUD showLoadingInView:self.view];
[[FSHTTPClient shared] postRequestWithUrl:@"api/file/upload" parameters:params entityClass:FSFileRespEntity.class constructingBodyBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    [formData appendPartWithFileData:imageData name:@"files[0].file" fileName:fileName mimeType:@"image/jpeg"];
} complateBlock:^(FSNetworkData * _Nonnull data, __kindof FSBaseRequest * _Nonnull request) {
    @strongify(self);
    [MBProgressHUD hidenLoadingInView:self.view];
    if (data.isSuccess) {
        //处理数据、刷新界面
        [self.viewModel handleData:data.modelObject];
        [self.tableView reaload];
    } else {
        [MBProgressHUD showToastMessage:data.errMsg];
    }
}];

```

### Post下载文件

```objective-c
NSString *resumableDownloadPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"临时文件名"];
    
@weakify(self);
[MBProgressHUD showLoadingInView:self.view];
[[FSHTTPClient shared] postDownloadFileWithURL:@"api/file/down" parameters:params resumableDownloadPath:resumableDownloadPath complateBlock:^(FSNetworkData * _Nonnull data, __kindof FSBaseRequest * _Nonnull request) {
    @strongify(self);
    [MBProgressHUD hidenLoadingInView:self.view];
    if (data.isSuccess) {
        //处理数据、刷新界面
        [self.viewModel handleData:data.modelObject];
        [self.tableView reaload];
    } else {
        [MBProgressHUD showToastMessage:data.errMsg];
    }
}];
```


## 结构


### Utils协议库

* `<FSNetLogProtocol>`打印协议
  - `logStartRequest:` //请求开始
  - `logEndRequest:`//请求结束
  
* `<FSNetParamProtocol>`参数协议
  - `requestHeaderFields`//请求头 
  - `requestCommonParamsWithUrl:` //公共参数
  
* `<FSNetServerCommonModelProtocol>`响应模型协议
  - `mapingDictForServerCommonModel:` //服务端status、message、datas字段
  
* `<FSNetRequestHandlerProtocol>` 回调处理协议
  - 业务回调之前进行统一处理（比如动态网络配置、加密密钥交换）
  - `- (void)handleReqest:(FSBaseRequest *)request entityClass:(nullable Class)entityClass completionBlock:(nullable void(^)(FSNetworkData *data,__kindof FSBaseRequest *request))completionBlock;`
  
* `<FSNetServerCodeHandlerProtocol>` 状态码处理协议
  - `- (NSString *)localNetworkTimeOutMessage` //网路超时信息
  - `- (NSString *)localNetworkErrorMessage:` //本地网络出错信息
  - `- (nullable NSString *)serverErrorMessageWithCode:(NSInteger)serverCode;` //服务端业务出错信息
  - `- (void)handleNetworkData:(FSNetworkData *)networkData` //统一处理业务码（eg：token失效）


### YTKNetwork包装库

- 由于项目使用YTKNetwork，它的具体使用可以参考[YTKNetwork](https://github.com/yuantiku/YTKNetwork) 

### Request包装库

* `FSBaseRequest`
	- 继承YTKRequest
	- headersBlock //动态获取请求头
	- requestSerializerBlock //动态系列化请求体
	- responseSerializerBlock //动态解析响应体
	
### Security库

* `FSSecurityPolicy`
	- 继承AFSecurityPolicy
	- 重写方法evaluateServerTrust:forDomain:（不需要本地包含证书验证）
	- 使用场景（证书容易过期，频繁更换）

### Model模型库

* `FSNetworkData`说明部分包含了
* `FSServerCommonModel` 说明部分包含了

### Client模型库
	
* `FSHTTPClient`
	- 网络请求客户端
	- 通过<协议>方式拓展功能性插件
	- 发送FSBaseRequest请求，携带解析模型，进行业务回调处理







