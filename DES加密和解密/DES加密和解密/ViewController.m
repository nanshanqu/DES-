//
//  ViewController.m
//  DES加密和解密
//
//  Created by Mac on 2020/4/15.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"
#import "ASKDESTools.h"
#import "ASDESTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/// 16进制密文加解密
- (IBAction)encodeString16 {
    
    NSString *phoneNumber = @"13645681102";
    
    NSString *encodeString = [ASKDESTools encodeDesWithString:phoneNumber];
    NSString *decodeString = [ASKDESTools decodeDesWithString:encodeString];
    
    NSLog(@"encodeString:%@", encodeString); // 0DBDCB1C114A5FE7826CA74B7767323D
    NSLog(@"decodeString:%@", decodeString); // 13645681102
}

/// CBC加解密
- (IBAction)encodeStringCBC {
    
    NSString *phoneNumber = @"13645681102";
    
    NSString *encodeCBCString = [ASDESTools encodeDesCBCWithString:phoneNumber];
    NSString *decodeCBCString = [ASDESTools decodeDesCBCWithString:encodeCBCString];

    NSLog(@"encodeCBCString:%@", encodeCBCString); // TGM4vfyQa4LIe38JYT8AMg==
    NSLog(@"decodeCBCString:%@", decodeCBCString); // 13645681102
}

/// ECB加解密
- (IBAction)encodeStringECB {
    
    NSString *phoneNumber = @"13645681102";
    
    NSString *encodeECBString = [ASDESTools encodeDesECBWithString:phoneNumber];
    NSString *decodeECBString = [ASDESTools decodeDesECBWithString:encodeECBString];

    NSLog(@"encodeECBString:%@", encodeECBString); // TGM4vfyQa4LIe38JYT8AMg==
    NSLog(@"decodeECBString:%@", decodeECBString); // 13645681102
}



@end
