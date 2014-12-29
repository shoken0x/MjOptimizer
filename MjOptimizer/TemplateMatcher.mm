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

@implementation TemplateMatcher : NSObject

NSMutableDictionary *templates;

+(UIImage *)DetectEdgeWithImage:(UIImage *)image {
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_BGR2GRAY);
    
    cv::Mat edge;
    cv::Canny(gray, edge, 200, 180);
    
    cv::Mat hoge = loadMatFromFile(@"j1.r", @"jpg");
    
    TemplateMatcher *matcher = [[TemplateMatcher alloc] init];
    [matcher matchTarget:image withTemplate:@"s6t"];
    
    UIImage *edgeImg = MatToUIImage(hoge);
    //UIImage *edgeImg = MatToUIImage(edge);
    
    return edgeImg;
}

-(NSMutableArray *)match:(UIImage *)target template:(UIImage *)tpl {
    cv::Mat targetMat;
    UIImageToMat(target, targetMat);
    
    cv::Mat tplMat;
    UIImageToMat(tpl, tplMat);

    NSMutableArray *results = [NSMutableArray array];
    cv::Mat resultMat;
    double maxVal = 1.0;
    double prevVal = 1.0;
    do {
        cv::matchTemplate(targetMat, tplMat, resultMat, CV_TM_CCOEFF_NORMED);
        
        prevVal = maxVal;
        cv::Point maxPt;
        cv::minMaxLoc(resultMat, NULL, &maxVal, NULL, &maxPt);

        if (maxVal > 0.6) {
            MatcherResult *res = [[MatcherResult alloc]init];
            res.x = maxPt.x;
            res.y = maxPt.y;
            res.width = tplMat.cols;
            res.height = tplMat.rows;
            res.value = maxVal;
            [results addObject: res];
            
            cv::rectangle(targetMat, cv::Point(res.x, res.y),
                          cv::Point(res.x + res.width, res.y + res.height),
                          cv::Scalar(255,255,255));
            
        }
    } while (maxVal > 0.6 && prevVal - maxVal > 0);
    
    return results;
}

static cv::Mat loadMatFromFile(NSString *fileBaseName, NSString *type) {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileBaseName ofType:type];
    const char *pathChars = [path UTF8String];
    return cv::imread(pathChars);
}


- (id)init {
    if (self == [super init]) {
        [self setUpTemplate];
    }
    return self;
}

