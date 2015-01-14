//
//  DetectRect.h
//  MjOptimizer
//
//  Created by fetaro on 2015/01/15.
//  Copyright (c) 2015年 Shoken Fujisaki. All rights reserved.
//

#ifndef __MjOptimizer__DetectRect__
#define __MjOptimizer__DetectRect__

#include <stdio.h>

typedef struct{
    int x;
    int y;
    int w;
    int h;
    int type; //0:縦ハク以外、1:横ハク以外、2:縦ハク、3:横ハク
}pai_rect_t;

int scanRectangle(int* in_binary,int in_binary_w,int in_binary_h,int rect_w, int rect_h, int st_x, int st_y);
int detect_rects_sub(int* in_binary,int in_binary_w,int in_binary_h,int in_rect_w, int in_rect_h,int pai_no,pai_rect_t* pai_rects);
int detect_rects(int* in_binary,int in_binary_w,int in_binary_h,int in_pai_h,int in_pai_no,pai_rect_t* out_pai_rects);


#endif /* defined(__MjOptimizer__DetectRect__) */
