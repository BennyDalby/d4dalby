//
//  BOContainerGraphView.h
//  GraphView
//
//  Created by b.dalby.thoomkuzhy on 15/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOContainerGraphView : UIView<UIGestureRecognizerDelegate>


@property   (nonatomic, retain) NSMutableArray      *yAxisLeftLabels;
@property   (nonatomic, copy)   NSString            *yAxisName;
@end
