//
//  CallUs.h
//  DubaiPolice
//
//  Created by Muhammad Mosib Asad on 12/10/13.
//  Copyright (c) 2013 Muhammad Mosib Asad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CallUs : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSNumber * linkToCall;
@property (nonatomic, retain) NSString * titleEN;
@property (nonatomic, retain) NSString * titleAR;
@property (nonatomic, retain) NSString * voiceKeyEN;
@property (nonatomic, retain) NSString * voiceKeyAR;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * infoEN;
@property (nonatomic, retain) NSString * infoAR;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * callID;

@end
