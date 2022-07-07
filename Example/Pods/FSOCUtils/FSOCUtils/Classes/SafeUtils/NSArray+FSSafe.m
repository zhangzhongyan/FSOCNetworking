//
//  NSArray+FSSafe.m
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import "NSArray+FSSafe.h"

@implementation NSArray (FSSafe)

#pragma mark - Public Methods

+ (instancetype)safeArrayWithObject:(nullable id)object
{
    if (object) {
        return [self arrayWithObject:object];
    }
    else {
        return [self array];
    }
}

- (nullable id)safeObjectAtIndex:(NSUInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    if (index >= self.count) {
        return nil;
    }
    else {
        return [self objectAtIndex:index];
    }
}

/** 安全取NSString */
- (nullable NSString *)safeStringAtIndex:(NSUInteger)index {
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (index >= self.count) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    } else if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else {
        return nil;
    }
}

- (BOOL)safeKindofElementClass:(Class)elementClass {
    for (id e in self) {
        if (![e isKindOfClass:elementClass]) {
            return NO;
        }
    }
    return YES;
}


@end
