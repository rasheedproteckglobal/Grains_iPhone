//
//  GrainsProfileSettings.m
//  Grains
//
//  Created by TCI on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import "GrainsProfileSettings.h"
#import "UserProfileSettings.h"



@implementation GrainsProfileSettings

- (id)init {
    self = [super init];
    if (self) {
        
        self.requestName = GET_SETTINGS_INFO;
        
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    
    NSDictionary *dic = (id)response;
    responseMessage = [dic objectForKey:@"ResponseMessage"];
    UserProfileSettings *userProfile = [[UserProfileSettings alloc] init];
    
    userProfile.responseCode = [NSNumber numberWithInt:[[dic objectForKey:@"ResponseCode"] intValue]];
    userProfile.userName = [dic objectForKey:@"UserName"];
    userProfile.email = [dic objectForKey:@"Email"];
    userProfile.location = [dic objectForKey:@"Location"];
    userProfile.photo = [dic objectForKey:@"Photo"];
    userProfile.smType = [NSNumber numberWithInt:[[dic objectForKey:@"SMType"] intValue]];
    
    [super didReceiveResponse:response parsedResult:responseMessage];
}

@end
