//
//  FSServerCommonModel.m
//  FSOCNetworking
//
//  Created by 张忠燕 on 2022/7/1.
//

#import "FSServerCommonModel.h"
//Helper
#import <objc/runtime.h>

@implementation FSServerCommonModel

#pragma mark - <MJKeyValue>

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSDictionary *dict = [FSServerCommonModel FSMapingDict];
    return dict ?: @{};
}


#pragma mark - Property

+ (void)setFSMapingDict:(nullable NSDictionary *)dict {
    objc_setAssociatedObject(self, @selector(FSMapingDict), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (nullable NSDictionary *)FSMapingDict {
    return objc_getAssociatedObject(self, @selector(FSMapingDict));
}

@end
