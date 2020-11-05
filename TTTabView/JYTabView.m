//
//  JYTabView.m
//  TTTabView
//
//  Created by Jerry.Yang on 2020/11/5.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "JYTabView.h"

@implementation JYTabHeaderLabel

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:dirtyRect.origin];
    [path lineToPoint:NSMakePoint(dirtyRect.origin.x, dirtyRect.origin.y+dirtyRect.size.height)];
    [path moveToPoint:dirtyRect.origin];
    [path lineToPoint:NSMakePoint(dirtyRect.origin.x+dirtyRect.size.width, dirtyRect.origin.y)];
    [path lineToPoint:NSMakePoint(dirtyRect.origin.x+dirtyRect.size.width, dirtyRect.origin.y+dirtyRect.size.height)];
    path.lineWidth=2;
    [[NSColor darkGrayColor]set];
    [path stroke];
    [self drawUnderLine:dirtyRect];
}

-(void)drawUnderLine:(NSRect)dirtyRect{
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(dirtyRect.origin.x+dirtyRect.size.width, dirtyRect.origin.y+dirtyRect.size.height)];
    [path lineToPoint:NSMakePoint(dirtyRect.origin.x, dirtyRect.origin.y+dirtyRect.size.height)];
    path.lineWidth=2;
    if (self.bFrontTab) {
        [[NSColor redColor]set];
    }else{
        [[NSColor darkGrayColor]set];
    }
    [path stroke];
}

-(id)initWithFrame:(NSRect)frameRect{
    if (self=[super initWithFrame:frameRect]) {
        self.bFrontTab=NO;
        self.backgroundColor=[NSColor lightGrayColor];
        self.editable=NO;
        self.bordered=YES;
        self.alignment=NSTextAlignmentCenter;
    }
    return self;
}

-(void)mouseDown:(NSEvent *)event{
    if (self.headerDelegate && [self.headerDelegate respondsToSelector:@selector(setFrontTab:)]) {
        [self.headerDelegate setFrontTab:self.tag];
    }
}

-(void)setDefaultBackgroundColor{
    self.backgroundColor=[NSColor lightGrayColor];
    self.needsDisplay=YES;
}

@end


@implementation JYTabView

-(id)initWithFrame:(NSRect)frameRect{
    if (self=[super initWithFrame:frameRect]) {
    }
    return self;
}

-(void)awakeFromNib{
    
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    if (self->firstHeader&&self->firstView) {
        NSRect rh=self->firstHeader.frame;
        NSRect rv=self->firstView.frame;
        NSBezierPath *path = [NSBezierPath bezierPath];
        [path moveToPoint:NSMakePoint(rh.origin.x, rh.origin.y)];
        [path lineToPoint:NSMakePoint(rv.origin.x, rv.origin.y+rv.size.height)];
        [[NSColor greenColor]set];
        path.lineWidth=2.0;
        [path stroke];
    }
}

-(void)newTabUnitWithTitle:(NSString *)title{
    if (self->headers==nil) {
        self->headers=[NSMutableArray array];
    }
    __block BOOL bHasTab=NO;
    [self->headers enumerateObjectsUsingBlock:^(JYTabHeaderLabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.stringValue isEqualToString:title]) {
            bHasTab=YES;
        }
    }];
    if (!bHasTab) {
        NSRect frame = NSMakeRect(self.frame.origin.x+self->headers.count*DefaultHeaderWidth, self.frame.size.height-DefaultHeaderHeight, DefaultHeaderWidth, DefaultHeaderHeight);
        JYTabHeaderLabel *thl = [[JYTabHeaderLabel alloc] initWithFrame:frame];
        thl.tag=self->headers.count;
        thl.stringValue=title;
        thl.headerDelegate=self;
        [self addSubview:thl];
        [self->headers addObject:thl];
        [self newBodyView];
    }
}

-(void)newBodyView{
    if (self->bodys==nil) {
        self->bodys=[NSMutableArray array];
    }
    NSRect bodyFrame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-DefaultHeaderHeight);
    NSView *body = [[NSView alloc]initWithFrame: bodyFrame];
    //tf just for test
    NSTextField *tf =[[NSTextField alloc]initWithFrame:NSMakeRect(400, self->bodys.count*30, 50, 25)];
    tf.integerValue=self->bodys.count;
    [body addSubview:tf];
    [self->bodys addObject:body];
}

-(void)setFrontTab:(NSInteger)index{
    if (self->firstHeader!=nil) {
        self->firstHeader.bFrontTab=NO;
        [self->firstHeader setDefaultBackgroundColor];
        self->firstHeader.needsDisplay=YES;
    }
    self->firstHeader=[self->headers objectAtIndex:index];
    self->firstHeader.bFrontTab=YES;
    self->firstHeader.backgroundColor=[NSColor colorWithRed:0.5 green:0.8 blue:1.0 alpha:0.5];
    self->firstHeader.needsDisplay=YES;
    if (self->firstView!=nil) {
        [self->firstView removeFromSuperview];
    }
    self->firstView=[self->bodys objectAtIndex:index];
    [(NSTextField *)[self->firstView subviews][0] setStringValue:self->firstHeader.stringValue];
    [self addSubview:self->firstView];
}

-(void)setFrame:(NSRect)frame{
    [super setFrame:frame];
    if (self->headers!=nil) {
        [self->headers enumerateObjectsUsingBlock:^(JYTabHeaderLabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame=NSMakeRect(self.frame.origin.x+idx*DefaultHeaderWidth, self.frame.size.height-DefaultHeaderHeight, DefaultHeaderWidth, DefaultHeaderHeight);
        }];
    }
    if (self->bodys!=nil) {
        [self->bodys enumerateObjectsUsingBlock:^(NSView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = NSMakeRect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-DefaultHeaderHeight);
        }];
    }
}

-(void)setTitle:(NSString *)title forIndex:(NSInteger)idx{
    if (idx<self->headers.count) {
        [[self->headers objectAtIndex:idx] setStringValue:title];
    }
}

-(void)clearAllUnit{
    if (self->headers!=nil) {
        [self->headers enumerateObjectsUsingBlock:^(JYTabHeaderLabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self->headers removeAllObjects];
    }
    if (self->bodys!=nil) {
        [self->bodys enumerateObjectsUsingBlock:^(NSView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self->bodys removeAllObjects];
    }
    self->firstView=nil;
    self->firstHeader=nil;
    self.needsDisplay=YES;
}

-(void)removeUnitAtIndex:(NSInteger)idx{
    if (idx<self->headers.count) {
        [self->headers removeObjectAtIndex:idx];
        [self->bodys removeObjectAtIndex:idx];
    }
}

-(void)addSubview:(NSView *)view toUnit:(NSInteger)idx{
    if (idx<self->bodys.count) {
        NSView *sv = [self->bodys objectAtIndex:idx];
        [sv addSubview:view];
    }
}

-(void)newTabUnitWithDefaultTitle{
    if (self->headers==nil) {
        self->headers=[NSMutableArray array];
    }
    [self newTabUnitWithTitle:[NSString stringWithFormat:@"tab %lu",self->headers.count+1]];
    [self setFrontTab:self->headers.count-1];
}

@end
