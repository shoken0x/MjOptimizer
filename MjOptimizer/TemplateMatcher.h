//
//  TemplateMatcher.h
//  MjOptimizer
//
//  Created by gino on 2014/06/20.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface TemplateMatcher : NSObject
-(NSMutableArray *)match:(UIImage *)target template:(UIImage *)tpl matchType:(int)matchType matchThre:(double)matchThre;
-(UIImage *)changeDepth:(UIImage *)target matchType:(int) matchType;
@end