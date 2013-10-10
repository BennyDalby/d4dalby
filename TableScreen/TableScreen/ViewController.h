//
//  ViewController.h
//  TableScreen
//
//  Created by b.dalby.thoomkuzhy on 10/7/13.
//  Copyright (c) 2013 b.dalby.thoomkuzhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{

    UITableView *table ;

    int index ;

    IBOutlet UILabel *viewLabel3;
    IBOutlet UIImageView *right_Arrow;
    IBOutlet UILabel *viewLabel2;
    IBOutlet UIImageView *left_Arrow;
    IBOutlet UILabel *viewLabel;
    IBOutlet UIView *viewTable;
}

@end
