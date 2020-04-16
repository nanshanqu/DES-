//
//  ASKDESTools.m
//  DES加密和解密
//
//  Created by Mac on 2020/4/15.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ASKDESTools.h"
#import <CommonCrypto/CommonCryptor.h>

#define kASDESKEY  @"gg356tt8g5h6j9jh"

@implementation ASKDESTools

/// 使用DES加密方法
+ (NSString *)encodeDesWithString:(NSString *)string {
    NSString *ciphertext = nil;
    const char *textBytes = [string UTF8String];
    size_t dataLength = [string length];
    //==================
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    NSString *testString = kASDESKEY;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [kASDESKEY UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          (void *)bufferPtr, bufferPtrSize,
                                          &movedBytes);
    if (cryptStatus == kCCSuccess) {
        
        ciphertext= [ASKDESTools parseByte2HexString:bufferPtr :(int)movedBytes];

    }
    ciphertext=[ciphertext uppercaseString];//字符变大写
    
    return ciphertext;
}

/// 使用DES进行解密计算
+ (NSString *)decodeDesWithString:(NSString *)string {
    
    NSData* cipherData = [ASKDESTools convertHexStrToData:[string lowercaseString]];
    
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    NSString *testString = kASDESKEY;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [kASDESKEY UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;

}

/*
 加密解密中有两个方法调用，其实是为了16进制与data之间的转换。有些公司并未转换成16进制，而是需要跟base64共同加解密。方法适用，只需要将得出的plainText 的值转成base64即可。
 */

/// 加密时转成16进制
+ (NSString *) parseByte2HexString:(Byte *) bytes  :(int)len {
    
    
    NSString *hexStr = @"";
    
    if(bytes)
    {
        for(int i = 0; i < len ; i++)
        {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
            if([newHexStr length]==1)
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            else
            {
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
            
        }
    }
    
    return hexStr;
}

/// 解密时转回data
+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}



@end
