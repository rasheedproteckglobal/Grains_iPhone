//
//  NSString+Secured.m
//  DIB
//
//  Created by Faizan Ali on 10/21/13.
//  Copyright (c) 2013 Faizan Ali. All rights reserved.
//

#import "NSString+Secured.h"
#import "NSString+AESCrypt.h"


#define kStart @"[APPSTART]"
#define kEnd @"[APPEND]"

@implementation NSString (Secured)

static NSString *_secretKey = nil;
static NSString *_deviceIdentifier = nil;

+ (void)setSecret:(NSString *)secret
{
	if (_secretKey == nil) {
		_secretKey = secret;
	} else {
		NSAssert(NO, @"The secret has already been set.");
	}
}


+ (void)setDeviceIdentifier:(NSString *)deviceIdentifier
{
	if (_deviceIdentifier == nil) {
		_deviceIdentifier = deviceIdentifier;
	} else {
		NSAssert(NO, @"The device identifier has already been set.");
	}
}

- (NSString*) encryptedString {
    if (_secretKey == nil) {
		// Use if statement in case asserts are disabled
		NSAssert(NO, @"Provide a secret before using any secure writing or reading methods!");
		return nil;
	}
    NSString *encrypted = [self AES128EncryptWithKey:_secretKey];
    return encrypted;
}

- (NSString*) decryptedString {
    if (_secretKey == nil) {
		// Use if statement in case asserts are disabled
		NSAssert(NO, @"Provide a secret before using any secure writing or reading methods!");
		return nil;
	}
    NSString *decrypted = [self AES128DecryptWithKey:_secretKey];
    decrypted = [decrypted stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return decrypted;
}

@end
