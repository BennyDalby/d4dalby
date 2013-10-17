//
//  AppDelegate.h
//  GraphViewApplication
//
//  Created by b.dalby.thoomkuzhy on 9/5/13.
//  Copyright (c) 2013 praseeda.manissery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GraphViewUI/GraphViewUI.h>



//@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    GraphViewUI* graphView;
}

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic,retain) NSArray *values;
@property (nonatomic,retain) NSArray *keys;
@end
