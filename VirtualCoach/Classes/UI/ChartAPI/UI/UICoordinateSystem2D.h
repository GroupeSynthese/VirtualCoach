//
//  UICoordinateSystem2D.h
//  VirtualCoach
//
//  Created by Bi ZORO on 15/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinateSystem2D.h"
#import "UIAxis.h"
#import "UICurve.h"

@interface UICoordinateSystem2D : UIView

@property (nonatomic) CoordinateSystem2D *coordinateSystem;

@property (nonatomic) UIAxis *abscissAxis;

@property (nonatomic) UIAxis *ordinateAxis;

@property (nonatomic) CGFloat margin;

@property (nonatomic) CGFloat scale;

@property (nonatomic) BOOL wantsBackgroundPattern;

@property (nonatomic) UIColor *backgroundPatternLineColor;

@property (nonatomic) BOOL wantsAxesName;

@property (nonatomic) BOOL wantsAbscissTitles;

@property (nonatomic) BOOL wantsOrdinateTitles;

- (instancetype)initWithFrame:(CGRect)frameRect coordinateSystem:(CoordinateSystem2D *)coordinateSystem;

- (void)draw;
- (void)drawCurve:(UICurve *)curve;

@end
