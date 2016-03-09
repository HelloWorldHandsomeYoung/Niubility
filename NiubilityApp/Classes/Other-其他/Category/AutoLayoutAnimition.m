//
//  AutoLayoutAnimition.m
//  NiubilityApp
//
//  Created by 吕阳 on 16/3/5.
//  Copyright © 2016年 DeveloperYoung. All rights reserved.
//

#import "AutoLayoutAnimition.h"

@implementation AutoLayoutAnimition
+ (void)topLabelWith:(UILabel *)label withView:(UIView *)view
{
    [UIView animateWithDuration:1 animations:^{
        label.transform = CGAffineTransformIdentity;
    }];
}
+ (void)thirdLogin:(UIView *)button withView:(UIView *)view withTimeInterval:(NSTimeInterval )time
{
    NSTimeInterval sumTime = time + 0.5;
    [UIView animateWithDuration: sumTime animations:^{
        button.transform = CGAffineTransformIdentity;
    }];
}

+ (void)loginButtonMaskAnimition:(UIView *)view withBeginTime:(NSTimeInterval)time
{
    CGPathRef beginPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, CGRectGetHeight(view.bounds))].CGPath;
    CGPathRef endPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds))].CGPath;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.path = beginPath;
    
    view.layer.mask = layer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 1;
    animation.beginTime = CACurrentMediaTime() + time;
    animation.fromValue = (__bridge id _Nullable)(layer.path);
    animation.toValue = (__bridge id _Nullable)(endPath);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:@"shapeLayerPath"];
}
+ (void)midToSide:(NSLayoutConstraint *)constrains withView:(UIView *)View
{
    constrains.constant = 290;
    [UIView animateWithDuration:1.5 animations:^{
        [View layoutIfNeeded];
    }];
}

+ (void)backZeroLayoutConstraint:(NSLayoutConstraint *)constrains withView:(UIView *)view
{
    constrains.constant = 0;
    [UIView animateWithDuration:1 animations:^{
        [view layoutIfNeeded];
    }];
}
@end
