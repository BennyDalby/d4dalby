//
//  CustomGraphView.m
//  PoC Samples
//
//  Created by b.dalby.thoomkuzhy on 05/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomGraphView.h"
#import "Enums.h"
#define kGraphHeight 310
//#define kDefaultGraphWidth 900
//#define kOffsetX 10 //Bar
//#define kOffsetX 10

#define kGraphBottom 330

#define kGraphTop 0

#define kOffsetY 20


@implementation CustomGraphView
@synthesize graphType, dataLine1, dataLine2, mActualDataValues, dataBar1, dataBar2;
@synthesize xAxisLabels, yAxisLeftLabels, yAxisRightLabels;
@synthesize kBarWidth, kOffsetX, baseLineCoordinateValue;

@synthesize kStepX, yRtStep, isComparisionSet, kStepY, kDefaultGraphWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.kStepX = 60;
        self.kOffsetX = 0;
        self.kBarWidth = 15;
        //        self.kDefaultGraphWidth = 900;
        self.kStepY = 53;
        self.yRtStep = 46;
        self.isComparisionSet = NO;
        
        legendImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"GraphLegend.png"]];
        legendImageView.hidden = YES;
        legendImageView.frame = CGRectZero;
        //        [self addSubview:legendImageView];
        baseLineCoordinateValue = 0;
        
    }
    return self;
}

#define kCircleRadius 2

- (void)drawTargetLineForBarGraphWithContext:(CGContextRef)ctx
{
    // Start Gradient fill
    
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:94.0/255.0 green:27.0/255.0 blue:20.0/255.0 alpha:1.0] CGColor]);
    
    int maxGraphHeight = kGraphHeight - kOffsetY;
    
    // Data Point circles
    CGContextSaveGState(ctx);
    CGContextClipToRect(ctx, CGRectMake(0, 0, self.kDefaultGraphWidth, 215));
    int size = [self.dataBar2 count];
    for (int i = 1; i <= size; i++)
    {
        CGRect rect = CGRectMake(kOffsetX + i * kStepX - kCircleRadius, kGraphHeight - kCircleRadius - maxGraphHeight * [[self.dataBar2 objectAtIndex:i-1] floatValue] + 1, kCircleRadius, kCircleRadius);
        // CGContextAddEllipseInRect(ctx, rect);
        
        CGContextMoveToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius, kGraphHeight - kCircleRadius - maxGraphHeight * [[self.dataBar2 objectAtIndex:i-1] floatValue]);
        CGContextAddLineToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius+3, kGraphHeight - kCircleRadius +8- maxGraphHeight * [[self.dataBar2 objectAtIndex:i-1] floatValue]);
        
        CGContextAddLineToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius-5, kGraphHeight - kCircleRadius +8- maxGraphHeight * [[self.dataBar2 objectAtIndex:i-1] floatValue]);
        
        CGContextAddLineToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius, kGraphHeight - kCircleRadius - maxGraphHeight * [[self.dataBar2 objectAtIndex:i-1] floatValue]);
        CGContextSetRGBFillColor(ctx, 246/255.0, 153.0/255.0,49.0/255.0, 1.0);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);
    
    
    // Draw Metric Actuals Line
    CGContextSaveGState(ctx);
    CGContextClipToRect(ctx, CGRectMake(0, 0, self.kDefaultGraphWidth, 215));
    CGContextMoveToPoint(ctx, kOffsetX + self.kStepX, kGraphHeight - maxGraphHeight * [[self.dataBar2 objectAtIndex:0] floatValue]);
    for (int i = 1; i < [self.dataBar2 count]; i++)
    {
        //CGContextAddLineToPoint(ctx, kOffsetX + ((i+1) * self.kStepX), kGraphHeight - maxGraphHeight * [[self.dataBar2 objectAtIndex:i] floatValue]);
        
        
        
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    CGContextRestoreGState(ctx);
}


//Draw bar graph - Draw one bar at a time
#define kBarTop 20

