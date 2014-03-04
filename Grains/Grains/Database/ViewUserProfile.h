//
//  ViewUserProfile.h
//  Grains
//
//  Created by TCI on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ViewUserProfile : NSManagedObject

@property (nonatomic, retain) NSNumber * responseCode;
@property (nonatomic, retain) NSNumber * profileID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSNumber * foodNotWastedDayCount;
@property (nonatomic, retain) NSNumber * longestChain;
@property (nonatomic, retain) NSNumber * followers;
@property (nonatomic, retain) bool * hasFollowed;

@end
