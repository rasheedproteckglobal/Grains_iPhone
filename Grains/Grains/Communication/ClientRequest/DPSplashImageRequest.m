//
//  DPSplashImageRequest.m
//  DubaiPolice
//
//  Created by Faizan Ali on 1/8/14.
//  Copyright (c) 2014 Advansoft. All rights reserved.
//

#import "DPSplashImageRequest.h"

@implementation DPSplashImageRequest
- (id)init {
    self = [super init];
    if (self) {
//        self.requestName = DP_SPLASH;
    }
    return self;
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    NSDictionary *dic = (id)response;
    NSArray *list  =  [dic objectForKey:@"listOfObjects"];

    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *obj in list) {
        int imageID = [[obj objectForKey:@"id"]intValue];
        NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ = %d",db_splash_id,imageID]];
        SplashImage *splashImage = [[DataManager sharedInstance]createUniqueObj:DB_TABLE_SPLASH withPredicate:pred];
        splashImage.splashID = [NSNumber numberWithInt:imageID];
        splashImage.imagePath = [obj objectForKey:@"imagePath"];
        [array addObject:splashImage];
        
    }
    if(array.count >0)
        [[DataManager sharedInstance] save];
    
    [super didReceiveResponse:response parsedResult:array];
}

@end
