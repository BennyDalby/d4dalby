//
//  CustomGraphView.h
//  PoC Samples
//
//  Created by b.dalby.thoomkuzhy on 05/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNumberOfBars 12

@interface CustomGraphView : UIView<UIGestureRecognizerDelegate>
{
//    enum { GRAPH_VIEW_BAR, GRAPH_VIEW_LINE, GRAPH_VIEW_PIE };
    
    CGRect touchAreas[kNumberOfBars];
    UIImageView *legendImageView;
   // UIView  *labelView ;
   
    NSMutableArray *igIdLabels ;
   
}

@property   (nonatomic, assign) NSInteger           graphType;
@property   (nonatomic, assign) NSInteger            igButtonPressed ;
@property   (nonatomic, retain) NSArray             *dataLine1;
@property   (nonatomic, retain) NSArray             *dataLine2;
@property   (nonatomic, retain) NSMutableArray      *mActualDataValues;
@property   (nonatomic, retain) NSMutableArray      *mActualDataValuesNames;

@property   (nonatomic, retain) NSMutableArray      *dataBar1;
@property   (nonatomic, retain) NSMutableArray      *dataBar2;

@property   (nonatomic, retain) NSMutableArray      *xAxisLabels;
@property   (nonatomic, retain) NSMutableArray      *yAxisLeftLabels;
@property   (nonatomic, retain) NSMutableArray      *yAxisRightLabels;

@property   (nonatomic, assign) NSInteger           kStepX;
@property   (nonatomic, assign) NSInteger           kDefaultGraphWidth;


@property   (nonatomic, assign) NSInteger           kBarWidth;

@property   (nonatomic, assign) NSInteger           kOffsetX;

@property   (nonatomic, assign) NSInteger           kStepY;
@property   (nonatomic, assign) NSInteger           yRtStep;

@property   (nonatomic, assign) BOOL                isComparisionSet;

@property   (nonatomic, assign) float               TargetZeroValue; // Used if the target value is zero no need to show the target line


//@property   (nonatomic, retain) NSMutableArray      *dataPointActualValues;

@property   (nonatomic, assign) float               baseLineCoordinateValue;

-(void) displayLegend;
@end
