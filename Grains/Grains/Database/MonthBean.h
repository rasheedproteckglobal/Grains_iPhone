//
//  MonthBean.h
//  DubaiPolice
//
//  Created by Admin  on 12/23/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthBean : NSObject
{
    int days;
    NSString *monthName;
    int month;
    int year;
}

@property(nonatomic , assign)int days;
@property(nonatomic , strong)NSString *monthName;
@property(nonatomic , assign)int month;
@property(nonatomic , assign)int year;

@end
