//
//  NSMutableArray+FSSafe.h
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (FSSafe)

/// 安全 array */
+ (instancetype)safeArrayWithArray:(nullable NSArray<ObjectType> *)array;

/// 安全Add Object
- (void)safeAddObject:(nullable ObjectType)object;

/// 安全Add Array
- (void)safeAddObjectsFromArray:(nullable NSArray<ObjectType> *)array;

///安全Remove Object
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

/// 安全Insert Object
- (void)safeInsertObject:(nullable ObjectType)object atIndex:(NSUInteger)index;

/// 安全Insert Objects
- (void)safeInsertObjects:(nullable NSArray<ObjectType> *)objects atIndexes:(NSIndexSet *)indexs;

@end

NS_ASSUME_NONNULL_END
