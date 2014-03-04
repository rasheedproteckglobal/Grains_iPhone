//
//  Feeds.h
//  Grains
//
//  Created by Manu on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Feeds : NSManagedObject


@property (nonatomic, retain) NSNumber * FeedId;
@property (nonatomic, retain) NSNumber * FeedTypeId;
@property (nonatomic, retain) NSString * UserPhoto;
@property (nonatomic, retain) NSNumber * ProfileId;
@property (nonatomic, retain) NSString * UserName;
@property (nonatomic, retain) NSString * FeedPhoto;
@property (nonatomic, retain) NSNumber * FeedMasterId;
@property (nonatomic, retain) NSString * FeedContent;
@property (nonatomic, retain) NSString * Location;
@property (nonatomic, retain) NSDate * FeedDate;
@property (nonatomic, retain) NSNumber * TotalLikes;
@property (nonatomic, retain) NSNumber * TotalComments;
@property (nonatomic, retain) BOOL * IsLikedBy;

@end

