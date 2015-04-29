//
//  ModalCarList.m
//  ParallelsCAR
//
//  Created by tangchunhui on 15/2/11.
//  Copyright (c) 2015年 tangchunhui. All rights reserved.
//

#import "ModalCarList.h"
#import "ModalConstant.h"
#import "Global.h"

@implementation ModalCarList
/* C35.RQ.01.02 获得车型列表
   需要首先设置flag
   flag＝0 按代码搜索
   flag ＝1 按keyword搜索
 */
#pragma mark datamodal Codedate
-(id)initWithKeyword:(NSString *)keyword wgys:(NSString *)wgys nsys:(NSString *)nsys cyzt:(NSString *)cyzt
               cyszd:(NSString *)cyszd xhdm:(NSString *)xhdm page:(NSNumber *)page
{
    if (self = [super init]){
        self.keyword = keyword;
        self.wgys = wgys;
        self.nsys = nsys;
        self.cyzt = cyzt;
        self.cyszd = cyszd;
        self.xhdm = xhdm;
        self.page = page;
    }
    return  self;
}

-(NSDictionary *)modalUrl{
    NSString *tn;
    NSString *pageString=[NSString stringWithFormat:@"%i",[self.page intValue] ];
    
    NSDictionary *data1;
    tn=@"C35.RQ.01.09";
    data1 = @{@"keyword":self.keyword,@"wgys":self.wgys,@"nsys":self.nsys,@"cyzt":self.cyzt,@"cyszd":self.cyszd,
              @"xhdm":self.xhdm,@"rowsperpage":@"10",@"pagetype":@"2",@"pageno":pageString};

    NSString  *url=[NSString  stringWithFormat:@"%@/pxqcwapp/debug/AppMainServlet.ap",[Global host]];
    NSDictionary *dic = @{@"url":url,
                          @"method":@"POST",
                          @"tn":tn,
                          @"postdata":data1
                         };
    return dic;
}


-(void)processSuccess:(NSDictionary *)results {
    
}


@end
