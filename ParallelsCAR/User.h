//
//  User.h
//  Pods
//
//  Created by tangchunhui on 15/3/3.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * md5str;
@property (nonatomic, retain) NSString * shid;
@property (nonatomic, retain) NSString * shmc;
@property (nonatomic, retain) NSString * shxxflag;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * usertype;
@property (nonatomic, retain) NSString * fbcy;
@property (nonatomic, retain) NSString * bjflag;
@property (nonatomic, retain) NSString * xjflag;

@end
