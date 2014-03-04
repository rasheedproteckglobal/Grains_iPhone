//
//  ImageCommon.m
//  GMCadallic
//
//  Created by Muhammad Baqir on 5/8/12.
//  Copyright (c) 2012 Advansoft. All rights reserved.
//

#import "ImageCommon.h"
#define kImagesFolder @"ImagesFolder"

@implementation ImageCommon

+ (NSString*) getImagesDocumentPath {   
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); 
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:kImagesFolder]];
    if (![[NSFileManager defaultManager]fileExistsAtPath:path]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/"]];
    return path;
}

+ (UIImage*) getImage:(NSString*)imageName {
    //imageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *path = [ImageCommon getImagesDocumentPath];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:kImages]];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        return [UIImage imageWithContentsOfFile:path];
    }
    return nil;
}

+ (BOOL)saveImage:(UIImage*)image withName:(NSString*)imageName {
    //imageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *path = [ImageCommon getImagesDocumentPath];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:kImages]];
    if (![[NSFileManager defaultManager]fileExistsAtPath:path]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];
    return [UIImagePNGRepresentation(image) writeToFile:path atomically:NO];  
}

+ (BOOL)deleteImage:(NSString*)imageName {
//    imageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
//    imageName = [imageName stringByReplacingOccurrencesOfString:@"*" withString:@"_"];
//    imageName = [imageName stringByReplacingOccurrencesOfString:@"?" withString:@"_"];
    NSString *path = [ImageCommon getImagesDocumentPath];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];
    if ([[NSFileManager defaultManager]isDeletableFileAtPath:path]) {
        NSError *error = nil;
        [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
        return YES;
    }
    return NO;
}

@end
