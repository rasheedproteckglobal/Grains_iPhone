//
//  ImageRequest.h
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/8/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageRequest : NSObject {
    NSURL *url;
    NSDictionary *userInfo;
    NSString *imageName;
    UIImage *image;
    UIImageView *imageView;
    UIView *viewHolder; //To Hold View;
}

@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) NSDictionary *userInfo;
@property (nonatomic,retain) NSString *imageName;
@property (nonatomic,retain) UIImage *image;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIView *viewHolder;

- (id) initWithUrl:(NSURL*)_url userInfo:(NSDictionary*)_userInfo imageName:(NSString*)_imageName;

@end
