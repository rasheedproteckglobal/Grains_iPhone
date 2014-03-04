//
//  MenuCell.h
//  DubaiChamber
//
//  Created by Faizan Ali on 10/7/13.
//  Copyright (c) 2013 Dubai Chamber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell {

}

@property (nonatomic,weak) IBOutlet UILabel *labelMenuName;

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
+ (id) createCell;

@end
 