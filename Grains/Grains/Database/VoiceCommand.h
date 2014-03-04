//
//  VoiceCommand.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface VoiceCommand : NSManagedObject

@property (nonatomic, retain) NSNumber * masterID;
@property (nonatomic, retain) NSString * keyEN;
@property (nonatomic, retain) NSString * keyAR;

@end
