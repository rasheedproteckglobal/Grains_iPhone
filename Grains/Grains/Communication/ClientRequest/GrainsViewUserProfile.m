//
//  GrainsViewUserProfile.m
//  Grains
//
//  Created by TCI on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import "GrainsViewUserProfile.h"
#import "ViewUserProfile.h"



@implementation GrainsViewUserProfile

- (id)init {
    self = [super init];
    if (self) {
        
        self.requestName = GET_USER_PROFILE;
        
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    
    NSDictionary *dic = (id)response;
    responseMessage = [dic objectForKey:@"ResponseMessage"];
    ViewUserProfile *viewProfile = [[ViewUserProfile alloc] init];
    
    viewProfile.responseCode = [NSNumber numberWithInt:[[dic objectForKey:@"ResponseCode"] intValue]];
    viewProfile.userName = [dic objectForKey:@"UserName"];
    viewProfile.foodNotWastedDayCount = [NSNumber numberWithInt:[[dic objectForKey:@"FoodNotWastedDayCount"] intValue]];
    viewProfile.longestChain = [NSNumber numberWithInt:[[dic objectForKey:@"LongestChain"] intValue]];
    viewProfile.followers = [NSNumber numberWithInt:[[dic objectForKey:@"Followers"] intValue]];
    viewProfile.hasFollowed = [dic objectForKey:@"HasFollowed"];
    viewProfile.photo = [dic objectForKey:@"Photo"];
    viewProfile.profileID = [NSNumber numberWithInt:[[dic objectForKey:@"ProfileId"] intValue]];
    
    [super didReceiveResponse:response parsedResult:responseMessage];
}

@end
