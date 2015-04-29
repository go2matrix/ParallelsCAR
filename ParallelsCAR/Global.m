//
//  Global.m
//  CarCollection2
//
//  Created by tangchunhui on 14/12/20.
//  Copyright (c) 2014年 go2matrix.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Global.h"
#import "MBProgressHUD.h"
@implementation Global

+ (Global *)instance  {
    static Global *instance;
    
    @synchronized(self) {
        if(!instance) {
            instance = [[Global alloc] init];
        }
    }
    return instance;
}
-(void)showMessageDelay:(NSString *)message
{
    
    UIWindow *window  = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD1 = [[MBProgressHUD alloc ]initWithView:window ];
    
    //hud显示需要在主线程完成
    dispatch_sync(dispatch_get_main_queue(), ^{
      HUD1.mode = MBProgressHUDModeCustomView;
      HUD1.labelText = message;
      HUD1.delegate = self;
      HUD1.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notice.png"]];
      [window addSubview:HUD1];
      [HUD1 show:YES];
      [HUD1 hide:YES afterDelay:2.0f];
    });
    
    
}
#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hud removeFromSuperview];
    hud = nil;
}

@end
