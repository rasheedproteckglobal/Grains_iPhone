//
//  UserProfileSettings.h
//  Grains
//
//  Created by TCI on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserProfileSettings : NSManagedObject

@property (nonatomic, retain) NSNumber * responseCode;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSNumber * smType;

@end
