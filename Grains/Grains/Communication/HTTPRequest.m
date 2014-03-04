//
//  HTTPRequest.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 4/23/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "HTTPRequest.h"
#import "HTTPCommon.h"
#import "HttpClient.h"
#import "Reachability.h"



@implementation HTTPRequest
@synthesize client;
@synthesize requestDelegate;
@synthesize didFinish;
@synthesize didFail;
@synthesize requestName;
@synthesize responseDictonary;
@synthesize responseData;
@synthesize responseArray;
@synthesize xmlDocument;
NSTimer *timer;


+ (id) requestWithURL:(NSString *)path requestDictonary:(NSDictionary*)params withRequestData:(NSData*)data  delegate:(id)delegate didFinished:(SEL)finish didFailed:(SEL)failed userInfo:(NSDictionary*)userInfo {
    HTTPRequest * request = [[self alloc]init];
    request.client  = [HTTPClient sharedHTTPClient];
    NSMutableURLRequest *re = [request.client requestWithMethod:@"POST" path:path parameters:params data:data];
    
    AFHTTPRequestOperation *operation = [request.client HTTPRequestOperationWithRequest:re success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        [request performSelectorOnMainThread:@selector(reportSuccess:) withObject:responseObject waitUntilDone:NO];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
        [request performSelectorOnMainThread:@selector(reportFail:) withObject:error waitUntilDone:NO];
        
    }];
    [request setRequestDelegate:delegate];
    [request setDidFail:failed];
    [request setDidFinish:finish];
    [request setRequestName:path];
    [request.client enqueueHTTPRequestOperation:operation];
    
    
    
    return request;
}


+ (id) requestWithURL:(NSString *)path requestDictonary:(NSDictionary*)params delegate:(id)delegate didFinished:(SEL)finish didFailed:(SEL)failed userInfo:(NSDictionary*)userInfo {


    HTTPRequest * request = [[self alloc]init];
    request.client  = [HTTPClient sharedHTTPClient];
        
        
    [request.client postPath:path
                  parameters:params
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [request performSelectorOnMainThread:@selector(reportSuccess:) withObject:responseObject waitUntilDone:NO];
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"%@",error.description);
                         [request performSelectorOnMainThread:@selector(reportFail:) withObject:error waitUntilDone:NO];
                         
                     }];
    
    [request setRequestDelegate:delegate];
    [request setDidFail:failed];
    [request setDidFinish:finish];
    [request setRequestName:path];
    return request;
}


#pragma mark -
#pragma mark OverRide Methods


- (void)clearDelegatesAndCancel {
    [client cancelAllHTTPOperationsWithMethod:@"POST" path:requestName];
    [self setRequestDelegate:nil];
    [self setDidFail:nil];
    [self setDidFinish:nil];
}

#pragma mark -
#pragma mark Private Methods

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void) reportFail:(NSError*)error {
    
    NSLog(@"Error: %@ " , [error description]);

    if ([requestDelegate respondsToSelector:didFail]) {
        NSLog(@"Error: %@ " , [error description]);
        [requestDelegate performSelector:didFail withObject:self withObject:error];
//        [Common showAlertWithTitle:kNetWorkErrorTitle() message:kNetWorkErrorMessage() delegate:nil cancelButtonTitle:kOk() otherButtonTitles: nil];
    }
}

- (void) reportSuccess:(id)response {
    NSDictionary *dic = (id)response;
    if ([requestDelegate respondsToSelector:didFinish]) {
        [requestDelegate performSelector:didFinish withObject:self withObject:response];
    }
}

#pragma clang diagnostic pop

#pragma mark -
#pragma mark Public Methods


- (NSString*) getReqName {
    return requestName;
}

@end
