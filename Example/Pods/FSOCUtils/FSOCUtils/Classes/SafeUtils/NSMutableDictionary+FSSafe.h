//
//  NSMutableDictionary+FSSafe.h
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary<KeyType, ObjectType> (FSSafe)

+ (instancetype)safeDictionaryWithDictionary:(nullable NSDictionary<KeyType, ObjectType> *)dict;

- (void)safeSetObject:(nullable ObjectType)anObject forKey:(nullable KeyType <NSCopying>)aKey;

- (void)safeRemoveObjectForKey:(nullable KeyType)aKey;

/** Dictionary add otherDictionary */
- (void)safeAddEntriesFromDictionary:(nullable NSDictionary<KeyType, ObjectType> *)otherDictionary;

@end

NS_ASSUME_NONNULL_END
