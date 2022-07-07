//
//  FSEnvironmentUtils.m
//  FSOCNetworking_Example
//
//  Created by 张忠燕 on 2022/7/7.
//  Copyright © 2022 张忠燕. All rights reserved.
//

#import "FSEnvironmentUtils.h"
#import "FSURLMacro.h"

@implementation FSEnvironmentUtils

#pragma mark - Public Methods

+ (NSString *)baseAPIURL
{
#ifdef DEBUG
    //可以根据情况切换环境
    return kAPIBaseURL_Dev;
#else
    return kAPIBaseURL_Release;
#endif
}

@end
