//
//  UILaunchViewController.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "UILaunchViewController.h"

@implementation UILaunchViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.view = [[UILaunchView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return self;
}

@end
