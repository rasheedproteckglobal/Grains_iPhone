//
//  ImageRequest.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/8/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "ImageRequest.h"

@implementation ImageRequest
@synthesize url;
@synthesize userInfo;
@synthesize imageName;
@synthesize image;
@synthesize imageView;
@synthesize viewHolder;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithUrl:(NSURL*)_url userInfo:(NSDictionary*)_userInfo imageName:(NSString*)_imageName{
    self = [super init];
    if (self) {
        // Initialization code
        self.url = _url;
        self.userInfo = _userInfo;
        self.imageName = _imageName;
        imageView = nil;
        viewHolder = nil;
    }
    return self;
}

- (void) dealloc {
    [url release];
    [userInfo release];
    [imageName release];
    [image release];
    [imageView release];
    [viewHolder release];
    [super dealloc];
}


@end
