//
//  ImageDownload.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/8/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "ImageDownload.h"
#import "AFImageRequestOperation.h"
#import "ImageRequest.h"
#import "ImageCommon.h"

#define kImageImageRequest @"ImageRequest"

@interface ImageRequest()

- (void) finishDownloading;
- (void) startRequests;

@end

@implementation ImageDownload 
@synthesize delegate;
@synthesize didFinish;
@synthesize didFail;
@synthesize cache;
@synthesize imageRequests;


+ (ImageDownload*)sharedInstance {
	static dispatch_once_t pred;
	static ImageDownload *sharedInstance = nil;
    
	dispatch_once(&pred, ^{ 
        sharedInstance = [[self alloc] init]; 
    });
	return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
//        netWorkQueue = [[ASINetworkQueue alloc]init];
//        [netWorkQueue setDelegate:self];
//        [netWorkQueue setRequestDidFinishSelector:@selector(requestCompleted:)];
//        [netWorkQueue setRequestDidFailSelector:@selector(requestFailed:)];
    }
    return self;
}


- (void) dealloc {
    [imageRequests release];
    [super dealloc];
}


//- (void)requestCompleted:(ASIHTTPRequest *)response {
//    
//    int statusCode  = [response responseStatusCode];
//    if (statusCode == 200) {
//        ImageRequest *imageRequest = [[response userInfo]objectForKey:kImageImageRequest];
//        UIImage *image = [UIImage imageWithData:[response responseData]];
//        imageRequest.image = image;
//        if (cache) {
//            [ImageCommon saveImage:image withName:imageRequest.imageName];
//
//        }
//        [self finishDownloading:imageRequest];
//    }
//    else {
//        if ([delegate respondsToSelector:didFail]) {
//            [self.delegate performSelector:didFail withObject:self];
//        }  
//    }
//    
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)response {
//    ImageRequest *imageRequest = [[response userInfo]objectForKey:kImageImageRequest];
//    if ([delegate respondsToSelector:didFail]) {
//        [self.delegate performSelector:didFail withObject:imageRequest];
//    }    
//}

#pragma mark -
#pragma mark category Methods

- (void) finishDownloading:(ImageRequest *)imageRequest {
    if (imageRequest.imageView) {
        [imageRequest.imageView setImage:imageRequest.image];
    }
    if ([delegate respondsToSelector:didFinish]) {
        [self.delegate performSelector:didFinish withObject:imageRequest];
    }   
}


#pragma mark -
#pragma mark Public Methods

- (void) clearDelegatesAndCancel {
    [self setDelegate:nil];
    [self setDidFail:nil];
    [self setDidFinish:nil];
    [AFImageRequestOperation cancelPreviousPerformRequestsWithTarget:self];
    
}

- (void) loadImage:(ImageRequest*)imageRequest withDelegate:(id)_delegate didFinished:(SEL)didFinishedSelector didFailed:(SEL)didFailedSelector cache:(BOOL)_cache {
    [self loadImages:[NSArray arrayWithObject:imageRequest] withDelegate:_delegate didFinished:didFinishedSelector didFailed:didFailedSelector cache:_cache];
}


- (void) displayImage:(UIImageView *)imageView ImageRequest:(ImageRequest*)imageRequest cache:(BOOL)_cache {
    imageRequest.imageView = imageView;
    [self loadImages:[NSArray arrayWithObject:imageRequest] withDelegate:nil didFinished:nil didFailed:nil cache:_cache];
}

- (void) displayImage:(UIImageView *)imageView ImageRequest:(ImageRequest*)imageRequest withDelegate:(id)_delegate didFinished:(SEL)didFinishedSelector didFailed:(SEL)didFailedSelector cache:(BOOL)_cache {
    imageRequest.imageView = imageView;
    [self loadImages:[NSArray arrayWithObject:imageRequest] withDelegate:_delegate didFinished:didFinishedSelector didFailed:didFailedSelector cache:_cache];
}

- (void) loadImages:(NSArray*)_imageRequests withDelegate:(id)_delegate didFinished:(SEL)didFinishedSelector didFailed:(SEL)didFailedSelector cache:(BOOL)_cache{
    int cacheCount = 0;
    self.imageRequests = _imageRequests;
    self.delegate = _delegate;
    self.didFail = didFailedSelector;
    self.didFinish = didFinishedSelector;
    self.cache  = _cache;
    
    for (ImageRequest *imageRequest in _imageRequests) {
        if (_cache) {
            UIImage *image = [ImageCommon getImage:imageRequest.imageName];
            if (image) {
                cacheCount++;
                imageRequest.image = image;
                if (cacheCount == [_imageRequests count]) {
                    [self finishDownloading:imageRequest];
                }
                continue;
            }
        }
        AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:imageRequest.url] imageProcessingBlock:nil
                                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                              imageRequest.image = image;
                                                              if (cache) {
                                                                  [ImageCommon saveImage:image withName:imageRequest.imageName];
                                                                  
                                                              }
                                                              [self finishDownloading:imageRequest];
                                                          }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                              if ([delegate respondsToSelector:didFail]) {
                                                                  [self.delegate performSelector:didFail withObject:imageRequest];
                                                              }
                                                          }];
        [operation start];

    }
}

@end
