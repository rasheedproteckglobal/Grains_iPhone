//
//  News.h
//  DubaiPolice
//
//  Created by Advansoft on 2/12/14.
//  Copyright (c) 2014 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface News : NSManagedObject

@property (nonatomic, retain) NSString * articleDate;
@property (nonatomic, retain) NSString * bodyAR;
@property (nonatomic, retain) NSString * bodyEN;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * imagePathAR;
@property (nonatomic, retain) NSString * imagePathEN;
@property (nonatomic, retain) NSNumber * newsID;
@property (nonatomic, retain) NSString * summaryAR;
@property (nonatomic, retain) NSString * summaryEN;
@property (nonatomic, retain) NSString * titleAR;
@property (nonatomic, retain) NSString * titleEN;
@property (nonatomic, retain) NSString * urlAR;
@property (nonatomic, retain) NSString * urlEN;

@end
