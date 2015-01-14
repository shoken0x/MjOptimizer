//
//  DetectRect.c
//  MjOptimizer
//
//  Created by fetaro on 2015/01/15.
//  Copyright (c) 2015年 Shoken Fujisaki. All rights reserved.
//

#include "DetectRect.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

/*
 * 左上の座標と長方形の大きさを入力して、白い長方形を見つける
 * @return -1: 見つけられず 0:ハク以外を見つけた 1:ハクを見つけた
 */
int scanRectangle(int* in_binary,int in_binary_w,int in_binary_h,int rect_w, int rect_h, int st_x, int st_y) {
    //printf("scan [%d,%d] %dx%d\n",st_x,st_y,rect_w,rect_h);
    int rect_b = 1;//スキャンする線の太さ。太いと内側にスキャン幅が広がる
    double white_line_thre = 0.99;//長方形の辺上にこの割合以上白点がある場合採用
    
    int internal_scan_span = 2;//内側の黒点を探すときの間隔
    double internal_normal_thre = 0.9;//内側の白点の割合のしきい値。これより小さければ白以外と見なす
    double internal_haku_thre = 0.999;//内側の白点の割合のしきい値。これより大きければハクと見なす
    
    int xi, yi ,i,line_whity_no, internal_white_no, internal_point_no;
    
    line_whity_no = 0;
    //上辺の白点の数を計算
    for(xi = st_x;xi < st_x + rect_w; xi++){
        for(i=0;i<rect_b;i++){
            line_whity_no += in_binary[xi + in_binary_w * (st_y + i) ];
        }
    }
    //下辺の白点の数を計算
    for(xi = st_x;xi < st_x + rect_w; xi++){
        for(i=0;i<rect_b;i++){
            line_whity_no += in_binary[xi + (st_y + rect_h - i) * in_binary_w];
        }
    }
    //左辺の白点の数を計算
    for(yi = st_y;yi < st_y + rect_h; yi++){
        for(i=0;i<rect_b;i++){
            line_whity_no += in_binary[st_x + i + yi * in_binary_w];
        }
    }
    //右辺の白点の数を計算
    for(yi = st_y;yi < st_y + rect_h; yi++){
        for(i=0;i<rect_b;i++){
            line_whity_no += in_binary[st_x + rect_w - i + yi * in_binary_w];
        }
    }
    
    if ( line_whity_no >= ( rect_w * 2 + rect_h * 2 ) * rect_b * white_line_thre ){
        //辺上の白点の数がしきい値以上＝白い長方形を発見
        
        //長方形の中の白点の割合を計算
        internal_point_no = 0;
        internal_white_no = 0;
        for(xi = st_x;xi < st_x + rect_w; xi+= internal_scan_span){
            for(yi = st_y;yi < st_y + rect_h; yi+= internal_scan_span){
                internal_point_no++;
                internal_white_no += in_binary[xi + yi * in_binary_w];
            }
        }
        
        if( internal_white_no <= internal_point_no * internal_normal_thre){
            //白点の割合が少ない＝ハク以外を見つけた
            return 0;
        }else if ( internal_white_no >= internal_point_no * internal_haku_thre){
            //白点の割合が多い＝ハクを見つけた
            return 1;
        }
    }
    return -1;
}


/*
 * 白い長方形を検出する
 * @in_binary 黒が0 白が1 の配列
 * @in_binary_w @in_binary_h 入力の横幅たて幅
 * @in_rect_w @in_rect_h 検索対象の長方形の大きさ
 * @pai_no 牌の枚数　この枚数まで検知したら終わる
 */
int detect_rects_sub(int* in_binary,int in_binary_w,int in_binary_h,int in_rect_w, int in_rect_h,int pai_no,pai_rect_t* pai_rects) {
    
    //変数
    int st_x, st_y, rect_w,rect_h,find_fg;
    int pai_direction_type;
    int pai_rects_no = 0;
    st_x = 0;
    st_y = 0;
    for (st_x=0; st_x < in_binary_w ; st_x++) {
        find_fg = 0;
        for (st_y=0;st_y < find_fg == 0 && st_y< in_binary_h ;st_y++) {
            if(st_x < in_binary_w - in_rect_w && st_y< in_binary_h - in_rect_h){
                //縦向きの長方形を探す
                rect_w = in_rect_w ;
                rect_h = in_rect_h ;
                pai_direction_type = scanRectangle(in_binary, in_binary_w, in_binary_h, rect_w, rect_h, st_x, st_y);
                if(pai_direction_type >=0){
                    //長方形を見つけた
                    pai_rects[pai_rects_no].x = st_x;
                    pai_rects[pai_rects_no].y = st_y;
                    pai_rects[pai_rects_no].w = rect_w;
                    pai_rects[pai_rects_no].h = rect_h;
                    pai_rects[pai_rects_no].type = pai_direction_type * 2;
                    pai_rects_no++;
                    
                    //次のスキャン開始点を、今見つけた長方形の右側、かつy=0から始める
                    //printf("find v-rect : [%d,%d]\n",st_x,st_y);
                    st_x = st_x + rect_w ;
                    find_fg = 1;
                }
            }
            if(find_fg == 0 && st_x < in_binary_w - in_rect_h && st_y< in_binary_h - in_rect_w){
                //横向きの長方形を探す
                rect_h = in_rect_w ;
                rect_w = in_rect_h ;
                pai_direction_type = scanRectangle(in_binary, in_binary_w, in_binary_h, rect_w, rect_h, st_x, st_y);
                if(pai_direction_type >=0){
                    //長方形を見つけた
                    pai_rects[pai_rects_no].x = st_x;
                    pai_rects[pai_rects_no].y = st_y;
                    pai_rects[pai_rects_no].w = rect_w;
                    pai_rects[pai_rects_no].h = rect_h;
                    pai_rects[pai_rects_no].type = pai_direction_type * 2 + 1;
                    pai_rects_no++;
                    
                    //次のスキャン開始点を、今見つけた長方形の右側、かつy=0から始める
                    //printf("find h-rect : [%d,%d]\n",st_x,st_y);
                    st_x = st_x + rect_w ;
                    find_fg = 1;
                }
            }
            if(pai_rects_no == pai_no){
                //目的の数だけ牌を見つけたので終わる
                return pai_rects_no;
            }
        }
    }
    
    return pai_rects_no;
}

