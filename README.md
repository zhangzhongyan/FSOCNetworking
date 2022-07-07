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
 	"data":id
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

```
@interface FSServerCommonModel : NSObject
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong, nullable) NSString *message;
@property (nonatomic, strong, nullable) id datas;
@end
```

FSNetworkData：网络响应模型

- 按照业务抽象出来的实体模型
- 处理服务端和本地错误
- 兼容文件下载
- 兼容数据类型

```
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

```




## 使用例子

### Post请求

### 文件上传请求

### 文件下载请求

 
### 插件化请求

##### 请求头
##### 公共参数

### 处理请求






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







