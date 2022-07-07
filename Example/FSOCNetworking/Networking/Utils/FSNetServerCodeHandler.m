//
//  FSNetServerCodeHandler.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSNetServerCodeHandler.h"
//Helper
#import "FSNotifyConstans.h"

@implementation FSNetServerCodeHandler

#pragma mark - <FSNetServerCodeHandlerProtocol>

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


@end
