//
//  NSDictionary+FSSafe.h
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (FSSafe)

/// 安全创建字典
+ (instancetype)safeDictionaryWithObject:(nullable ObjectType)object forKey:(nullable KeyType <NSCopying>)key;

/// 安全创建字典
+ (instancetype)safeDictionaryWithDictionary:(nullable NSDictionary<KeyType, ObjectType> *)dict;

/// 安全返回对象
- (nullable ObjectType)safeObjectForKey:(nullable KeyType)aKey;

/// 安全返回NSString
- (nullable NSString *)safeStringForKey:(nullable KeyType)key;

/// 安全返回NSArray
- (nullable NSArray *)safeArrayForKey:(nullable KeyType)key;

/// 安全返回NSDictionary
- (nullable NSDictionary *)safeDictionaryForKey:(nullable KeyType)key;

@end

NS_ASSUME_NONNULL_END
