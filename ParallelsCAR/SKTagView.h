//
//  SKTagView.h
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTag;
@class SKTagView;
@protocol SKTagDelegate <NSObject>
-(void)didClickTag:(SKTagView *)tagView;
@end
@interface SKTagView : UIView

@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) int lineSpace;
@property (nonatomic) CGFloat insets;
@property (nonatomic) CGFloat preferredMaxLayoutWidth;
@property (nonatomic) BOOL singleLine;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) id<SKTagDelegate> delegate;

- (void)addTag:(SKTag *)tag;
- (void)insertTag:(SKTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag:(SKTag *)tag;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeAllTags;

@property (nonatomic, copy) void (^didClickTagAtIndex)(NSUInteger index);

@end

