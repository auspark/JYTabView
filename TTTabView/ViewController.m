//
//  ViewController.m
//  TTTabView
//
//  Created by Jerry.Yang on 2020/11/4.
//  Copyright © 2020 Jerry.Yang. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLogBool(YES);
    NSLogObj(@"hello world");
    
}

-(void)awakeFromNib{
    JYTabView *tab = (JYTabView *)self.view;
    [tab newTabUnitWithTitle:@"tab 1"];
    [tab newTabUnitWithTitle:@"tab 2"];
    [tab newTabUnitWithTitle:@"tab 3"];
    [tab newTabUnitWithTitle:@"tab 4"];
    [tab newTabUnitWithTitle:@"tab 5"];
    [tab setFrontTab:0];
    
    NSTextField *tf =[[NSTextField alloc]initWithFrame:NSMakeRect(100, 30, 100, 25)];
    tf.stringValue=@"subviews";
    [tab addSubview:tf toUnit:2];
    
    NSTextField *tf1 =[[NSTextField alloc]initWithFrame:NSMakeRect(250, 30,100, 25)];
    tf1.stringValue=@"subviews-1";
    [tab addSubview:tf1 toUnit:0];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)addNewTab:(id)sender {
    JYTabView *tab = (JYTabView *)self.view;
    [tab clearAllUnit];
}
- (IBAction)newTab:(id)sender {
        JYTabView *tab = (JYTabView *)self.view;
    [tab newTabUnitWithDefaultTitle];
}

@end
