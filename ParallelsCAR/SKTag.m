//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTag.h"

@implementation SKTag

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        _text          = text;
        self.font  = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        self.textColor = [UIColor blackColor];
        self.bgColor   = [UIColor whiteColor];
        self.selected = NO;
    }
    
    return self;
}

+ (instancetype)tagWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}

@end