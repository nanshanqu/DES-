//
//  ASDESTools.m
//  DES加密和解密
//
//  Created by Mac on 2020/4/15.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ASDESTools.h"
#import <CommonCrypto/CommonCryptor.h>

#define kASDESKEY  @"gg356tt8g5h6j9jh"

/// 两个iv任选其一，必须要和你的后台对应。（CBC模式）
const Byte iv[] = {1,2,3,4,5,6,7,8};
//const Byte iv[] = {0,1,2,3,4,5,6,7};

@implementation ASDESTools

//**************************CBC模式*********************************

/// 需要初始化iv的DES加密。（CBC模式）
+ (NSString *)encodeDesCBCWithString:(NSString*)stringCBC {
    
    NSData*data;
//    NSString*ciphertext =nil;
    NSData *textData = [stringCBC dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    
    memset(buffer,0,sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding ,
                                          [kASDESKEY UTF8String],kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer,1024,
                                          &numBytesEncrypted);
    
    if(cryptStatus ==kCCSuccess) {
        
        data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
    }
    
    NSString *result = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return result;
    
}

/// 需要初始化iv的DES解密。（CBC模式）
+ (NSString*)decodeDesCBCWithString:(NSString *)stringCBC {
    
//    NSData*plaindata =nil;
    NSString*plaintext =nil;
    //    NSData *cipherdata = [GTMBase64 decodeString:stringCBC];
    NSData *cipherdata = [[NSData alloc] initWithBase64EncodedString:stringCBC options:NSDataBase64DecodingIgnoreUnknownCharacters];
    unsigned char buffer[1024];
    
    memset(buffer,0,sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding ,
                                          [kASDESKEY UTF8String],kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer,1024,
                                          &numBytesDecrypted);
    
    if (cryptStatus ==kCCSuccess) {
        
        NSData*plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
        
    }
    
    return plaintext;
    
}


//**************************ECB模式*********************************


/// 不需要初始化iv的DES加密。（ECB模式）
+ (NSString *)encodeDesECBWithString:(NSString*)stringECB {
    
    NSData*data;
//    NSString*ciphertext =nil;
    NSData *textData = [stringECB dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    
    memset(buffer,0,sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [kASDESKEY UTF8String],kCCKeySizeDES,
                                          NULL,
                                          [textData bytes], dataLength,
                                          buffer,1024,
                                          &numBytesEncrypted);
    if(cryptStatus ==kCCSuccess) {
        
        data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
    }
    
    NSString *result = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return result;
    
}

/// 不需要初始化iv的DES解密。（ECB模式）
+ (NSString*)decodeDesECBWithString:(NSString *)stringECB {
    
//    NSData*plaindata = nil;
    NSString*plaintext = nil;
    //    NSData *cipherdata = [GTMBase64 decodeString:stringECB];
    NSData *cipherdata = [[NSData alloc] initWithBase64EncodedString:stringECB options:NSDataBase64DecodingIgnoreUnknownCharacters];
    unsigned char buffer[1024];
    
    memset(buffer,0,sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [kASDESKEY UTF8String],kCCKeySizeDES,
                                          NULL,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer,1024,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        NSData*plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}








@end
