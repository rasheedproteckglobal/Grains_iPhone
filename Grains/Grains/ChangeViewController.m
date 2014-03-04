//
//  ChangeViewController.m
//  DubaiPolice
//
//  Created by Advansoft on 12/23/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import "ChangeViewController.h"
#import "GrainsNavigationController.h"
@interface ChangeViewController ()

@end

@implementation ChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}



+(void) showSettingsViewController{
    UIViewController *newTopViewController = [[GrainsNavigationController storyboard] instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [[GrainsNavigationController navController] pushViewController:newTopViewController animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
