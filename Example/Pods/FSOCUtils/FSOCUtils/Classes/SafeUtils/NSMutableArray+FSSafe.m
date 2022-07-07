//
//  NSMutableArray+FSSafe.m
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/9/10.
//

#import "NSMutableArray+FSSafe.h"

@implementation NSMutableArray (FSSafe)

#pragma mark - Public Methods

+ (instancetype)safeArrayWithArray:(nullable NSArray *)array {
    if (![array isKindOfClass:[NSArray class]]) {
        return [NSMutableArray array];
    }
    if (array) {
        return [NSMutableArray arrayWithArray:array];
    } else {
        return [NSMutableArray array];
    }
}

- (void)safeAddObject:(nullable id)object {
    if (object) {
        [self addObject:object];
    }
}

- (void)safeAddObjectsFromArray:(nullable NSArray *)array {
    if ([array isKindOfClass:[NSArray class]] ||
        [array isKindOfClass:[NSMutableArray class]]) {
        [self addObjectsFromArray:array];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {    
    if (index >= self.count) {
        return ;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)safeInsertObject:(nullable id)object atIndex:(NSUInteger)index {
    if (!object) {
        return ;
    }
    
    if (index > self.count) {
        return ;
    }
    
    [self insertObject:object atIndex:index];
}

- (void)safeInsertObjects:(nullable NSArray *)objects atIndexes:(NSIndexSet *)indexs {
    if (!indexs) {
        return ;
    }
    
    if (!objects) {
        return ;
    }
    
    if (indexs.count != objects.count ||
        indexs.firstIndex >= objects.count ||
        indexs.lastIndex >= objects.count) {
        return ;
    }
    
    [self insertObjects:objects atIndexes:indexs];
}


@end
