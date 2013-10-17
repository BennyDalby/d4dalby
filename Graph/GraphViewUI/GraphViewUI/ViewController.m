//
//  ViewController.m
//  GraphView
//
//  Created by b.dalby.thoomkuzhy on 9/2/13.
//  Copyright (c) 2013 b.dalby.thoomkuzhy. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
#define GRAPHVIEW_EXTRA_WIDTH_FOR_LEGENDS_DISPLAY 0
#define GRAPHVIEW_MIN_WIDTH 300

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    containerGraphRootView=[[BOContainerGraphView alloc]initWithFrame:CGRectMake(10, 20, 300, 370)];
    
    barGraphView.dataBar1=[[NSMutableArray alloc]init];
    
    
    datavalueList=[[NSMutableArray alloc]init];
    xaxisLabelList=[[NSMutableArray alloc]init];
        
  
    datavalueList=[self.datavalueList copy];
    
    NSLog(@"count here is %d",[datavalueList count]);
    xaxisLabelList=[self.xaxisLabelList copy];
    
    
    graphScrollContainer = [[UIScrollView alloc]initWithFrame:CGRectMake(60,0, 240,360)];
  graphScrollContainer.contentSize = CGSizeMake(350, 360);
    graphScrollContainer.backgroundColor = [UIColor colorWithRed:147/255.0 green:186/255.0 blue:213/255.0 alpha:1.0];

    containerGraphRootView.backgroundColor=[UIColor colorWithRed:147/255.0 green:186/255.0 blue:213/255.0 alpha:1.0];
    [containerGraphRootView addSubview:graphScrollContainer];
    //containerGraphRootView.yAxisName = @"yoyoy";
    [self.view addSubview:containerGraphRootView];
    
    barGraphView = [[CustomGraphView alloc]initWithFrame:CGRectMake(0,0, 950, 380)];
    barGraphView.backgroundColor = [UIColor colorWithRed:147/255.0 green:186/255.0 blue:213/255.0 alpha:1.0];
    [graphScrollContainer addSubview:barGraphView];
    
     
    
   CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:26/255.0 green:79/255.0 blue:138/255.0 alpha:1.0] CGColor],(id)[[UIColor colorWithRed:16/255.0 green:60/255.0 blue:120/255.0 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:3/255.0 green:40/255.0 blue:110/255.0 alpha:1.0] CGColor], nil];
    
   [self.view.layer insertSublayer:gradient atIndex:0];
    
    
    
    lineGraph = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lineGraph.frame=CGRectMake(10, 400, 144, 50);
    lineGraph.tag=0;
    //lineGraph.titleLabel.text=@"Line Graph" ;
     [lineGraph setTitle:@"Line Graph" forState:UIControlStateNormal];
    lineGraph.titleLabel.textColor=[UIColor colorWithRed:26/255.0 green:79/255.0 blue:138/255.0 alpha:1.0];
    
    [self.view addSubview:lineGraph];
    
    [lineGraph addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchDown];
    
    barGraph = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    barGraph.frame=CGRectMake(164, 400, 144, 50);
    barGraph.tag=1;

    [barGraph setTitle:@"Bar Graph" forState:UIControlStateNormal];

    barGraph.titleLabel.textColor=[UIColor colorWithRed:26/255.0 green:79/255.0 blue:138/255.0 alpha:1.0];
    [self.view addSubview:barGraph];
    
    [barGraph addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchDown];
    
         [self loadGraphView:2];
    
  }