- (void)drawUpDownBarGraphWithContext:(CGContextRef)context
{
    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    
    for (int i = 0; i < [self.dataBar1 count]; i++)
    {
        float barX = 0.0;
        if (self.isComparisionSet == YES)
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX - self.kBarWidth;
        }
        else
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX - self.kBarWidth / 2;
        }
        
        float barY, barHeight;
        if (self.baseLineCoordinateValue > [[self.dataBar1 objectAtIndex:i] floatValue])
        {
            // Plot positive values
            barY = kBarTop + maxBarHeight - maxBarHeight * [[self.dataBar1 objectAtIndex:i] floatValue]+20;
            barHeight = maxBarHeight * ([[self.dataBar1 objectAtIndex:i] floatValue] - self.baseLineCoordinateValue)+5;
        }
        else
        {
            // Plot negative values
            barY = kBarTop + maxBarHeight - maxBarHeight * self.baseLineCoordinateValue+20;
            barHeight = maxBarHeight * (self.baseLineCoordinateValue - [[self.dataBar1 objectAtIndex:i] floatValue])-10;
            NSLog(@"the coordinate value is %f",self.baseLineCoordinateValue);
        }
        
        CGRect barRect = CGRectMake(barX, barY, self.kBarWidth, barHeight);
        [self drawBar:barRect context:context barID:1];
    }
    
    if([self.dataBar2 count] > 0)
    {
        [self drawTargetLineForBarGraphWithContext: context];
    }
    
}


- (void)drawBarGraphWithContext:(CGContextRef)context
{
    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    
    for (int i = 0; i < [self.dataBar1 count]; i++)
    {
        float barX = 0.0;
        if (self.isComparisionSet == YES)
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX - self.kBarWidth;
        }
        else
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX - self.kBarWidth / 2;
        }
        
        float barY = kBarTop + maxBarHeight - maxBarHeight * [[self.dataBar1 objectAtIndex:i] floatValue];
        float barHeight = maxBarHeight * [[self.dataBar1 objectAtIndex:i] floatValue];
        CGRect barRect = CGRectMake(barX, barY, self.kBarWidth, barHeight);
        [self drawBar:barRect context:context barID:1];
    }
    
    if([self.dataBar2 count] > 0)
    {
        [self drawTargetLineForBarGraphWithContext: context];
    }
    
    //    for (int i = 0; i < [self.dataBar2 count]; i++)
    //    {
    //        float barX = 0.0;
    //        if (self.isComparisionSet == YES)
    //        {
    //            barX = kOffsetX + self.kStepX + i * self.kStepX + self.kBarWidth;
    //        }
    //        else
    //        {
    //            barX = kOffsetX + self.kStepX + i * self.kStepX + self.kBarWidth / 2;
    //        }
    //
    //        float barY = kBarTop + maxBarHeight - maxBarHeight * [[self.dataBar2 objectAtIndex:i] floatValue];
    //        float barHeight = maxBarHeight * [[self.dataBar2 objectAtIndex:i] floatValue];
    //        CGRect barRect = CGRectMake(barX+2, barY, self.kBarWidth, barHeight);
    //        [self drawBar:barRect context:context barID:2];
    //    }
}

// Draw Bars with Multiple colors
- (void)drawMultiColorBarGraphWithContext:(CGContextRef)context
{
    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    
    for (int i = 0; i < [self.dataBar1 count]; i++)
    {
        //        float barX = kOffsetX + self.kStepX + i * self.kStepX - self.kBarWidth / 2;
        float barX = 0.0;
        
        if (self.isComparisionSet == YES)
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX - self.kBarWidth;
        }
        else
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX - self.kBarWidth / 2;
        }
        
        float barY = kBarTop + maxBarHeight - maxBarHeight * [[self.dataBar1 objectAtIndex:i] floatValue];
        float barHeight = maxBarHeight * [[self.dataBar1 objectAtIndex:i] floatValue];
        
        CGRect barRect1 = CGRectMake(barX, barY, self.kBarWidth, barHeight/3);
        [self drawBar:barRect1 context:context barID:1];
        
        CGRect barRect2 = CGRectMake(barX, barY + barHeight/3, self.kBarWidth, barHeight/3);
        [self drawBar:barRect2 context:context barID:2];
        
        CGRect barRect3 = CGRectMake(barX, barY + (barHeight*2/3), self.kBarWidth, barHeight/3);
        [self drawBar:barRect3 context:context barID:1];
        
    }
    
    for (int i = 0; i < [self.dataBar2 count]; i++)
    {
        //        float barX = kOffsetX + self.kStepX + i * self.kStepX + self.kBarWidth/2;
        float barX = 0.0;
        if (self.isComparisionSet == YES)
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX + self.kBarWidth;
        }
        else
        {
            barX = kOffsetX + self.kStepX + i * self.kStepX + self.kBarWidth / 2;
        }
        
        float barY = kBarTop + maxBarHeight - maxBarHeight * [[self.dataBar2 objectAtIndex:i] floatValue];
        float barHeight = maxBarHeight * [[self.dataBar2 objectAtIndex:i] floatValue];
        CGRect barRect = CGRectMake(barX, barY, self.kBarWidth, barHeight);
        [self drawBar:barRect context:context barID:2];
    }
    
}

