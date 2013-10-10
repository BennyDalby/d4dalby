//
//  ViewController.m
//  TableScreen
//
//  Created by b.dalby.thoomkuzhy on 10/7/13.
//  Copyright (c) 2013 b.dalby.thoomkuzhy. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.userInteractionEnabled=NO;
    [viewTable addSubview:viewLabel];
	
    table=[[UITableView alloc]initWithFrame:CGRectMake(-200, 0, 130, 480) style: UITableViewStylePlain];
    table.delegate=self ;
    table.dataSource=self;
    [self.view addSubview:table];
    table.backgroundColor=[UIColor colorWithRed:161/255.0 green:81/255.0 blue:56/255.0 alpha:1.0];
    
    [self performSelector:@selector(swipscreenleft) withObject:nil afterDelay:2.0];
    [self performSelector:@selector(hideIcons) withObject:nil afterDelay:4.0];
    [self gesture];
    [self gesture2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)swipscreenleft
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    
    viewLabel3.alpha=0.0;
    viewLabel2.alpha=1.0;
    right_Arrow.alpha=0.0;
    left_Arrow.alpha=1.0;
    [UIView commitAnimations];

}

-(void)hideIcons
{
    viewLabel2.alpha=0.0;
    left_Arrow.alpha=0.0;
    
    self.view.userInteractionEnabled=YES;



}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 20;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Cell *cell ;
//    
//    cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if(!cell)
//    {
//        cell = [[Cell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//        
//    }
//
//    cell.label_name.text=[NSString stringWithFormat:@"Row %d",indexPath.row+1];
//
//    cell.label_name.textColor=[UIColor blackColor];//
//    cell.label_name.backgroundColor=[UIColor clearColor];
//   // cell.label_name.textAlignment=NSTextAlignmentRight;
//    
//    return cell ;

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   // NSInteger row = indexPath.row;
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
    }
    
    // Setup row background image (a.k.a the set image)
  
    
   // cell.backgroundView = [[UIImageView alloc] initWithImage:setImage];
  //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:setImage];
    
   // NSString *setName = [[self.wallpaperCollectionArray objectAtIndex:row] valueForKey:@"name"];
  //  cell.textLabel.text = [setName uppercaseString];
    cell.textLabel.text=[NSString stringWithFormat:@"Row     %d",indexPath.row+1];
    cell.textLabel.font = [UIFont fontWithName:@"OpenSans" size:20];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor redColor];    // Not working?
    cell.textLabel.textAlignment=NSTextAlignmentCenter;   // Not working?
    
    //[cell.textLabel setTextAlignment:NSTextAlignmentRight];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  



}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    NSLog(@"yoo");

}

-(void)gesture
{

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    



}

-(void)gesture2
{
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeto)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    
    
    
    
}


-(void)handleSwipeFrom
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    
    table.frame=CGRectMake(0, 0, 130, 480);
    [UIView commitAnimations];
 

}

-(void)handleSwipeto
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    
    table.frame=CGRectMake(-200, 0,130, 480);
    [UIView commitAnimations];
 



}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    
    table.frame=CGRectMake(-200,0,130, 480);
   
    [UIView commitAnimations];
    index=indexPath.row ;
    [self performSelector:@selector(nowview) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(nextView) withObject:nil afterDelay:2.0];


}

-(void)nowview
{viewLabel.alpha=0.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
      viewTable.frame=CGRectMake(0, 548/2, 320, 0);
    
    [UIView commitAnimations];

}

-(void)nextView
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    
    viewTable.frame=CGRectMake(0,20, 320, 548);
    viewLabel.text=[NSString stringWithFormat:@"Add Contents in Row%d Here",index+1];
    viewLabel.alpha=1.0;
    [UIView commitAnimations];


}
@end
