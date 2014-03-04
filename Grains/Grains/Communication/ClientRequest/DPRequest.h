//
//  DCCIRequest.h
//  DubaiChamber
//
//  Created by Faizan Ali on 10/8/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"

@protocol DPRequestDelegate <NSObject>
@end

//#define dpAppVersion @"And-1.3"
#define dpAppVersion @"iOS-1.0"

@interface DPRequest : NSObject  {
    
    SEL didFinish;
    SEL didFail;
    __weak id<DPRequestDelegate> delegate;
    HTTPRequest *httRequest;
    NSString *requestName;
    NSDictionary *requestParams;
    NSDictionary *userInfo;
    BOOL isFirstTime;
    BOOL responseSuccess;
    NSString *responseMessage;
    NSString *responseStatusCode;
    NSArray *keys;
    BOOL isShown;

}

@property (nonatomic,assign) SEL didFinish;
@property (nonatomic,assign) SEL didFail;
@property (nonatomic,weak) id<DPRequestDelegate> delegate;
@property (nonatomic,strong) NSString *requestName;
@property (nonatomic,strong) NSDictionary *requestParams;
@property (nonatomic,strong) NSDictionary *userInfo;
@property (nonatomic,readonly) BOOL responseSuccess;
@property (nonatomic,readonly) NSString *responseMessage;
@property (nonatomic,readonly) NSString *responseStatusCode;

- (void) cancelRequest;
- (void) makeRequest:(id)delegate finishSel:(SEL)didFinish failSel:(SEL)didFail;
- (void) didReceiveResponse:(id)response parsedResult:(id)object;
- (void) didReceiveFailed:(NSError*)error;


@end
