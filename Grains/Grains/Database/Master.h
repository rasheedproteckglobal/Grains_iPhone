//
//  Master.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Master : NSManagedObject

@property (nonatomic, retain) NSNumber * masterID;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * menuIcon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * parentId;
@property (nonatomic, retain) NSNumber * isCached;
@property (nonatomic, retain) NSDate * updatedDate;
@property (nonatomic, retain) NSString * titleEN;
@property (nonatomic, retain) NSString * titleAR;
@property (nonatomic, retain) NSNumber * isSideMenu;
@property (nonatomic, retain) NSNumber * isSideMenuIcon;
@property (nonatomic, retain) NSNumber * isSideMenuOrder;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * serviceDescEN;
@property (nonatomic, retain) NSString * serviceDescAR;
@property (nonatomic, retain) NSString * urlEN;
@property (nonatomic, retain) NSString * urlAR;
@property (nonatomic, retain) NSString * sideMenuIcon;
@property (nonatomic, retain) NSString * vcKeywordEN;
@property (nonatomic, retain) NSString * vcKeywordAR;
@property (nonatomic, retain) NSNumber * isActive;

@end
