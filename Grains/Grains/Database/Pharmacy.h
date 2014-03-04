//
//  Pharmacy.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pharmacy : NSManagedObject

@property (nonatomic, retain) NSNumber * dayType;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * descriptionAR;
@property (nonatomic, retain) NSString * descriptionEN;
@property (nonatomic, retain) NSString * locationAR;
@property (nonatomic, retain) NSString * locationEN;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSNumber * pharmacyID;

@end
