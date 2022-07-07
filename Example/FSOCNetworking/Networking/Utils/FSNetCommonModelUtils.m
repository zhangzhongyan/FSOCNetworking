//
//  FSNetCommonModelUtils.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSNetCommonModelUtils.h"

@implementation FSNetCommonModelUtils

#pragma mark - <FSNetServerCommonModelProtocol>

- (nullable NSDictionary *)mapingDictForServerCommonModel
{
    return @{@"status": @"status",
             @"message": @"message",
             @"datas": @"data"
    };
}

@end
