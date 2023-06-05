//
//  FSNetSecurityPolicyProtocol.h
//  FSOCNetworking
//
//  Created by 张忠燕 on 2023/6/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AFSecurityPolicy;
@protocol FSNetSecurityPolicyProtocol <NSObject>

- (AFSecurityPolicy *)requestSecurityPolicy;

@end

NS_ASSUME_NONNULL_END
