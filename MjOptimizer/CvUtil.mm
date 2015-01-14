//
//  TemplateMatcher.mm
//  MjOptimizer
//
//  Created by gino on 2014/06/20.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

#import "TemplateMatcher.h"
#import "MatcherResult.h"

#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

@implementation CvUtil : NSObject

- (id)init {
    if (self == [super init]) {
    }
    return self;
}

-(UIImage *)changeDepth:(UIImage *)target matchType:(int)matchType{
    cv::Mat targetMat;
    UIImageToMat(target, targetMat);
    if(matchType >= 1){
        //gray scaleでマッチさせる
        cv::cvtColor(targetMat,targetMat,CV_RGB2GRAY);
        if(matchType >= 2){
            //二値でマッチングさせる
            cv::adaptiveThreshold(targetMat, targetMat, 255, cv::ADAPTIVE_THRESH_GAUSSIAN_C, cv::THRESH_BINARY, 5, 5);
        }
    }
    return MatToUIImage(targetMat);
}

-(void)toBinaryArray:(UIImage *)target result:(int *)result{
    cv::Mat targetMat;
    UIImageToMat(target, targetMat);
    //gray scaleでマッチさせる
    cv::cvtColor(targetMat,targetMat,CV_RGB2GRAY);
    //二値でマッチングさせる
    cv::adaptiveThreshold(targetMat, targetMat, 255, cv::ADAPTIVE_THRESH_GAUSSIAN_C, cv::THRESH_BINARY, 5, 5);
    int x,y,i;
//    int result[targetMat.rows * targetMat.cols];
    i=0;
    printf("%dx%d",targetMat.rows,targetMat.cols);
    for(y = 0;y < targetMat.rows;y++){
        for(x = 0;x < targetMat.cols;x++){
            if (targetMat.data[x + y*targetMat.step] == 0){
                result[i] = 0;
            }else{
                result[i] = 1;
            }
            i++;
        }
    }
    //  return result;
}

@end