- (void)drawBar:(CGRect)rect context:(CGContextRef)ctx barID:(NSInteger)barID
{
    // Prepare the resources
    
    CGFloat components1[12] = {32.0/255.0, 146.0/255.0, 28.0/255.0, 0.2,  // Start color
        32.0/255.0, 146.0/255.0, 28.0/255.0, 0.5, // Second color
        32.0/255.0, 146.0/255.0, 28.0/255.0, 1.0}; // End color
    
    CGFloat components2[12] = {94.0/255.0, 27.0/255.0, 20.0/255.0, 0.2,  // Start color
        94.0/255.0, 27.0/255.0, 20.0/255.0, 0.5, // Second color
        94.0/255.0, 27.0/255.0, 20.0/255.0, 1.0}; // End color
    
    
    CGFloat locations[3] = {0.0, 0.33, 1.0};
    size_t num_locations = 3;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient;
    if (1 == barID)
    {
        gradient = CGGradientCreateWithColorComponents(colorspace, components1, locations, num_locations);
    }
    else if (2 == barID)
    {
        gradient = CGGradientCreateWithColorComponents(colorspace, components2, locations, num_locations);
    }
    
    CGPoint startPoint = rect.origin;
    CGPoint endPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    
    CGContextBeginPath(ctx);
    CGContextSetGrayFillColor(ctx, 0.2, 0.7);
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    
    
    CGContextSaveGState(ctx);
    CGContextClip(ctx);
    // Draw the gradient
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(ctx);
    // Release the resources
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
}

//Draw Line graph


