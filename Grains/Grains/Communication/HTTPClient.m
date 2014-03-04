//
//  HttpClient.m
//  DIB
//
//  Created by Adnan Khan on 6/30/13.
//  Copyright (c) 2013 Faizan Ali. All rights reserved.
//

#import "HTTPClient.h"
#import "HTTPCommon.h"
#import "AFXMLRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "Url.h"

@implementation HTTPClient
@synthesize networkConnected;

+ (id)sharedHTTPClient
{
    static dispatch_once_t pred = 0;
    static id __httpClient = nil;
    dispatch_once(&pred, ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@" ,[HTTPCommon getBaseUrl]]];
        NSLog(@"%@",url);
        __httpClient = [[self alloc] initWithBaseURL:url];
    });
    return __httpClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    
    //for json client and response
    //[self setParameterEncoding:AFJSONParameterEncoding];
    //[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    [self setDefaultHeader:@"Accept" value:@"application/json"];
//    [self setDefaultHeader:@"dataType" value:@"application/json"];
//    [self setDefaultHeader:@"ResponseFormat" value:@"application/json"];
//    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
    [self setDefaultHeader:@"User-Agent" value:APP_USER_AGENT];

    //for XML client and response
    //[self registerHTTPOperationClass:[AFXMLRequestOperation class]];
//    [self setDefaultHeader:@"Accept" value:@"application/xml"];
//    [self setDefaultHeader:@"dataType" value:@"application/xml"];
//    [self setDefaultHeader:@"ResponseFormat" value:@"application/xml"];
//    [self setDefaultHeader:@"Content-Type" value:@"application/xml"];
//    [self setDefaultHeader:@"User-Agent" value:@"DIBApp"];
    
    //[self setDefaultHeader:@"Content-Type" value:@"soap+xml"];
     //[self setDefaultHeader:@"http://dcwebapps.dubaichamber.ae:8080/dcciws/services/Dcmobws?wsdl/authWithProfile" value:@"SOAPAction"];

//    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusNotReachable) {
//            // NOt Reachable
//            if(networkConnected !=false){
//                networkConnected =  FALSE;
//                [Common showAlertWithTitle:kNetWorkErrorTitle() message:kNetWorkErrorMessage() delegate:nil cancelButtonTitle:kOk() otherButtonTitles: nil];
//            }
//        } else {
//            // Reachable
//            networkConnected = TRUE;
//        }
//     
//    }];
    
    return self;
}

-(NSMutableURLRequest*)requestWithMethod:(NSString *)method
                                    path:(NSString *)path
                              parameters:(NSDictionary *)parameters
                                    data:(NSData*)data;
{
    NSMutableURLRequest* request = [super requestWithMethod:method
                                                       path:path
                                                 parameters:parameters];
    [request addValue:path forHTTPHeaderField:@"SOAPAction"];
    [request setHTTPBody:data];
    
    return request;
}



@end
