//
//  GetProfile.m
//  Grains
//
//  Created by Manu on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import "GetProfile.h"
#import "Profile.h"

@implementation GetProfile


- (id)init {
    self = [super init];
    if (self) {
        
        self.requestName = Login;
        
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    
    NSDictionary *dic = (id)response;
    responseMessage = [dic objectForKey:@"responseDesc"];
    NSArray *list  =  [dic objectForKey:@"listOfObjects"];
    
    Profile *profile =[[Profile alloc] init];
    
        profile.ProfileId =[dic objectForKey:@"ProfileId"];
        profile.UserName =[dic objectForKey:@"UserName"];
        profile.Photo =[dic objectForKey:@"Photo"];
        profile.FoodNotWastedCount =[dic objectForKey:@"FoodNotWastedCount"];
        profile.LongestChain =[dic objectForKey:@"LongestChain"];
        profile.Followers =[dic objectForKey:@"LongestChain"];
        profile.ResponseCode =[dic objectForKey:@"ResponseCode"];

    
    
    [[DataManager sharedInstance ] save];
    [super didReceiveResponse:response parsedResult:responseMessage];
}

@end
