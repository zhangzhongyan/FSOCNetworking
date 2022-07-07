//
//  NSArray+FSSafe.h
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (FSSafe)

/// 安全创建NSArray
+ (instancetype)safeArrayWithObject:(nullable ObjectType)object;

/// 安全取object
- (nullable ObjectType)safeObjectAtIndex:(NSUInteger)index;

/** 安全取NSString */
- (nullable NSString *)safeStringAtIndex:(NSUInteger)index;

/** 判断子元素是否是elementClass */
- (BOOL)safeKindofElementClass:(Class)elementClass;

@end

NS_ASSUME_NONNULL_END
