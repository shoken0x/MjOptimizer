//
//  UIImageUtil.swift
//  MjOptimizer
//
//  Created by fetaro on 2015/01/08.
//  Copyright (c) 2015年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit

class UIImageUtil{
    class func rotate(img:UIImage,angle:Int) -> UIImage{
        let img_ref : CGImageRef = img.CGImage
        var context :CGContextRef
        var rotate_image : UIImage
        UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
        context = UIGraphicsGetCurrentContext();
        
        switch angle {
        case 0:
            rotate_image = img
            return rotate_image
        case 90:
            UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
            context = UIGraphicsGetCurrentContext()
            CGContextTranslateCTM(context, img.size.height, img.size.width)
            CGContextScaleCTM(context, CGFloat(1), CGFloat(-1))
            CGContextRotateCTM(context, CGFloat(M_PI / 2))
        case 180:
            UIGraphicsBeginImageContext(CGSizeMake(img.size.width, img.size.height));
            context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.width, 0)
            CGContextScaleCTM(context, CGFloat(1), CGFloat(-1))
            CGContextRotateCTM(context, CGFloat(M_PI * -1))
        case 70:
            UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
            context = UIGraphicsGetCurrentContext();
            CGContextScaleCTM(context, CGFloat(1), CGFloat(-1))
            CGContextRotateCTM(context, CGFloat(M_PI / -2));
        default:
            rotate_image = img
            return rotate_image
        }
        
        CGContextDrawImage(context, CGRectMake(0, 0, img.size.width, img.size.height), img_ref);
        rotate_image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return rotate_image;
    }
}