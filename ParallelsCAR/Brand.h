//
//  Brand.h
//  ParallelsCAR
//
//  Created by tangchunhui on 15/3/5.
//  Copyright (c) 2015年 tangchunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Brand : NSManagedObject

@property (nonatomic, retain) NSString * ppdm;
@property (nonatomic, retain) NSString * ppmc;
@property (nonatomic, retain) NSString * ppszm;
@property (nonatomic, retain) NSDate * tapDate;
@property (nonatomic, retain) NSString * xhdm;
@property (nonatomic, retain) NSString * xhmc;
@property (nonatomic, retain) NSNumber * carcount;

@end
