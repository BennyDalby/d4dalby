//
//  GraphViewUI.h
//  GraphViewUI
//
//  Created by b.dalby.thoomkuzhy on 9/5/13.
//  Copyright (c) 2013 praseeda.manissery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface GraphViewUI : NSObject
{
    ViewController* graphViewController;
}

-(UIViewController*) Invoke:(NSArray *)dataPointArray LabelValueList:(NSArray *)LabelList  ;

@end
