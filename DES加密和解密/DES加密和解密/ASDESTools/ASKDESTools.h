//
//  ASKDESTools.h
//  DES加密和解密
//
//  Created by Mac on 2020/4/15.
//  Copyright © 2020 Mac. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASKDESTools : NSObject

/// DES16进制加密
+ (NSString *)encodeDesWithString:(NSString *)string;

/// DES16进制解密
+ (NSString *)decodeDesWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
