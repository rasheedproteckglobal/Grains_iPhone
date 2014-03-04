//
//  DPNavigationController.h
//  DubaiPolice
//
//  Created by Muhammad Mosib Asad on 12/10/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Master.h"
#import <CoreLocation/CoreLocation.h>

#import "DPFooter.h"

@interface GrainsNavigationController : UINavigationController <CLLocationManagerDelegate>{
    
    CLLocationManager *locationManager;
    CLLocation *userLocation;

}

@property(nonatomic,readonly,strong) CLLocationManager *locationManager;
@property(nonatomic,readonly,strong) CLLocation *userLocation;

+ (GrainsNavigationController*) navController;
+ (DPFooter*) footer;
+ (UIStoryboard*) storyboard;
-(void) menuItemClicked:(Master*) master;
-(void)actionShare:(id)sender;
-(void)loadInitialData;
-(void)stopLocation;
-(void)getLocation;

@end
