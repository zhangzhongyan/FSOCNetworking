//
//  NSString+FSSafe.h
//  EVCRMApp
//
//  Created by 张忠燕 on 2021/11/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FSSafe)

- (nullable NSString *)safeSubstringToIndex:(NSUInteger)to;

@end

NS_ASSUME_NONNULL_END