-(void)loadGraphView:(int)tag
{

    barGraphView.baseLineCoordinateValue=0.0;
  
    
    barGraphView.mActualDataValues =[[NSMutableArray alloc]init];
    barGraphView.mActualDataValues=[datavalueList copy];
  
      
    barGraphView.xAxisLabels =[[NSMutableArray alloc]init];
    barGraphView.xAxisLabels =[xaxisLabelList copy];
    
   // NSLog(@"count is %d",[xaxisLabelList count]);
     [barGraphView.layer displayIfNeeded];
      [graphScrollContainer setContentOffset:CGPointMake(0, 0) animated:NO];
    float min=0.0,max=0.0;
    for(int i=0;i<[datavalueList count];i++)
    {
        NSLog(@"the values are %@",[datavalueList objectAtIndex:i]);
       if(min>[[datavalueList objectAtIndex:i]floatValue])
       {
       
           min=[[datavalueList objectAtIndex:i]floatValue];
       }
        
        if(max<[[datavalueList objectAtIndex:i]floatValue])
        {
        
            max=[[datavalueList objectAtIndex:i]floatValue];
        
        }
    
    }
    NSLog(@"max value is %0.2f and min is %0.2f",max,min);
       NSMutableArray *yList=[[NSMutableArray alloc]init];
    
      {
            [yList addObject:[NSString stringWithFormat:@"%0.2f",min]];
      
      }
    
    int step=(max-min)/5;
    
    if(min>=0)
     {
         min=0;
         
         max=max+step ;
         
         
     }//if min>-0
    
    else
    {
       
        min=min-step ;
        max=max+step ;
     barGraphView.baseLineCoordinateValue = (0 - min)/(max - min);
        NSLog(@"the cordina is %f",barGraphView.baseLineCoordinateValue);
    }
    
    if(min == max && max >0)
    {
        min = 0;
    }
    
    //recalculate step
    
    step=(max-min)/5 ;
    barGraphView.yAxisLeftLabels=[[NSMutableArray alloc]init];
    if (step)
    {
        if ((min >= -10 && max <= 10) || step < 1)  // For lower y axis values should display float values
        {
            for (int dataPointsCount = 0; dataPointsCount < 6; dataPointsCount++)
            {
                [barGraphView.yAxisLeftLabels addObject:[NSString stringWithFormat:@"%.2f", min+(step *dataPointsCount)]];
            }
        }
        else
        {
            for (int dataPointsCount = 0; dataPointsCount < 5+1; dataPointsCount++)
            {
                // [barGraphView.yAxisLeftLabels addObject:[NSString stringWithFormat:@"%.0f", minY+(stepY *dataPointsCount)]];
                [barGraphView.yAxisLeftLabels addObject:[NSString stringWithFormat:@"%.1f", min+(step *dataPointsCount)]];
            }
        }
    }

    
    NSMutableArray *linegraph =[[NSMutableArray alloc]init];
    barGraphView.dataBar1=[[NSMutableArray alloc]init];
    barGraphView.dataBar2=[[NSMutableArray alloc]init];
    for(int i=0;i<[datavalueList count];i++)
    {
        float value =  ([[datavalueList objectAtIndex:i]floatValue]-min)/(max-min) ;
        float value2 =  ([[datavalueList objectAtIndex:i]floatValue]-min)/(max-min) ;
        
        [linegraph addObject:[NSNumber numberWithFloat:value]];
        [barGraphView.dataBar1 addObject:[NSNumber numberWithFloat:value2]];
        //[barGraphView.dataBar2 addObject:[NSNumber numberWithFloat:value2]];
    }
    
    barGraphView.dataLine1=[linegraph copy];
    
    
    
    for(int i=0;i<[barGraphView.dataLine1 count];i++)
    {
        NSLog(@"the value is %f",[[barGraphView.dataLine1 objectAtIndex:i]floatValue]);
        
        
    }

    
    containerGraphRootView.yAxisLeftLabels = barGraphView.yAxisLeftLabels ;
    containerGraphRootView.yAxisName = @"Y-Axis Label Here";
    graphScrollContainer.scrollEnabled=YES;
    

     barGraphView.kDefaultGraphWidth = barGraphView.kOffsetX + barGraphView.kStepX * ([barGraphView.mActualDataValues count] + 2);
     [graphScrollContainer setContentSize:CGSizeMake(barGraphView.kDefaultGraphWidth + GRAPHVIEW_EXTRA_WIDTH_FOR_LEGENDS_DISPLAY, 360)];
    barGraphView.kBarWidth  = 15;
    barGraphView.kOffsetX   = 10;
    pGraphScrollFrame = graphScrollContainer.frame;
    barGraphView.graphType=tag;
   // barGraphView.baseLineCoordinateValue = 0.0;
    
    [containerGraphRootView setNeedsDisplay];
    [barGraphView setNeedsDisplay];
    
    if(barGraphView.graphType==2)
    [UIView transitionWithView:containerGraphRootView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{ [barGraphView.layer displayIfNeeded]; }  completion:nil];
    
    else
    {
    
     [UIView transitionWithView:containerGraphRootView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ [barGraphView.layer displayIfNeeded]; }  completion:nil];
    }
   
   
}


- (IBAction)handleButtonPress:(UIButton *)sender
{
   
    
    switch (sender.tag) {
        case 0:
        {
            
                barGraphView.graphType=2;                  
        [self loadGraphView:2]; 
        }
            break;
            
            case 1:
        {
            
           barGraphView.graphType=1; 
              [self loadGraphView:1];
                     
        }
            break;
            case 3:
        {
            exit(0);
        
        }
            break ;
        default:
            break;
    }



}

/*- (void)dealloc {
    [GraphLabel release];
    [super dealloc];
}*/
@end
