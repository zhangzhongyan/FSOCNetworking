//
//  NSObject+FSMJKeyValue.h
//  Fargo
//
//  Created by 张忠燕 on 2022/4/20.
//  Copyright © 2022 geekthings. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (EVMJKeyValue)

+ (instancetype)fs_objectWithKeyValues:(nullable id)keyValues;

+ (instancetype)fs_objectWithKeyValues:(nullable id)keyValues context:(nullable NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
