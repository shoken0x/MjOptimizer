//
//  Stats.h
//
//  Created by shu223 on 11/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


//@interface Stats : UILabel
@interface Stats : NSObject 

+ (void)printHierarchyInApp;
+ (void)printHierarchyInView:(UIView *)view;
- (unsigned int)getFreeMemory;
- (NSString *)updateStates;

@end