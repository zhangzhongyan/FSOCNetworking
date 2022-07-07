//
//  FSFileRespEntity.h
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSFileRespEntity : NSObject

@property (nonatomic, copy, nullable) NSString *fileKey;

@property (nonatomic, copy, nullable) NSString *fileId;

@property (nonatomic, copy, nullable) NSString *code;

@property (nonatomic, copy, nullable) NSString *fileUrl;

@end

NS_ASSUME_NONNULL_END
