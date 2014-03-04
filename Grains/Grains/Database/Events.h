//
//  Events.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Events : NSManagedObject

@property (nonatomic, retain) NSDate * articleDate;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSNumber * eventsID;
@property (nonatomic, retain) NSString * summaryEN;
@property (nonatomic, retain) NSString * summaryAR;
@property (nonatomic, retain) NSString * titleEN;
@property (nonatomic, retain) NSString * titleAR;
@property (nonatomic, retain) NSString * imagePathEN;
@property (nonatomic, retain) NSString * imagePathAR;
@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * urlAR;
@property (nonatomic, retain) NSString * urlEN;


@end