- (void)setUpTemplate {
    templates = [NSMutableDictionary dictionary];
    [templates setObject: [self loadTemplateImage:@"m1.t"] forKey:@"m1t"];
    [templates setObject: [self loadTemplateImage:@"m2.t"] forKey:@"m2t"];
    [templates setObject: [self loadTemplateImage:@"m3.t"] forKey:@"m3t"];
    [templates setObject: [self loadTemplateImage:@"m4.t"] forKey:@"m4t"];
    [templates setObject: [self loadTemplateImage:@"m5.t"] forKey:@"m5t"];
    [templates setObject: [self loadTemplateImage:@"m6.t"] forKey:@"m6t"];
    [templates setObject: [self loadTemplateImage:@"m7.t"] forKey:@"m7t"];
    [templates setObject: [self loadTemplateImage:@"m8.t"] forKey:@"m8t"];
    [templates setObject: [self loadTemplateImage:@"m9.t"] forKey:@"m9t"];
    [templates setObject: [self loadTemplateImage:@"p1.t"] forKey:@"p1t"];
    [templates setObject: [self loadTemplateImage:@"p2.t"] forKey:@"p2t"];
    [templates setObject: [self loadTemplateImage:@"p3.t"] forKey:@"p3t"];
    [templates setObject: [self loadTemplateImage:@"p4.t"] forKey:@"p4t"];
    [templates setObject: [self loadTemplateImage:@"p5.t"] forKey:@"p5t"];
    [templates setObject: [self loadTemplateImage:@"p6.t"] forKey:@"p6t"];
    [templates setObject: [self loadTemplateImage:@"p7.t"] forKey:@"p7t"];
    [templates setObject: [self loadTemplateImage:@"p8.t"] forKey:@"p8t"];
    [templates setObject: [self loadTemplateImage:@"p9.t"] forKey:@"p9t"];
    [templates setObject: [self loadTemplateImage:@"s1.t"] forKey:@"s1t"];
    [templates setObject: [self loadTemplateImage:@"s2.t"] forKey:@"s2t"];
    [templates setObject: [self loadTemplateImage:@"s3.t"] forKey:@"s3t"];
    [templates setObject: [self loadTemplateImage:@"s4.t"] forKey:@"s4t"];
    [templates setObject: [self loadTemplateImage:@"s5.t"] forKey:@"s5t"];
    [templates setObject: [self loadTemplateImage:@"s6.t"] forKey:@"s6t"];
    [templates setObject: [self loadTemplateImage:@"s7.t"] forKey:@"s7t"];
    [templates setObject: [self loadTemplateImage:@"s8.t"] forKey:@"s8t"];
    [templates setObject: [self loadTemplateImage:@"s9.t"] forKey:@"s9t"];
    [templates setObject: [self loadTemplateImage:@"j1.t"] forKey:@"j1t"];
    [templates setObject: [self loadTemplateImage:@"j2.t"] forKey:@"j2t"];
    [templates setObject: [self loadTemplateImage:@"j3.t"] forKey:@"j3t"];
    [templates setObject: [self loadTemplateImage:@"j4.t"] forKey:@"j4t"];
    [templates setObject: [self loadTemplateImage:@"j5.t"] forKey:@"j5t"];
    [templates setObject: [self loadTemplateImage:@"j6.t"] forKey:@"j6t"];
    [templates setObject: [self loadTemplateImage:@"j7.t"] forKey:@"j7t"];

    [templates setObject: [self loadTemplateImage:@"m1.l"] forKey:@"m1l"];
    [templates setObject: [self loadTemplateImage:@"m2.l"] forKey:@"m2l"];
    [templates setObject: [self loadTemplateImage:@"m3.l"] forKey:@"m3l"];
    [templates setObject: [self loadTemplateImage:@"m4.l"] forKey:@"m4l"];
    [templates setObject: [self loadTemplateImage:@"m5.l"] forKey:@"m5l"];
    [templates setObject: [self loadTemplateImage:@"m6.l"] forKey:@"m6l"];
    [templates setObject: [self loadTemplateImage:@"m7.l"] forKey:@"m7l"];
    [templates setObject: [self loadTemplateImage:@"m8.l"] forKey:@"m8l"];
    [templates setObject: [self loadTemplateImage:@"m9.l"] forKey:@"m9l"];
    [templates setObject: [self loadTemplateImage:@"p1.l"] forKey:@"p1l"];
    [templates setObject: [self loadTemplateImage:@"p2.l"] forKey:@"p2l"];
    [templates setObject: [self loadTemplateImage:@"p3.l"] forKey:@"p3l"];
    [templates setObject: [self loadTemplateImage:@"p4.l"] forKey:@"p4l"];
    [templates setObject: [self loadTemplateImage:@"p5.l"] forKey:@"p5l"];
    [templates setObject: [self loadTemplateImage:@"p6.l"] forKey:@"p6l"];
    [templates setObject: [self loadTemplateImage:@"p7.l"] forKey:@"p7l"];
    [templates setObject: [self loadTemplateImage:@"p8.l"] forKey:@"p8l"];
    [templates setObject: [self loadTemplateImage:@"p9.l"] forKey:@"p9l"];
    [templates setObject: [self loadTemplateImage:@"s1.l"] forKey:@"s1l"];
    [templates setObject: [self loadTemplateImage:@"s2.l"] forKey:@"s2l"];
    [templates setObject: [self loadTemplateImage:@"s3.l"] forKey:@"s3l"];
    [templates setObject: [self loadTemplateImage:@"s4.l"] forKey:@"s4l"];
    [templates setObject: [self loadTemplateImage:@"s5.l"] forKey:@"s5l"];
    [templates setObject: [self loadTemplateImage:@"s6.l"] forKey:@"s6l"];
    [templates setObject: [self loadTemplateImage:@"s7.l"] forKey:@"s7l"];
    [templates setObject: [self loadTemplateImage:@"s8.l"] forKey:@"s8l"];
    [templates setObject: [self loadTemplateImage:@"s9.l"] forKey:@"s9l"];
    [templates setObject: [self loadTemplateImage:@"j1.l"] forKey:@"j1l"];
    [templates setObject: [self loadTemplateImage:@"j2.l"] forKey:@"j2l"];
    [templates setObject: [self loadTemplateImage:@"j3.l"] forKey:@"j3l"];
    [templates setObject: [self loadTemplateImage:@"j4.l"] forKey:@"j4l"];
    [templates setObject: [self loadTemplateImage:@"j5.l"] forKey:@"j5l"];
    [templates setObject: [self loadTemplateImage:@"j6.l"] forKey:@"j6l"];
    [templates setObject: [self loadTemplateImage:@"j7.l"] forKey:@"j7l"];

    [templates setObject: [self loadTemplateImage:@"m1.r"] forKey:@"m1r"];
    [templates setObject: [self loadTemplateImage:@"m2.r"] forKey:@"m2r"];
    [templates setObject: [self loadTemplateImage:@"m3.r"] forKey:@"m3r"];
    [templates setObject: [self loadTemplateImage:@"m4.r"] forKey:@"m4r"];
    [templates setObject: [self loadTemplateImage:@"m5.r"] forKey:@"m5r"];
    [templates setObject: [self loadTemplateImage:@"m6.r"] forKey:@"m6r"];
    [templates setObject: [self loadTemplateImage:@"m7.r"] forKey:@"m7r"];
    [templates setObject: [self loadTemplateImage:@"m8.r"] forKey:@"m8r"];
    [templates setObject: [self loadTemplateImage:@"m9.r"] forKey:@"m9r"];
    [templates setObject: [self loadTemplateImage:@"p6.r"] forKey:@"p6r"];
    [templates setObject: [self loadTemplateImage:@"p7.r"] forKey:@"p7r"];
    [templates setObject: [self loadTemplateImage:@"s1.r"] forKey:@"s1r"];
    [templates setObject: [self loadTemplateImage:@"s3.r"] forKey:@"s3r"];
    [templates setObject: [self loadTemplateImage:@"s7.r"] forKey:@"s7r"];
    [templates setObject: [self loadTemplateImage:@"j1.r"] forKey:@"j1r"];
    [templates setObject: [self loadTemplateImage:@"j2.r"] forKey:@"j2r"];
    [templates setObject: [self loadTemplateImage:@"j3.r"] forKey:@"j3r"];
    [templates setObject: [self loadTemplateImage:@"j4.r"] forKey:@"j4r"];
    [templates setObject: [self loadTemplateImage:@"j6.r"] forKey:@"j6r"];
    [templates setObject: [self loadTemplateImage:@"j7.r"] forKey:@"j7r"];
    

    [templates setObject: [self loadTemplateImage:@"m1.b"] forKey:@"m1b"];
    [templates setObject: [self loadTemplateImage:@"m2.b"] forKey:@"m2b"];
    [templates setObject: [self loadTemplateImage:@"m3.b"] forKey:@"m3b"];
    [templates setObject: [self loadTemplateImage:@"m4.b"] forKey:@"m4b"];
    [templates setObject: [self loadTemplateImage:@"m5.b"] forKey:@"m5b"];
    [templates setObject: [self loadTemplateImage:@"m6.b"] forKey:@"m6b"];
    [templates setObject: [self loadTemplateImage:@"m7.b"] forKey:@"m7b"];
    [templates setObject: [self loadTemplateImage:@"m8.b"] forKey:@"m8b"];
    [templates setObject: [self loadTemplateImage:@"m9.b"] forKey:@"m9b"];
    [templates setObject: [self loadTemplateImage:@"p6.b"] forKey:@"p6b"];
    [templates setObject: [self loadTemplateImage:@"p7.b"] forKey:@"p7b"];
    [templates setObject: [self loadTemplateImage:@"s1.b"] forKey:@"s1b"];
    [templates setObject: [self loadTemplateImage:@"s3.b"] forKey:@"s3b"];
    [templates setObject: [self loadTemplateImage:@"s7.b"] forKey:@"s7b"];
    [templates setObject: [self loadTemplateImage:@"j1.b"] forKey:@"j1b"];
    [templates setObject: [self loadTemplateImage:@"j2.b"] forKey:@"j2b"];
    [templates setObject: [self loadTemplateImage:@"j3.b"] forKey:@"j3b"];
    [templates setObject: [self loadTemplateImage:@"j4.b"] forKey:@"j4b"];
    [templates setObject: [self loadTemplateImage:@"j6.b"] forKey:@"j6b"];
    [templates setObject: [self loadTemplateImage:@"j7.b"] forKey:@"j7b"];

}

-(UIImage *)loadTemplateImage:(NSString *)key {
    NSString *path = [[NSBundle mainBundle] pathForResource:key ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:path];
}


-(NSMutableArray *)matchTarget:(UIImage *)target withTemplate:(NSString *)key {
    UIImage *tpl = (UIImage *)[templates objectForKey:key];
    NSMutableArray *hoge = [self match:target template:tpl];
    return hoge;
}

@end