//
//  FSNetLogUtils.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSNetLogUtils.h"
//Helper
#import <WebKit/WebKit.h>
#import <MJExtension/MJExtension.h>

@implementation FSNetLogUtils

#pragma mark - <FSNetLogProtocol>

#pragma mark -- NetWork

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

#pragma mark -- WebView

+ (void)logStartLoadWebView:(WKWebView *)webView {

#ifdef DEBUG
    NSURL *URL = webView.URL;
    NSMutableString *logStr = [NSMutableString string];
    [logStr appendFormat:@"\n\n-----------------------------------WebView Start Load---------------------------------\n"];
    [logStr appendFormat:@"URL:%@\n", URL.absoluteString];
    [logStr appendFormat:@"scheme:%@\n", URL.scheme];
    [logStr appendFormat:@"host:%@\n", URL.host];
    [logStr appendFormat:@"port:%@\n", URL.port];
    [logStr appendFormat:@"path:%@\n", URL.path];
    [logStr appendFormat:@"---------------------------------------------------------------------------------------\n\n"];
    
    NSLog(@"%@", logStr);
#endif
}

+ (void)logFinishLoadWebView:(WKWebView *)webView {
    
#ifdef DEBUG
    NSURL *URL = webView.URL;
    NSMutableString *logStr = [NSMutableString string];
    [logStr appendFormat:@"\n\n===================================WebView Finish Load=================================\n"];
    [logStr appendFormat:@"URL:%@\n", URL.absoluteString];
    [logStr appendFormat:@"=======================================================================================\n\n"];
    
    NSLog(@"%@", logStr);
#endif
    
}

+ (void)logFailLoadWebView:(WKWebView *)webView error:(NSError *)error {
    
#ifdef DEBUG
    NSURL *URL = webView.URL;
    
    NSMutableString *logStr = [NSMutableString string];
    [logStr appendFormat:@"\n\n===================================WebView Failed Load=================================\n"];
    
    [logStr appendFormat:@"URL:%@\n", URL.absoluteString];
    
    if (error) {
        [logStr appendFormat:@"Error:%@\n", error];
    }
    [logStr appendFormat:@"=======================================================================================\n\n"];
    
    NSLog(@"%@", logStr);
#endif
}

@end

