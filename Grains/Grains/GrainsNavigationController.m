//
//  DPNavigationController.m
//  Grains
//
//  Created by Muhammad Mosib Asad on 12/10/13.
//  Copyright (c) 2013 Muhammad Mosib Asad. All rights reserved.
//

#import "GrainsNavigationController.h"
#import "DPFooter.h"
#import "Constants.h"
#import "ChangeViewController.h"

@interface GrainsNavigationController ()

@end

@implementation GrainsNavigationController
@synthesize userLocation;
@synthesize locationManager;

static GrainsNavigationController *navController = nil;
static DPFooter *footer = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    navController = self;
    [self addFooter];
    [self loadInitialData];
    [self getLocation];
    
}

-(void) loadInitialData{
    
//    [self fetchFeedsFromServer]; // No Response on delegate TOO!

}

//-(void)fetchFeedsFromServer{
//    GrainsFeeds *request = [[GrainsFeeds alloc ] init];
//    [request makeRequest:self finishSel:Nil failSel:nil];
//}



//- (void)requestRecieved:(GrainsRequest *)request withResponse:(id)response {
//        [Common hideLoader];
//}
//
//
//- (void)requestFailed:(GrainsRequest *)request withResponse:(id)response {
//        [Common hideLoader];
//
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

+ (UIStoryboard*) storyboard  {
    
    return navController.storyboard;
}



+ (GrainsNavigationController*) navController  {

    return navController;
}

+ (DPFooter*) footer  {
    
    return footer;
}

- (void) addFooter {
    footer = [Common loadNibName:@"DPFooter" owner:self options:nil];
    CGRect frame = footer.frame;
    frame.origin.y = self.view.frame.size.height - footer.frame.size.height;
    footer.frame = frame;
}

#pragma mark -
#pragma mark Actions

- (IBAction)actionHome:(id)sender {
    [self popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter ] postNotificationName:kNotificationHomePressed object:nil userInfo:nil];
}


-(void) menuItemClicked:(Master*)master{
    
    [ChangeViewController showSettingsViewController];
    [SlidingViewController closeMenu];
    
//    [[GrainsNavigationController navController] popToRootViewControllerAnimated:NO];
//    int masterId = [master.masterID intValue];
//    int type = [master.type intValue];
//    
//    if (type == TYPE_NATIVE) {
//        switch (masterId) {
//            case SIGNOUT:
//                [ChangeViewController showSignOutViewController];
//                break;

//            case SETTINGS:
//                [ChangeViewController showSettingsViewController];
//                break;
//            default:
//                break;
//        }
//    }
//    else{
//    }
}


-(void)stopLocation{
    [locationManager  stopUpdatingLocation];
}

-(void)getLocation{
    if(locationManager == nil){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    userLocation = newLocation;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [[NSNotificationCenter defaultCenter ] postNotificationName:kNotificationLocationUpdated object:locations userInfo:nil];
    userLocation = [locations lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [[NSNotificationCenter defaultCenter ] postNotificationName:kNotificationLocationFailed object:error userInfo:nil];
}

-(void)actionShare:(id)sender{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:kTitleShare() delegate:sender cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:kShareFacebook(),kShareTwitter(),kShareEmail(),kCancel(),nil];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Share" delegate:sender cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter",@"Email",@"Cancel",nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionSheet showInView:self.view ];
}
@end
