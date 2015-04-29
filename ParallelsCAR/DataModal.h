//
//  DataModal.h
//  myp1
//
//  Created by go2matrix on 13-10-29.
//  Copyright (c) 2013年 go2matrix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DataModal;

@protocol  DataModalProtocol
-(NSDictionary *)modalUrl:(DataModal *)datamodal;
-(void)processSuccess:(NSDictionary *)results datamodal:(DataModal *)datamodal;
@end

@interface DataModal : NSObject<NSURLConnectionDelegate>

@property (nonatomic, weak) IBOutlet NSObject<DataModalProtocol>* delegate;
@property (nonatomic, weak) NSNumber *tag;

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
+ (DataModal *)instance;

-(void)execute;  //执行http请求
//执行查询
-(NSArray *)queryData :(NSString *)entityName where:(NSString *)whereString;
//执行查询
-(NSArray *)queryData :(NSString *)entityName where:(NSString *)whereString order:(NSString *)order;
//创建新纪录
-(NSManagedObject *)createNewItem :(NSString *)entityName;
//删除表内数据
-(void )deleteEntity :(NSString *)entityName  where:(NSString *)whereString;
//删除一条数据
-(void )deleteObject :(NSManagedObject *)object;



+(id) createDataModal:(NSString *)className;
+(void) copyDictionary:(NSDictionary *)dict toItem:(NSObject *)object;

@end

