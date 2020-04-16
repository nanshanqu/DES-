//
//  ASDESTools.h
//  DES加密和解密
//
//  Created by Mac on 2020/4/15.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASDESTools : NSObject

/// 需要初始化iv的DES加密。（CBC模式）
+ (NSString *)encodeDesCBCWithString:(NSString*)stringCBC;
/// 需要初始化iv的DES解密。（CBC模式）
+ (NSString*)decodeDesCBCWithString:(NSString *)stringCBC;


/// 不需要初始化iv的DES加密。（ECB模式）
+ (NSString *)encodeDesECBWithString:(NSString*)stringECB;
/// 不需要初始化iv的DES解密。（ECB模式）
+ (NSString*)decodeDesECBWithString:(NSString *)stringECB;



@end

NS_ASSUME_NONNULL_END
