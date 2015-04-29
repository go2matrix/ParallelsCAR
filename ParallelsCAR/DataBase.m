//
//  Database.m
//  ybdoc
//
//  Created by go2matrix on 13-9-3.
//  Copyright (c) 2013年 go2matrix. All rights reserved.
//

#import "Database.h"
//指定model 的文件名
#define urlmodel URLForResource:@"Model" withExtension:@"mom"
//定义存储在document的数据库文件名
#define dbname @"car.db"
//定义存储在bundle中的文件名
#define sourceDBName pathForResource:@"car" ofType:@"db"
#define createBlankDB NO

@implementation Database
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (Database *)instance  {
    static Database *instance;
    
    @synchronized(self) {
        if(!instance) {
            instance = [[Database alloc] init];
        }
    }
    return instance;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] urlmodel];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:dbname];
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	// 检查数据库文件是否存在，如果不存在将缺省数据库复制过去，如果缺省数据库也不存在，则根据modal创建一个新的数据库
    if (([fileManager fileExistsAtPath:storePath])&&(createBlankDB)) {
        [fileManager removeItemAtURL:storeUrl error:NULL];
    }
    if ((![fileManager fileExistsAtPath:storePath])&&(!createBlankDB)) {
		NSString *defaultStorePath = [[NSBundle mainBundle] sourceDBName];
		if ([fileManager fileExistsAtPath:defaultStorePath]) {
			[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
		}
	}
	
	
	NSError *error;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    NSDictionary *options = @{NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}  //关闭wal模式
                              };
    
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
    
    return _persistentStoreCoordinator;
}



#pragma mark - Application's Documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


@end
