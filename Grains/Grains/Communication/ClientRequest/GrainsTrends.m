//
//  GrainsTrends.m
//  Grains
//
//  Created by TCI on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

//
//  DPPharmacyRequest.m
//  DubaiPolice
//
//  Created by Advansoft on 12/22/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import "GrainsTrends.h"
#import "Trends.h"



@implementation GrainsTrends

- (id)init {
    self = [super init];
    if (self) {
        
        self.requestName = GET_TREND_DATA;
        
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    
    NSDictionary *dic = (id)response;
    responseMessage = [dic objectForKey:@"ResponseMessage"];
    Trends *trends = [[Trends alloc] init];
    
    trends.foodSavedDaysCount = [NSNumber numberWithInt:[[dic objectForKey:@"FoodSavedDaysCount"] intValue]];
    trends.totalTrackedDays = [NSNumber numberWithInt:[[dic objectForKey:@"TotalTrackedDays"] intValue]];
    trends.accuracyPercent = [NSNumber numberWithInt:[[dic objectForKey:@"AccuracyPercent"] intValue]];
    trends.rank = [NSNumber numberWithInt:[[dic objectForKey:@"Rank"] intValue]];
    trends.responseCode = [NSNumber numberWithInt:[[dic objectForKey:@"ResponseCode"] intValue]];
    
    [super didReceiveResponse:response parsedResult:responseMessage];
}

@end

