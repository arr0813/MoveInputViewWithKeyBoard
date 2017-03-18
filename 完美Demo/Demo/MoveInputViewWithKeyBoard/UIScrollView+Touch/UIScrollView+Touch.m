//
//  UIScrollView+Touch.m
//  BGH
//
//  Created by Sunny on 16/12/19.
//  Copyright © 2016年 Rongtong. All rights reserved.
//

#import "UIScrollView+Touch.h"

@implementation UIScrollView (Touch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

@end
