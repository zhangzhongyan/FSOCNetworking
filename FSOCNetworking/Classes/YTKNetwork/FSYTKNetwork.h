//
//  FSYTKNetwork.h
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


/**
 pod 'YTKNetwork',             '2.1.4'
 2.1.4版本
 有修改FSYTKNetworkAgent.m类，所以从Pod中拿出来了
 */


#import <Foundation/Foundation.h>

#ifndef _FSYTKNETWORK_
    #define _FSYTKNETWORK_

#if __has_include(<FSYTKNetwork/FSYTKNetwork.h>)

    FOUNDATION_EXPORT double FSYTKNetworkVersionNumber;
    FOUNDATION_EXPORT const unsigned char FSYTKNetworkVersionString[];

    #import <FSYTKNetwork/FSYTKRequest.h>
    #import <FSYTKNetwork/FSYTKBaseRequest.h>
    #import <FSYTKNetwork/FSYTKNetworkAgent.h>
    #import <FSYTKNetwork/FSYTKBatchRequest.h>
    #import <FSYTKNetwork/FSYTKBatchRequestAgent.h>
    #import <FSYTKNetwork/FSYTKChainRequest.h>
    #import <FSYTKNetwork/FSYTKChainRequestAgent.h>
    #import <FSYTKNetwork/FSYTKNetworkConfig.h>

#else

    #import "FSYTKRequest.h"
    #import "FSYTKBaseRequest.h"
    #import "FSYTKNetworkAgent.h"
    #import "FSYTKBatchRequest.h"
    #import "FSYTKBatchRequestAgent.h"
    #import "FSYTKChainRequest.h"
    #import "FSYTKChainRequestAgent.h"
    #import "FSYTKNetworkConfig.h"

#endif /* __has_include */

#endif /* _FSYTKNETWORK_ */
