//
//  JYWindow.m
//  TTTabView
//
//  Created by Jerry.Yang on 2020/11/5.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "JYWindow.h"
#import "JYTabView.h"
@implementation JYWindow

-(void)awakeFromNib{
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setContentviewSize:) name:NSViewFrameDidChangeNotification object:nil];
}

-(void)setContentviewSize:(NSNotification *)notify{
    [self.contentView setFrame:self.contentView.frame];
}

@end
