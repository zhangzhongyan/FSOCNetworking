//
//  FSNetLogProtocol.h
//  Fargo
//
//  Created by 张忠燕 on 2022/6/16.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WKWebView;
@class FSYTKBaseRequest;
@protocol FSNetLogProtocol <NSObject>

#pragma mark - NetWork

/** 打印开始Log */
+ (void)logStartRequest:(FSYTKBaseRequest *)request;

/** 打印结束Log */
+ (void)logEndRequest:(FSYTKBaseRequest *)request;

#pragma mark - WebView

/** WebView开始加载Log */
+ (void)logStartLoadWebView:(WKWebView *)webView;

/** WebView结束Log */
+ (void)logFinishLoadWebView:(WKWebView *)webView;

/** WebView失败Log */
+ (void)logFailLoadWebView:(WKWebView *)webView error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
