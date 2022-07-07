//
//  FSNetServerCommonModelProtocol.h
//  FSOCNetworking
//
//  Created by 张忠燕 on 2022/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FSNetServerCommonModelProtocol <NSObject>

- (nullable NSString *)statusKeyForServerCommonModel;

- (nullable NSString *)messageKeyForServerCommonModel;

- (nullable NSString *)datasKeyForServerCommonModel;

@end

NS_ASSUME_NONNULL_END
