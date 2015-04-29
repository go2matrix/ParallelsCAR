//
//  Global.h
//  CarCollection2
//
//  Created by tangchunhui on 14/12/20.
//  Copyright (c) 2014年 go2matrix.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface Global : NSObject<MBProgressHUDDelegate>
-(void)showMessageDelay:(NSString *)message;
+ (Global *)instance;

@end
