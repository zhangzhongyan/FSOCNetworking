//
//  FSServerCommonModel.h
//  FSOCNetworking
//
//  Created by 张忠燕 on 2022/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSServerCommonModel : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong, nullable) NSString *message;

@property (nonatomic, strong, nullable) id datas;

@end

NS_ASSUME_NONNULL_END
