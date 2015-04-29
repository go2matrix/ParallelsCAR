//
//  ModalCarList.h
//  ParallelsCAR
//
//  Created by tangchunhui on 15/2/11.
//  Copyright (c) 2015年 tangchunhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModal.h"


@interface ModalCarList : DataModalBasic<DataModalProtocol>
@property (nonatomic,strong)NSString *keyword;
@property (nonatomic,strong)NSString *wgys;
@property (nonatomic,strong)NSString *nsys;
@property (nonatomic,strong)NSString *cyzt;
@property (nonatomic,strong)NSString *cyszd;
@property (nonatomic,strong)NSString *xhdm;

@property (nonatomic,strong)NSNumber *page;
-(id)initWithKeyword:(NSString *)keyword wgys:(NSString *)wgys nsys:(NSString *)nsys cyzt:(NSString *)cyzt
               cyszd:(NSString *)cyszd xhdm:(NSString *)xhdm page:(NSNumber *)page;

@end
