//
//  Trends.h
//  Grains
//
//  Created by TCI on 3/4/14.
//  Copyright (c) 2014 Change Initiative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Trends : NSManagedObject

@property (nonatomic, retain) NSNumber * foodSavedDaysCount;
@property (nonatomic, retain) NSNumber * totalTrackedDays;
@property (nonatomic, retain) NSNumber * accuracyPercent;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSNumber * responseCode;

@end