- (void)drawLineCompareGraphWithContext:(CGContextRef)ctx
{
    // Start Gradient fill
    CGGradientRef gradient;
    CGColorSpaceRef colorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {79/255.0, 129.0/255.0, 190.0/255.0, 0.4,  // Start color
        79/255.0, 129.0/255.0, 190.0/255.0, 1.0}; // End color
    colorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    CGPoint startPoint, endPoint;
    startPoint.x = kOffsetX;
    startPoint.y = kGraphHeight;
    endPoint.x = kOffsetX;
    endPoint.y = kOffsetY;
    
    
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:32.0/255.0 green:146.0/255.0 blue:28.0/255.0 alpha:1.0] CGColor]);
    int maxGraphHeight = kGraphHeight - kOffsetY;
    
    // Data Point circles
    CGContextSaveGState(ctx);
    CGContextClipToRect(ctx, CGRectMake(0, 0, self.kDefaultGraphWidth, 320));
    int size = [self.dataLine1 count];
    for (int i = 1; i <= size; i++)
    {
        CGRect rect = CGRectMake(kOffsetX + i * kStepX - kCircleRadius, kGraphHeight - kCircleRadius - maxGraphHeight * [[self.dataLine1 objectAtIndex:i-1] floatValue] + 1, kCircleRadius, kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);
    
    
    // Draw Metric Actuals Line
    
    CGContextSaveGState(ctx);
    CGContextClipToRect(ctx, CGRectMake(0, 0, self.kDefaultGraphWidth, 320));
    //CGContextMoveToPoint(ctx, kOffsetX + self.kStepX, kGraphHeight - kCircleRadius- maxGraphHeight * [[self.dataLine1 objectAtIndex:0] floatValue]);
    CGContextMoveToPoint(ctx, kOffsetX + self.kStepX-1, kGraphHeight - maxGraphHeight * [[self.dataLine1 objectAtIndex:0] floatValue]);
    for (int i = 1; i < [self.dataLine1 count]; i++)
    {
        CGContextAddLineToPoint(ctx, (kOffsetX + ((i+1) * self.kStepX))-1, kGraphHeight - maxGraphHeight * [[self.dataLine1 objectAtIndex:i] floatValue]);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    CGContextRestoreGState(ctx);
    
    if ([self.dataLine2 count] > 0)
    {
        CGGradientRef gradient1;
        CGColorSpaceRef colorspace1;
        size_t num_locations1 = 2;
        CGFloat locations1[2] = {0.0, 1.0};
        CGFloat components1[8] = {0.45, 0.2, 0.7, 0.2,  // Start color
            0.45, 0.2, 0.7, 1.0}; // End color
        colorspace1 = CGColorSpaceCreateDeviceRGB();
        gradient1 = CGGradientCreateWithColorComponents(colorspace1, components1, locations1, num_locations1);
        
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:94.0/255.0 green:27.0/255.0 blue:20.0/255.0 alpha:1.0] CGColor]);
        
        CGContextSaveGState(ctx);
        CGContextClipToRect(ctx, CGRectMake(0, 0, self.kDefaultGraphWidth, 215));
        
        // Data Point circles
        CGContextSaveGState(ctx);
        CGContextClipToRect(ctx, CGRectMake(0, 0, self.kDefaultGraphWidth, 215));
        int size = [self.dataLine2 count];
        for (int i = 1; i <= size; i++)
        {
            CGRect rect = CGRectMake(kOffsetX + i * kStepX - kCircleRadius, kGraphHeight - kCircleRadius - maxGraphHeight * [[self.dataLine2 objectAtIndex:i-1] floatValue] + 1, kCircleRadius, kCircleRadius);
            //CGContextAddEllipseInRect(ctx, rect);
            
            CGContextMoveToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius, kGraphHeight - kCircleRadius - maxGraphHeight * [[self.dataLine2 objectAtIndex:i-1] floatValue]);
            CGContextAddLineToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius+3, kGraphHeight - kCircleRadius +8- maxGraphHeight * [[self.dataLine2 objectAtIndex:i-1] floatValue]);
            
            CGContextAddLineToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius-5, kGraphHeight - kCircleRadius +8- maxGraphHeight * [[self.dataLine2 objectAtIndex:i-1] floatValue]);
            
            CGContextAddLineToPoint(ctx,kOffsetX + i * kStepX - kCircleRadius, kGraphHeight - kCircleRadius - maxGraphHeight * [[self.dataLine2 objectAtIndex:i-1] floatValue]);
            CGContextSetRGBFillColor(ctx, 246/255.0, 153.0/255.0,49.0/255.0, 1.0);
            
        }
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CGContextRestoreGState(ctx);
        
        //Draw Metric Targets Line
        
        CGContextMoveToPoint(ctx, kOffsetX + self.kStepX, kGraphHeight - maxGraphHeight * [[self.dataLine2 objectAtIndex:0] floatValue]);
        for (int i = 1; i < [self.dataLine2 count]; i++)
        {
            // CGContextAddLineToPoint(ctx, kOffsetX + ((i+1) * self.kStepX), kGraphHeight - maxGraphHeight * [[self.dataLine2 objectAtIndex:i] floatValue]);
        }
        CGContextDrawPath(ctx, kCGPathStroke);
        CGContextRestoreGState(ctx);
        
    }
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.kDefaultGraphWidth == 0) {
        // This is initial launch. Avoid drawing few lines without data
        return;
    }
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
    // Make the grid lines as dashed lines
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);
    // Draw Y Axis
    int howManyHorizontal = 5;
    int additionalWidth = (self.kDefaultGraphWidth - 20)% 60; // 20 pixels margin from left & right side
    additionalWidth += (30 - kOffsetX); // This 20 or 30 Pixels are due to the same width is chopped from initial box
    
    for (int i = 1; i <= howManyHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY-5.0);
        CGContextAddLineToPoint(context, self.kDefaultGraphWidth - 20 - additionalWidth, kGraphBottom  - kOffsetY - i * kStepY-5.0);
        //        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
        //        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
        
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash
    
    legendImageView.hidden = YES;
    legendImageView.frame = CGRectZero;
    
    switch (self.graphType)
    {
        case BO_GRAPH_TYPE_BAR:
        {
            // Draw the bars
            //            [self drawBarGraphWithContext:context];
            // Base line from where we plot graph
            
            //            if (self.baseLineCoordinateValue)
            //            {
            //                CGContextSetLineWidth(context, 2.0);
            //                CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:43/255.0 green:88/255.0 blue:130/255.0 alpha:1] CGColor]);
            //                CGFloat dash[] = {2.0, 4.0};
            //                CGContextSetLineDash(context, 0.0, dash, 3);
            //
            //                int maxGraphHeight = kGraphHeight - kOffsetY;
            //
            //
            //                CGContextMoveToPoint(context, kOffsetX, (kGraphHeight - maxGraphHeight * self.baseLineCoordinateValue)-5);
            //                CGContextAddLineToPoint(context, self.kDefaultGraphWidth - 20 - additionalWidth, (kGraphHeight - maxGraphHeight * self.baseLineCoordinateValue)-5);
            //                CGContextStrokePath(context);
            //                CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash
            //            }
            
            
            [self drawUpDownBarGraphWithContext:context];
        }
            break;
            
        case BO_GRAPH_TYPE_LINE:
        {
            [self drawLineCompareGraphWithContext:context];
        }
            break;
            
            
        default:
            break;
    }
    
    [self drawXAxisWithDataPoints:context];
}

