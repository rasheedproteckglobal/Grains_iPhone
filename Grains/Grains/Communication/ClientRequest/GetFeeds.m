//
//  GetFeeds.m
//  Grains
//
//  Created by Manu on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import "GetFeeds.h"
#import "Feeds.h"
#import "Url.h"

@implementation GetFeeds


- (id)init {
    self = [super init];
    if (self) {
    
        self.requestName = GET_USER_FEEDS;
        
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
    
    Feeds *feeds =[[Feeds alloc] init];
    
    feeds.ProfileId =[dic objectForKey:@"ProfileId"];
    feeds.FeedId =[dic objectForKey:@"FeedId"];
    feeds.FeedTypeId =[dic objectForKey:@"FeedTypeId"];
    feeds.UserPhoto =[dic objectForKey:@"UserPhoto"];
    feeds.UserName =[dic objectForKey:@"UserName"];
    feeds.FeedPhoto =[dic objectForKey:@"FeedPhoto"];
    feeds.FeedMasterId =[dic objectForKey:@"FeedMasterId"];
    feeds.FeedContent =[dic objectForKey:@"FeedContent"];
    feeds.Location =[dic objectForKey:@"Location"];
    feeds.FeedDate =[dic objectForKey:@"FeedId"];
    

    [[DataManager sharedInstance ] save];
    [super didReceiveResponse:response parsedResult:responseMessage];

@end
