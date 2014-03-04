//
//  SideMenuController.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
//    NSMutableArray *menuItems;
//    NSMutableArray *sideMenuIconsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) updateTableViewCell;

@end
