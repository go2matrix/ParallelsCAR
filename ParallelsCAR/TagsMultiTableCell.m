//
//  TagsTableCell.m
//  WrapViewWithAutolayout
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015年 shiweifu. All rights reserved.
//

#import "TagsTableCell.h"
#import "SKTagView.h"
#import "SKTag.h"
#import "SKTagButton.h"
#import <HexColors/HexColor.h>


#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define NORMALCOLOR [UIColor colorWithHexString:@"#FFFFFF"]
#define NormalLTextColor [UIColor colorWithHexString:@"#43b0e6"]
#define HIGHCOLOR [UIColor colorWithHexString:@"#43b0e6"]
#define HighTextColor [UIColor colorWithHexString:@"#FFFFFF"]

@implementation TagsTableCell

- (void)awakeFromNib {
    // Initialization code
    self.value =@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(BOOL) isTheSameColor2:(UIColor*)color1 anotherColor:(UIColor*)color2
{
    if (CGColorEqualToColor(color1.CGColor, color2.CGColor)) {
        return YES;
    }else {
        return NO;
    }
}
-(NSString *)setHigh:(NSString *)value{
    NSUInteger index;
    for (SKTag  *tag in self.tagView.tags) {
        index = [self.tagView.tags indexOfObject:tag];
        SKTagButton *view = [[self.tagView subviews]objectAtIndex:index];
        if ([tag.text isEqualToString:value]){
            tag.selected = YES;
            [view setTitleColor:HighTextColor forState:UIControlStateNormal];
            view.backgroundColor = HIGHCOLOR;
            self.value = value;
        } else {
            [view setTitleColor:NormalLTextColor forState:UIControlStateNormal];
            tag.selected = NO;
            view.backgroundColor = NORMALCOLOR;
        }
    }
    if ([self.value isEqualToString:value]){
        return value;
    }else {
        return @"";
    }
}

-(void) setTags:(NSArray *)list{
    NSLog(@"%f",self.tagView.frame.size.width);
    self.tagView.preferredMaxLayoutWidth = 224;
    self.tagView.padding    = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tagView.insets    = 10;
    self.tagView.lineSpace = 5;
    self.tagView.singleLine =NO;
    
    [self.tagView removeAllTags];
    
    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = NormalLTextColor;
         tag.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
         tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
         tag.bgColor = [UIColor colorWithHexString:@"#FFFFFF"];
         tag.cornerRadius = 2;
         tag.selected = NO;
         
         [self.tagView addTag:tag];
     }];
    self.tagView.didClickTagAtIndex = ^(NSUInteger index){
        SKTag *tag= [self.tagView.tags objectAtIndex:index];
        SKTagButton *view = [[self.tagView subviews]objectAtIndex:index];
        
        
        if (!tag.selected) {
            for (SKTag *tag1 in self.tagView.tags) {
                tag1.selected = NO;
            }
            for (SKTagButton  *view1 in self.tagView.subviews) {
                [view1 setTitleColor:NormalLTextColor forState:UIControlStateNormal];
                view1.backgroundColor = NORMALCOLOR;
            }
            tag.selected = YES;
            view.backgroundColor = HIGHCOLOR;
            [view setTitleColor:HighTextColor forState:UIControlStateNormal];
            self.value = tag.text;
            
        }
    };

}
@end
