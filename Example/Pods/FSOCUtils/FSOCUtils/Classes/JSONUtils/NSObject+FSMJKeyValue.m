//
//  NSObject+FSMJKeyValue.m
//  Fargo
//
//  Created by 张忠燕 on 2022/4/20.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import "NSObject+FSMJKeyValue.h"
#import <MJExtension/MJExtension.h>

@implementation NSObject (EVMJKeyValue)

+ (instancetype)fs_objectWithKeyValues:(nullable id)keyValues
{
    return [self fs_objectWithKeyValues:keyValues context:nil];
}

+ (instancetype)fs_objectWithKeyValues:(nullable id)keyValues context:(nullable NSManagedObjectContext *)context
{
    // 获得JSON对象
    keyValues = [keyValues mj_JSONObject];
    keyValues = [keyValues isKindOfClass:NSDictionary.class]? keyValues: @{};
    
    if ([self isSubclassOfClass:[NSManagedObject class]] && context) {
        NSString *entityName = [NSStringFromClass(self) componentsSeparatedByString:@"."].lastObject;
        return [[NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context] mj_setKeyValues:keyValues context:context];
    }
    return [[[self alloc] init] mj_setKeyValues:keyValues];
}

@end
