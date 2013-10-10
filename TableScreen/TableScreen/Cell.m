//
//  Cell.m
//  TableScreen
//
//  Created by b.dalby.thoomkuzhy on 10/7/13.
//  Copyright (c) 2013 b.dalby.thoomkuzhy. All rights reserved.
//

#import "Cell.h"

@implementation Cell

@synthesize image_name,label_name ;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.image_name=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        self.label_name=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 100, 30)];
        
        
        [self addSubview:label_name];
        [self addSubview:image_name];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
