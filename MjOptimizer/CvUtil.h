//
//  CvUtil.h
//  MjOptimizer
//
//  Created by fetaro on 2015/01/11.
//  Copyright (c) 2015年 Shoken Fujisaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface CvUtil : NSObject
-(UIImage *)changeDepth:(UIImage *)target matchType:(int) matchType;
-(void)toBinaryArray:(UIImage *)target result:(int *)result;
@end