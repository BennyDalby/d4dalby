//
//  GraphViewUI.m
//  GraphViewUI
//
//  Created by b.dalby.thoomkuzhy on 9/5/13.
//  Copyright (c) 2013 praseeda.manissery. All rights reserved.
//

#import "GraphViewUI.h"



@implementation GraphViewUI

-(UIViewController*) Invoke:(NSArray *)dataPointArray LabelValueList:(NSArray *)LabelList {
   graphViewController = [[ViewController alloc] init];
    graphViewController.datavalueList=[[NSArray alloc]initWithArray:dataPointArray copyItems:YES];
    graphViewController.xaxisLabelList=[LabelList copy];
    
    NSLog(@"size of datavaluelist count is %d",[graphViewController.datavalueList count]);
    
    
   
    return graphViewController;
}



@end
