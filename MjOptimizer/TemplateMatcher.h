//
//  TemplateMatcher.h
//  MjOptimizer
//
//  Created by gino on 2014/06/20.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TemplateMatcher : NSObject
+(UIImage *)DetectEdgeWithImage:(UIImage *)image;
-(NSMutableArray *)matchTarget:(UIImage *)target withTemplate:(NSString *)key;
@end