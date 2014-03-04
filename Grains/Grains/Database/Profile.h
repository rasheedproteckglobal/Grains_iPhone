//
//  Profile.h
//  Grains
//
//  Created by Manu on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Profile : NSManagedObject


@property (nonatomic, retain) NSString * UserName;
@property (nonatomic, retain) NSString * Photo;
@property (nonatomic, retain) NSNumber * ProfileId;
@property (nonatomic, retain) NSNumber * FoodNotWastedCount;
@property (nonatomic, retain) NSNumber * LongestChain;
@property (nonatomic, retain) NSNumber * Followers;
@property (nonatomic, retain) bool * HasFollowed;
@property (nonatomic, retain) NSNumber * ResponseCode;

@end

