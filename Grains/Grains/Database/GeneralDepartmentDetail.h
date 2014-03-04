//
//  GeneralDepartmentDetail.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GeneralDepartmentDetail : NSManagedObject

@property (nonatomic, retain) NSString * descriptionEN;
@property (nonatomic, retain) NSString * titleEN;
@property (nonatomic, retain) NSString * descriptionAR;
@property (nonatomic, retain) NSString * titleAR;
@property (nonatomic, retain) NSString * titleType;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSManagedObject *department;

@end
