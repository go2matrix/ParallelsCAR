//
//  DataModal.m
//  myp1
//
//  Created by go2matrix on 13-10-29.
//  Copyright (c) 2013年 go2matrix. All rights reserved.
//

#import "DataModal.h"
#import "Database.h"
#import "Global.h"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"


@interface DataModal (){
    NSURLSession *_session;
}

@end
@implementation DataModal
#pragma mark -
#pragma mark 单例模式
+ (DataModal *)instance  {
    static DataModal *instance;
    
    @synchronized(self) {
        if(!instance) {
            instance = [[DataModal alloc] init];

        }
    }
    return instance;
}
-(id)init{
    if (self = [super init]){
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];


    }
    return self;
}
-(void)execute{
    if (!self.delegate){
        NSException *e = [NSException
                          exceptionWithName:@"无法执行modal"
                          reason:@"没有设置delegate"
                          userInfo:nil];
        @throw e;
        
    }
  @try {
    NSDictionary *dic = [self.delegate modalUrl:self];
    NSString *urlString = [dic valueForKey:@"url"];
    NSString *method =[dic valueForKey:@"method"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString ] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:method];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
//                NSRange range = NSMakeRange(0,[string length]-2);//去掉末尾的/r/n
//                NSData *backdata = [[string substringWithRange:range] dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error = nil;
                NSDictionary *results = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
                //json转换
                if (error) {
                    NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
                    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    
                    NSDictionary *dic = @{@"message":@"请求失败"};
                    SEL failSelector = sel_registerName("processFailed:");
                    if ([self.delegate respondsToSelector:failSelector]){
                        [self.delegate performSelector:failSelector withObject:dic];
                    }
                    return;
                }
                /*
                 初步解析返回的数据
                 */
              [self.delegate processSuccess:results  datamodal:self ] ;
                
                
                
                
                
            }
        } else {
             [[Global instance] showMessageDelay:@"请求失败"];
            
 
        }
        
    }];
    [dataTask resume];
  }
    @catch (NSException *exception)//捕获抛出的异常
    {
        [[Global instance] showMessageDelay:@"请求失败"];
        
        return;
    }
  
}

+(void) copyDictionary:(NSDictionary *)dict toItem:(NSObject *)object{
    NSArray *keys;
    NSInteger i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
        NSString *method =[NSString stringWithFormat:@"set%@:",[key capitalizedString]];
        SEL sel = NSSelectorFromString(method); // 指定action
        if ((value!=[NSNull null])&&([(NSObject *)object respondsToSelector:sel])){
            [(NSObject *)object performSelector:sel withObject:value];
        }
        
    }
}



#pragma mark 删除数据
-(void )deleteObject :(NSManagedObject *)object{
    [self.managedObjectContext  deleteObject:object];
    NSError *error;
    [self.managedObjectContext save:&error];
    

}
#pragma mark 执行数据库查询
-(void )deleteEntity :(NSString *)entityName  where:(NSString *)whereString{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // 设置表名
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    if (![whereString isEqualToString:@""]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:whereString];
        [fetchRequest setPredicate:predicate];
    }
    NSError *error;
    NSArray *array =  [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (int i=0;i<[array count];i++){
        [self.managedObjectContext  deleteObject:[array objectAtIndex:i]];
    }
    [self.managedObjectContext save:&error];
}

#pragma mark 执行数据库查询
-(NSArray *)queryData :(NSString *)entityName where:(NSString *)whereString{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // 设置表名
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    if (![whereString isEqualToString:@""]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:whereString];
        [fetchRequest setPredicate:predicate];
    }
    NSError *error;
    NSArray *array =  [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return array;
}
#pragma mark 执行数据库查询
-(NSArray *)queryData :(NSString *)entityName where:(NSString *)whereString order:(NSString *)order{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // 设置表名
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    if (![whereString isEqualToString:@""]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:whereString];
        [fetchRequest setPredicate:predicate];
    }
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:order ascending:NO];
    fetchRequest.sortDescriptors=@[sort];

    NSError *error;
    NSArray *array =  [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return array;
}


#pragma mark 新增一条数据库纪录
-(NSManagedObject *)createNewItem :(NSString *)entityName {
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName  inManagedObjectContext:self.managedObjectContext];
    return newManagedObject;
}

- (NSManagedObjectContext *)managedObjectContext{
    return [Database instance].managedObjectContext;
}

+(id) createDataModal:(NSString *)className{
    /*
    NSObject * c1 = [[NSClassFromString(className) alloc] init];
    if (!c1){
        NSString *msg =[ NSString stringWithFormat:@"创建数据模型失败,可能Build Phases中没有包含%@",className ];
        @throw([NSException exceptionWithName:msg reason:msg userInfo:nil]);
    }
    return c1;
     */
    return [[DataModal alloc] init];
}

@end
