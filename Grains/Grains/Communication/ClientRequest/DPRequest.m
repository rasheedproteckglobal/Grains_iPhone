 //
//  DCCIRequest.m
//  DubaiChamber
//
//  Created by Syed Adeel Mahmood on 10/8/13.
//  Copyright (c) 2013 Dubai Chamber. All rights reserved.
//

#import "DPRequest.h"
#import "NSDate+CWAdditions.h"
#import "HTTPClient.h"
#import "HTTPRequest.h"
#import "NSDate+Utility.h"
#import "Reachability.h"
#import "AppSettings.h"
#import "NSData+AESCrypt.h"

#define kENTITY_NAME @"entity"
#define kDEVICE_LOCALE @"language"
#define kUPDATED_DATE @"updatedDate"
#define kSERVER_DATE @"serverDate"
#define kDEVICE_ID @"deviceId"
#define kSECURE_KEY @"iPwvD6XtJsZ1pTyA"

#define kResponseCode @"responseCode"
#define kResponseDesc @"responseDesc"

@implementation DPRequest

@synthesize didFinish;
@synthesize didFail;
@synthesize delegate;
@synthesize requestName;
@synthesize requestParams;
@synthesize userInfo;
@synthesize responseSuccess;
@synthesize responseMessage;
@synthesize responseStatusCode;


- (id)init {
    self = [super init];
    if (self) {
        self.requestName = nil;
        self.delegate = nil;
        self.didFail  = nil;
        self.didFinish = nil;
        self.requestParams = nil;
        isFirstTime = NO;

    }
    return self;
}


- (void) cancelRequest {
    if (httRequest) {
        [httRequest clearDelegatesAndCancel];
//        [httRequest release],httRequest = nil;
    }
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    if (requestName) {
        self.delegate = _delegate;
        self.didFinish = _didFinish;
        self.didFail = _didFail;
        
        if(![ Reachability isConnected]){
            BOOL val = [[[NSUserDefaults standardUserDefaults] valueForKey:kNotFirstTime] boolValue];
            if(val){
                if(!isShown){
//                    [Common showAlertWithTitle:kNetWorkErrorTitle() message:kNetWorkErrorMessage() delegate:nil cancelButtonTitle:kOk() otherButtonTitles: nil];
                    isShown = YES;
                    NSLog(@"showing first time");
                }else{
                    NSLog(@"coming second time");
                }
                NSError * er = [[NSError alloc ] init];
                [self requestFailed:nil error:er];
                return;
            }
        }
        
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:requestParams];

        [mDic setValue:requestName forKey:kENTITY_NAME];
        [mDic setValue:@"0" forKey:kDEVICE_LOCALE];
        [mDic setValue:@"123" forKey:kDEVICE_ID];
        NSString *date = [AppSettings getPrefForKey:requestName];
        NSString *changed = [AppSettings getPrefForKey:[NSString stringWithFormat:@"%@%@",requestName,dpAppVersion]];
        if([changed isEqualToString:@"" ]) {
            date = @"";
        }
        [mDic setValue:date forKey:kUPDATED_DATE];
        [mDic setValue:@"2" forKey:@"osType"]; // 2 is for iOS
        [mDic setValue:dpAppVersion forKey:@"appVersion"]; //? Device Version
        
//        if ([requestName  isEqualToString:DP_SAVE_SETTINGS]) {
//
//        }
        
//        httRequest = [HTTPRequest requestWithURL:DP_SERVICE requestDictonary:mDic delegate:self didFinished:@selector(requestFinished:response:) didFailed:@selector(requestFailed:error:) userInfo:userInfo] ;
        
    }
    else {
        NSLog(@"NO Request Name Defined");
    }
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void) requestFinished:(HTTPRequest *)request response:(id)response {
    NSError *error = nil;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    if (jsonDic) {
        NSString *date = [jsonDic objectForKey:kSERVER_DATE];
        [AppSettings savePref:date ForKey:requestName];
        [AppSettings savePref:@"1" ForKey:[NSString stringWithFormat:@"%@%@",requestName,dpAppVersion]];
        responseStatusCode = [jsonDic objectForKey:kResponseCode];
        responseMessage = [jsonDic objectForKey:kResponseDesc];

        response = jsonDic;
        if ([responseStatusCode isEqualToString:@"1"]) {
            [self didReceiveResponse:jsonDic parsedResult:nil];
        }
        else {
            [self didReceiveFailed:[NSError errorWithDomain:responseMessage code:[responseStatusCode intValue] userInfo:nil]];
        }
        
        
    }
    else {
        [self didReceiveFailed:[NSError errorWithDomain:@"No Json response recieved" code:-1 userInfo:nil]];
    }

    
}



- (void) requestFailed:(HTTPRequest *)request error:(NSError*)error {
    [self didReceiveFailed:error];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {
    
    if ([delegate respondsToSelector:didFinish]) {
        [delegate performSelector:didFinish withObject:self withObject:object ];
    }
}

- (void) didReceiveFailed:(NSError*)error {
    if ([delegate respondsToSelector:didFail]) {
        NSLog(@"Error: %@ " , [error description]);
        [delegate performSelector:didFail withObject:self withObject:error];
    }
}


@end
