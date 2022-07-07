//
//  FSNetRequestHandler.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSNetRequestHandler.h"

@implementation FSNetRequestHandler

#pragma mark - <FSNetRequestHandlerProtocol>

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

@end
