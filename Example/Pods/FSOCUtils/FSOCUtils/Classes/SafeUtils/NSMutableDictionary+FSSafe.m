//
//  NSMutableDictionary+FSSafe.m
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import "NSMutableDictionary+FSSafe.h"

@implementation NSMutableDictionary (FSSafe)

#pragma mark - Public Methods

+ (instancetype)safeDictionaryWithDictionary:(nullable NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return [self dictionaryWithDictionary:dict];
    }
    else {
        return [NSMutableDictionary dictionary];
    }
}

- (void)safeSetObject:(nullable id)anObject forKey:(nullable id<NSCopying>)aKey {
    if (anObject && aKey && ![anObject isKindOfClass:[NSNull class]]) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)safeRemoveObjectForKey:(nullable id<NSCopying>)aKey {
    if (aKey) {
        [self removeObjectForKey:aKey];
    }
}

- (void)safeAddEntriesFromDictionary:(nullable NSDictionary *)otherDictionary {
    if ([self isKindOfClass:[NSMutableDictionary class]] &&
        [otherDictionary isKindOfClass:[NSDictionary class]]) {
        [self addEntriesFromDictionary:otherDictionary];
    }
}

@end
