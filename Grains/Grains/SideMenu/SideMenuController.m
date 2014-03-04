//
//  SideMenuController.m
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import "SideMenuController.h"
#import "MenuCell.h"
#import "DataManager.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "GrainsNavigationController.h"
#import "SlidingViewController.h"

@interface SideMenuController (){
    Master *master;
    NSArray *masterArray;
}

@end

@implementation SideMenuController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    [self.view bringSubviewToFront:self.tableView];
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, 15*40);
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_menu.png"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    [self getMenuItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableViewCell) name:kNotificationHomeReloaded object:nil];
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0]; // set to whatever you want to be selected first
//    [self.tableView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionTop];
}

-(void) updateTableViewCell{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionTop];
}


-(void) getMenuItem{
    masterArray = [[NSArray alloc] initWithObjects:@"Settings",@"SignOut",  nil]; //[[DataManager sharedInstance] getSideMenuItems];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [masterArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"MenuItemCell";
    MenuCell *cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [MenuCell createCell];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    master = [masterArray objectAtIndex:indexPath.row];

    cell.labelMenuName.text = [masterArray objectAtIndex:indexPath.row];//[master valueForKey:[AppSettings getLocalizedField:@"title"]];
    cell.labelMenuName.textColor = [UIColor whiteColor];
    // SET IMAGE
//    NSString *ImageURL = master.sideMenuIcon;
//    if (ImageURL) {
//        NSURL *url = [[NSURL alloc] initWithString:ImageURL];
//        [cell.cellImage setImageWithURL:url cache:YES];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    [self.tableView selectRowAtIndexPath:indexPath animated:NO  scrollPosition:UITableViewScrollPositionTop];
//
//    
//    Master *tempMaster = [masterArray objectAtIndex:indexPath.row];
//    [[GrainsNavigationController navController] menuItemClicked:tempMaster];
    [[GrainsNavigationController navController] menuItemClicked:Nil]; // For testing
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
