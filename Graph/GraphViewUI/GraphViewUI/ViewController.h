//
//  ViewController.h
//  GraphView
//
//  Created by b.dalby.thoomkuzhy on 9/2/13.
//  Copyright (c) 2013 b.dalby.thoomkuzhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomGraphView.h"
#import "BOContainerGraphView.h"

@interface ViewController : UIViewController
{

    UIScrollView                *graphScrollContainer;
    CustomGraphView             *barGraphView;
    UIButton                    *lineGraph,*barGraph    ;

IBOutlet BOContainerGraphView        *containerGraphRootView;
    CGRect                      pGraphScrollFrame;

    IBOutlet UILabel *GraphLabel;
    
    NSMutableArray *datavalueList,*xaxisLabelList ;
}
-(void)loadGraphView:(int)tag ;


@property(nonatomic,retain) NSArray *datavalueList ;
@property(nonatomic,retain) NSArray *xaxisLabelList ;

@end
