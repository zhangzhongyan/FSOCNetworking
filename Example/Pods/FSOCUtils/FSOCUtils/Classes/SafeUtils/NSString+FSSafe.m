//
//  NSString+FSSafe.m
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/11/4.
//

#import "NSString+FSSafe.h"

@implementation NSString (FSSafe)

- (nullable NSString *)safeSubstringToIndex:(NSUInteger)to {
    if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (to > self.length) {
        return nil;
    }
    else {
        return [self substringToIndex:to];
    }
}

@end
