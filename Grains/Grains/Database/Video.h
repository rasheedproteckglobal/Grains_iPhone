//
//  Video.h
//  DubaiPolice
//
//  Created by Admin  on 12/18/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Video : NSManagedObject

@property (nonatomic, retain) NSString * videoId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * thumbnailUrl;
@property (nonatomic, retain) NSDate * uploaded;
@property (nonatomic, retain) NSNumber * viewCount;
@property (nonatomic, retain) NSNumber * duration;


@end
