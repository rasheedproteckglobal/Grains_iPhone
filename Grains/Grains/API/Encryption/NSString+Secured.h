//
//  NSString+Secured.h
//  DIB
//
//  Created by Faizan Ali on 10/21/13.
//  Copyright (c) 2013 Faizan Ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Secured)


+ (void)setSecret:(NSString *)secret;

- (NSString*) encryptedString;
- (NSString*) decryptedString;

@end
