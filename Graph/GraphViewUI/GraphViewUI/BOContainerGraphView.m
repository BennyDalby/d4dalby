//
//  BOContainerGraphView.m
//  GraphView
//
//  Created by b.dalby.thoomkuzhy on 15/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BOContainerGraphView.h"

@implementation BOContainerGraphView
@synthesize yAxisLeftLabels, yAxisName;

#define kOffsetX 30

#define kGraphBottom 330

#define kStepY 53  //24
#define kOffsetY 20

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(context, "Helvetica", 12, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1] CGColor]);
    
    int szYAxis = [self.yAxisLeftLabels count];
    if (szYAxis)
    {
        NSString *theText0 = (NSString *) [self.yAxisLeftLabels objectAtIndex:0];
        CGSize labelSize0 = [theText0 sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        
        CGContextShowTextAtPoint(context, kOffsetX - labelSize0.width/2, kGraphBottom - 5-10, [theText0 cStringUsingEncoding:NSUTF8StringEncoding], [theText0 length]);
        for (int i = 1; i < szYAxis; i++)
        {
            NSString *theText = (NSString *) [self.yAxisLeftLabels objectAtIndex:szYAxis - i];
            CGSize labelSize = [theText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
            
            CGFloat yPosn = 0.0;
            if (i == 1)
            {
                yPosn = kOffsetY+30;
            }
            else
            {
                yPosn = kOffsetY + ((i-1) * kStepY) - labelSize.height/5+30;
            }
            CGContextShowTextAtPoint(context, kOffsetX - labelSize.width/2, yPosn, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
        }
    }
    
    // Draw Metric Actuals Line
    if (self.yAxisName)
    {
        CGAffineTransform myTextTransform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
        CGContextSelectFont (context,
                             "Helvetica",
                             13,
                             kCGEncodingMacRoman);
        CGContextSetTextDrawingMode (context, kCGTextFill);
        CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:43.0/255.0 green:88.0/255.0 blue:130.0/255.0 alpha:1] CGColor]);
        
        myTextTransform =  CGAffineTransformConcat(myTextTransform, CGAffineTransformMakeRotation(M_PI/2)) ;
        CGContextSetTextMatrix (context, myTextTransform);
        
        CGSize labelSizeYAxis = [self.yAxisName sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13]];
        
        int labelYPosn = kGraphBottom - labelSizeYAxis.width;
        CGContextShowTextAtPoint (context, 50, labelYPosn/2, [self.yAxisName UTF8String], [self.yAxisName length]);
    }
}


@end
