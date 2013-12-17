//
//  BezierPathView.m
//  Dropit
//
//  Created by Minlin Zhang on 12/17/13.
//  Copyright (c) 2013 Minlin Zhang. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

- (void)setPath:(UIBezierPath *)path
{
    _path = path;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //Drawing code
    [self.path stroke];
}
@end
