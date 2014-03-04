//
//  DPPharmacyRequest.m
//  DubaiPolice
//
//  Created by Advansoft on 12/22/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import "GrainsSignUp.h"
#import "Pharmacy.h"



@implementation GrainsSignUp

- (id)init {
    self = [super init];
    if (self) {
        
        self.requestName = Login;
        
    }
    return self;
}

- (void) makeRequest:(id)_delegate finishSel:(SEL)_didFinish failSel:(SEL)_didFail {
    
    if (![self updatePharmacyForNewData]) {
        return;
    }
    [super makeRequest:_delegate finishSel:_didFinish failSel:_didFail];
}

- (void) didReceiveResponse:(id)response parsedResult:(id)object {

    NSDictionary *dic = (id)response;
    responseMessage = [dic objectForKey:@"responseDesc"];
    NSArray *list  =  [dic objectForKey:@"listOfObjects"];
    
    [[DataManager sharedInstance] deleteEntity:DB_TABLE_PHARMACY];
    
    NSManagedObjectContext *context = [[DataManager sharedInstance] managedObjectContext];
    for (NSDictionary *obj in list) {
        Pharmacy *pharmacy = [NSEntityDescription
                              insertNewObjectForEntityForName:DB_TABLE_PHARMACY
                      inManagedObjectContext:context];
        
        pharmacy.descriptionAR = [obj objectForKey:@"descriptionAr"];
        pharmacy.descriptionEN = [obj objectForKey:@"description"];
        pharmacy.imagePath = [obj objectForKey:@"imagePath"];
        pharmacy.locationAR = [obj objectForKey:@"locationAr"];
        pharmacy.locationEN = [obj objectForKey:@"location"];
        pharmacy.number = [obj objectForKey:@"phone"];
        pharmacy.dayType = [NSNumber numberWithInt:[[obj objectForKey:@"listForDay"] intValue]];
        pharmacy.pharmacyID = [NSNumber numberWithInt:[[obj objectForKey:@"id"] intValue]];
}
    
    [[DataManager sharedInstance ] save];
    [super didReceiveResponse:response parsedResult:responseMessage];
}

-(BOOL) updatePharmacyForNewData{
    // Today's Date
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale = twelveHourLocale;
    
    [dateFormatter setDateFormat:@"dd.MM.YY"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"%@",dateString);
    
    // Last loaded Data
    NSDate *lastLoadedDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastLoadedDate"];
    if(!lastLoadedDate){
        [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"LastLoadedDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return TRUE;
    }
    
    // difference in date
    NSTimeInterval distanceBetweenDates = [currentDate timeIntervalSinceDate:lastLoadedDate];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    if (hoursBetweenDates > 23) {
        return TRUE;
    }
    
    return false;
}


@end
