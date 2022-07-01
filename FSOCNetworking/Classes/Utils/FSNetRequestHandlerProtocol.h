//
//  FSNetRequestHandlerProtocol.h
//  Fargo
//
//  Created by 张忠燕 on 2022/6/22.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FSBaseRequest;
@class FSNetworkData;
@protocol FSNetRequestHandlerProtocol <NSObject>

- (void)handleReqest:(FSBaseRequest *)request entityClass:(nullable Class)entityClass completionBlock:(nullable void(^)(FSNetworkData *data,__kindof FSBaseRequest *request))completionBlock;

@end

NS_ASSUME_NONNULL_END
