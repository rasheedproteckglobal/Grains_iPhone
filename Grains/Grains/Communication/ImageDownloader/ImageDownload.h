//
//  ImageDownload.h
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/8/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageRequest.h"

@class ImageDownload;
@class ImageRequest;

@protocol  ImageDownloadDelegate <NSObject>;

@optional

- (void)imageDownloaded:(ImageRequest *)imageRequest;
- (void)imageDownloadedFailed:(ImageRequest *)imageRequest;

@end

@interface ImageDownload : NSObject {
    id<ImageDownloadDelegate> delegate;
    SEL didFinish;
    SEL didFail; 
    BOOL cache;
    NSArray *imageRequests;
}

@property (nonatomic,assign) SEL didFinish;
@property (nonatomic,assign) SEL didFail;
@property (nonatomic,assign) id<ImageDownloadDelegate> delegate;
@property (nonatomic,assign) BOOL cache;
@property (nonatomic,retain) NSArray *imageRequests;

+ (ImageDownload*)sharedInstance;

- (void) clearDelegatesAndCancel;
- (void) loadImage:(ImageRequest*)imageRequest withDelegate:(id)delegate didFinished:(SEL)didFinishedSelector didFailed:(SEL)didFailedSelector cache:(BOOL)cache;
- (void) loadImages:(NSArray*)imageRequests withDelegate:(id)delegate didFinished:(SEL)didFinishedSelector didFailed:(SEL)didFailedSelector cache:(BOOL)cache; //Array Of
- (void) displayImage:(UIImageView *)imageView ImageRequest:(ImageRequest*)imageRequest withDelegate:(id)_delegate didFinished:(SEL)didFinishedSelector didFailed:(SEL)didFailedSelector cache:(BOOL)_cache;
- (void) displayImage:(UIImageView *)imageView ImageRequest:(ImageRequest*)imageRequest cache:(BOOL)_cache;


@end
