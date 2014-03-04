//
//  NSString+AESCrypt.h
//
//  AES128Encryption + Base64Encoding
//

#import "NSString+AESCrypt.h"
#import "Base64.h"

@implementation NSString (AESCrypt)

- (NSString *)AES128EncryptWithKey:(NSString *)key {
   
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES128EncryptWithKey:key];
    NSString *encryptedString = [Base64 encode:encryptedData];
    return encryptedString;
}

- (NSString *)AES128DecryptWithKey:(NSString *)key {

    NSData *base64data = [Base64 decode:self];
    NSData *deCryptedData = [base64data AES128DecryptWithKey:key];
    NSString *string = [[NSString alloc]initWithData:deCryptedData encoding:NSUTF8StringEncoding];
    return string;
    
}

@end
