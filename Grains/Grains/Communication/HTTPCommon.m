//
//  GMCommon.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "HTTPCommon.h"
#import "Enum.h"
#import "Url.h"

@implementation HTTPCommon


static SERVER_MODE mode = PRODUCTION;


+ (NSString*) getBaseUrl {
    NSString *baseUrl = BASE_URL_DEVELOPMENT;
    return baseUrl;
}

@end