- (void) drawXAxisWithDataPoints:(CGContextRef)context
{
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    // Draw X Axis
    int boxHight = 23;
    int boxWidth = 60;
    int additionalWidth = (self.kDefaultGraphWidth - 20)% boxWidth; // 20 pixels margin from left & right side
    additionalWidth += (30 - kOffsetX); // This 20 or 30 Pixels are due to the same width is chopped from initial box
    
    for (int noOfHLines = 0; noOfHLines < 2; noOfHLines ++)
    {
        CGContextMoveToPoint(context, 0, kGraphBottom + boxHight * noOfHLines - kOffsetY - 8+10);
        CGContextAddLineToPoint(context,  self.kDefaultGraphWidth - 20 - additionalWidth, kGraphBottom + boxHight * noOfHLines - kOffsetY  - 8+10);
    }
    
    CGContextMoveToPoint(context, 0, kGraphBottom + boxHight * 2 - kOffsetY - 8+1+10);
    CGContextAddLineToPoint(context,  self.kDefaultGraphWidth - 20 - additionalWidth, kGraphBottom + boxHight * 2 - kOffsetY  - 8+10);
    // Draw vertical lines
    
    
    CGContextMoveToPoint(context, 0, kGraphBottom - kOffsetY - 8+10);
    CGContextAddLineToPoint(context, 0, kGraphBottom + (boxHight*2) - kOffsetY -8+10);
    CGContextSetFillColorWithColor(context, [[UIColor blackColor]CGColor]);
    for (int noOfVLines = 0; noOfVLines < (self.kDefaultGraphWidth - 20)/boxWidth; noOfVLines ++)
    {
        CGContextMoveToPoint(context, kOffsetX  + 30 + boxWidth * noOfVLines, kGraphBottom - kOffsetY - 8+10);
        CGContextAddLineToPoint(context, kOffsetX  + 30 + boxWidth * noOfVLines, kGraphBottom + (boxHight*2) - kOffsetY - 8+10);
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
    //    CGContextStrokePath(context);
    
    // Drawing X Asis Labels
    CGContextSetTextMatrix(context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(context, "Helvetica", 11, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] CGColor]);
    
    
    for (int i = 1; i <= [self.xAxisLabels count]; i++)
    {
        NSString *theText = (NSString *) [self.xAxisLabels objectAtIndex:i-1];
        CGSize labelSize = [theText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:11]];
        CGContextShowTextAtPoint(context, kOffsetX + i * self.kStepX - labelSize.width/2, kGraphBottom-2, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    }
    
    for (int i = 1; i < [self.mActualDataValues count]+1; i++)
    {
        // Drawing Data Points
        switch (self.graphType)
        {
            case BO_GRAPH_TYPE_BAR:
            {
                NSString *strDataPoint = (NSString *)[self.mActualDataValues objectAtIndex:i-1];
                CGSize dataPointSize = [strDataPoint sizeWithFont:[UIFont fontWithName:@"Helvetica" size:11]];
                CGContextShowTextAtPoint(context, kOffsetX + i * self.kStepX - dataPointSize.width/2, kGraphBottom + boxHight -2, [strDataPoint cStringUsingEncoding:NSUTF8StringEncoding], [strDataPoint length]);
                
            }
                break;
                
            case BO_GRAPH_TYPE_LINE:
            {
                NSString *strDataPoint = (NSString *)[self.mActualDataValues objectAtIndex:i-1];
                CGSize dataPointSize = [strDataPoint sizeWithFont:[UIFont fontWithName:@"Helvetica" size:11]];
                CGContextShowTextAtPoint(context, kOffsetX + i * self.kStepX - dataPointSize.width/2, kGraphBottom + boxHight -2, [strDataPoint cStringUsingEncoding:NSUTF8StringEncoding], [strDataPoint length]);
                
            }
                break;
                
            default:
                break;
        }
    }
}

-(void) displayLegend
{
    // Add Legend for graph
    
    if (self.kDefaultGraphWidth > 0) 
    {
        CGRect legendFrame = CGRectMake(self.kDefaultGraphWidth, 62, 91, 58);
        legendImageView.frame = legendFrame;
        legendImageView.hidden = NO;
    }
}

@end
