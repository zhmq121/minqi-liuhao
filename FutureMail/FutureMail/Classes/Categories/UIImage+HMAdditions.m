//
//  UIImage+HMImage.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "UIImage+HMAdditions.h"

@implementation UIImage (HMAdditions)

+ (UIImage *)imageWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithFrame:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f) withColor:color];
}

@end
