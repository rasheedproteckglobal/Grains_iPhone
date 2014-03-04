//
//  GeneralDepartment.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GeneralDepartmentDetail.h"

//@class GeneralDepartmentDetail;

@interface GeneralDepartment : NSManagedObject

@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * nameEN;
@property (nonatomic, retain) NSString * nameAR;
@property (nonatomic, retain) NSString * policeStation;
@property (nonatomic, retain) NSString * voiceKeyEN;
@property (nonatomic, retain) NSString * voiceKeyAR;
@property (nonatomic, retain) NSString * shortNameAR;
@property (nonatomic, retain) NSString * shortNameEN;
@property (nonatomic, retain) NSString * streetEN;
@property (nonatomic, retain) NSString * streetAR;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * departmentID;
//@property (nonatomic, retain) GeneralDepartmentDetail * departmentDetails;
@property (nonatomic, retain) NSSet *departmentDetails;
@end

@interface GeneralDepartment (CoreDataGeneratedAccessors)

- (void)addDepartmentDetailsObject:(GeneralDepartmentDetail *)value;
- (void)removeDepartmentDetailsObject:(GeneralDepartmentDetail *)value;
- (void)addDepartmentDetails:(NSSet *)values;
- (void)removeDepartmentDetails:(NSSet *)values;

@end
