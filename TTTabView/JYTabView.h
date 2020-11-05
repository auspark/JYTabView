//
//  JYTabView.h
//  TTTabView
//
//  Created by Jerry.Yang on 2020/11/5.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DefineMacros.h"
#define DefaultHeaderHeight 20
#define DefaultHeaderWidth 90

@protocol JYTabHeaderLabelDelegate <NSObject>
-(void)setFrontTab:(NSInteger)index;
@end

@interface JYTabHeaderLabel : NSTextField
@property(readwrite) BOOL bFrontTab;
@property(nonatomic) id<JYTabHeaderLabelDelegate> headerDelegate;
-(void)setDefaultBackgroundColor;
@end

@interface JYTabView : NSView<JYTabHeaderLabelDelegate>
{
    NSMutableArray *headers;
    NSMutableArray *bodys;
    JYTabHeaderLabel *firstHeader;
    NSView *firstView;
}
-(void)newTabUnitWithTitle:(NSString *)title;

-(void)setTitle:(NSString *)title forIndex:(NSInteger)idx;
-(void)clearAllUnit;
-(void)removeUnitAtIndex:(NSInteger)idx;

-(void)addSubview:(NSView *)view toUnit:(NSInteger)idx;
-(void)newTabUnitWithDefaultTitle;
@end
