//
//  FSYTKNetworkAgent.h
//
//  Copyright (c) 2012-2016 YTKNetwork https://github.com/yuantiku
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "FSYTKNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class FSYTKBaseRequest;
@class AFSecurityPolicy;

///  FSYTKNetworkAgent is the underlying class that handles actual request generation,
///  serialization and response handling.
@interface FSYTKNetworkAgent : NSObject

@property (nonatomic, strong) FSYTKNetworkConfig *config;

@property (nonatomic, strong, nullable) AFSecurityPolicy *securityPolicy;

//- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Get the shared agent.
+ (FSYTKNetworkAgent *)sharedAgent;

///  Add request to session and start it.
- (void)addRequest:(FSYTKBaseRequest *)request;

///  Cancel a request that was previously added.
- (void)cancelRequest:(FSYTKBaseRequest *)request;

///  Cancel all requests that were previously added.
- (void)cancelAllRequests;

- (void)cancelRequestsWithUrl:(NSString *)urlStr;

///  Return the constructed URL of request.
///
///  @param request The request to parse. Should not be nil.
///
///  @return The result URL.
- (NSString *)buildRequestUrl:(FSYTKBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