/*
 * 最適なサイズで白い長方形を検出する
 * @in_binary 黒が0 白が1 の配列
 * @in_binary_w @in_binary_h 入力の横幅たて幅
 * @in_rect_h 検索対象の牌の高さ
 * @in_pai_no 牌の枚数　この枚数まで検知したら終わる
 * return 検出したぱいのかず
 */
int detect_rects(int* in_binary,int in_binary_w,int in_binary_h,int in_pai_h,int in_pai_no,pai_rect_t* out_pai_rects) {
    int margin = 4; //牌の高さよりも検出する白い長方形は小さい。その幅
    int serch_span = 3;
    int min_pai_h = in_pai_h - margin - serch_span;
    int max_pai_h = in_pai_h - margin + serch_span;
    
    int pai_w,pai_h,pai_rect_no,i;
    
    int pai_rect_no_max = 0;
    pai_rect_t tmp[in_pai_no];
    
    //牌の大きさをかえながら検出を繰り返して、もっとも検出結果の大きいサイズの結果を返す
    for(pai_h = min_pai_h; pai_h <= max_pai_h; pai_h++){
        pai_w = (int)pai_h/1.375;
        pai_rect_no = detect_rects_sub(in_binary,in_binary_w,in_binary_h,pai_w, pai_h,in_pai_no,tmp);
        printf("number of detected rect(%dx%d) = %d\n",pai_w,pai_h,pai_rect_no);
        if(pai_rect_no > pai_rect_no_max){
            pai_rect_no_max = pai_rect_no;
            for(i=0;i<pai_rect_no;i++){
                out_pai_rects[i] = tmp[i];
            }
            if(pai_rect_no_max == in_pai_no){break;}
        }
    }
    return pai_rect_no_max;
    
}

//int main(int argc, const char * argv[]) {
//    int i;
//    
//    IplImage* input = cvLoadImage("/Users/fetaro/tmp/dummyphoto10.png",CV_LOAD_IMAGE_GRAYSCALE); int pai_no = 16;    int pai_h = 48;
//    //IplImage* input = cvLoadImage("/Users/fetaro/tmp/dummyphoto11.png",CV_LOAD_IMAGE_GRAYSCALE); int pai_no = 16; int pai_h = 48;
//    //IplImage* input = cvLoadImage("/Users/fetaro/tmp/dummyphoto12.png",CV_LOAD_IMAGE_GRAYSCALE); int pai_no = 14;    int pai_h = 48;
//    
//    //二値変換
//    int bin_ary[input->width * input->height];
//    convertBinaryArray(input,bin_ary);
//    
//    //debug print
//    printf("input image = %dx%d\n",input->width,input->height);
//    for (i = 0; i < input->height * input->width; i++) {
//        if(i % input->width == 0){
//            printf("\n");
//        }
//        if(bin_ary[i]==0){
//            printf("0");
//        }else{
//            printf(" ");
//        }
//    }
//    
//    //長方形検出
//    pai_rect_t pai_rects[pai_no];
//    int pai_rect_no;
//    pai_rect_no = detect_rects(bin_ary,input->width,input->height,pai_h,pai_no,pai_rects);
//    
//    //debug print
//    IplImage* input_view;
//    cvNamedWindow("input_view",CV_WINDOW_AUTOSIZE);
//    for(i=0;i<pai_rect_no;i++){
//        printf("[%d,%d]%dx%d(%d)\n",pai_rects[i].x,pai_rects[i].y,pai_rects[i].w,pai_rects[i].h,pai_rects[i].type);
//        if(pai_rects[i].type < 2){
//            //ハク以外
//            cvRectangle(input, cvPoint(pai_rects[i].x,pai_rects[i].y), cvPoint(pai_rects[i].x + pai_rects[i].w,pai_rects[i].y + pai_rects[i].h), cvScalar(0, 255, 0, 0), 1, 1, 0);
//        }else{
//            //ハク
//            cvRectangle(input, cvPoint(pai_rects[i].x,pai_rects[i].y), cvPoint(pai_rects[i].x + pai_rects[i].w,pai_rects[i].y + pai_rects[i].h), cvScalar(0, 255, 255, 0), 2, 1, 0);
//        }
//    }
//    cvShowImage("input_view",input);
//    cvWaitKey(0);
//    cvReleaseImage( &input_view );
//    cvDestroyWindow("win1");
//}



