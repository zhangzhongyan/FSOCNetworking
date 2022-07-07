//
//  NSDictionary+FSSafe.m
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import "NSDictionary+FSSafe.h"

@implementation NSDictionary (FSSafe)

#pragma mark - Public Methods

+ (instancetype)safeDictionaryWithObject:(nullable id)object forKey:(nullable id <NSCopying>)key {
    if (object && key) {
        return [self dictionaryWithObject:object forKey:key];
    }
    else {
        return [self dictionary];
    }
}

+ (instancetype)safeDictionaryWithDictionary:(nullable NSDictionary *)dict {
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return [NSDictionary dictionary];
    }
    
    return [self dictionaryWithDictionary:dict];
}

- (nullable id)safeObjectForKey:(nullable id)key {
    if (key) {
        return [self objectForKey:key];
    }
    else {
        return nil;
    }
}

- (nullable NSString *)safeStringForKey:(nullable id)key
{
    if (!key) {
        return nil;
    }
    
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    } else if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else {
        return nil;
    }
}


- (nullable NSArray *)safeArrayForKey:(nullable id)key {
    if (!key) {
        return nil;
    }
    
    NSArray *array = [self objectForKey:key];
    if (![array isKindOfClass:[NSArray class]]) {
        array = nil;
    }
    return array;
}

- (nullable NSDictionary *)safeDictionaryForKey:(nullable id)key {
    if (!key) {
        return nil;
    }
    
    NSDictionary *dictionary = [self objectForKey:key];
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return dictionary;
}

@end
