//
//  MenuCell.m
//
//  Created by Muhammad Mosib Asad on 10/7/13.
//  Copyright (c) 2013 Muhammad Mosib Asad. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize labelMenuName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

+ (id) createCell {    
    MenuCell *cell = nil;
    cell = [Common loadNibName:@"MenuCell" owner:self options:nil];
    cell.selectedBackgroundView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectedSideMenu.png"]];
    cell.labelMenuName.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
 