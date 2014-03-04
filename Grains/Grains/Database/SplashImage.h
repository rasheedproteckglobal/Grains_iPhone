//
//  SplashImage.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SplashImage : NSManagedObject

@property (nonatomic, retain) NSNumber * splashID;
@property (nonatomic, retain) NSString * imagePath;

@end
