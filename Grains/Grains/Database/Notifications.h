//
//  Notifications.h
//  DubaiPolice
//
//  Created by Admin  on 12/31/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Notifications : NSManagedObject
{}

@property (nonatomic, retain) NSString *notificationId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *type;


@end
