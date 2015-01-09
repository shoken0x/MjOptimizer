//
//  ImageSplitter.swift
//  MjOptimizer
//
//  Created by fetaro on 2015/01/09.
//  Copyright (c) 2015年 Shoken Fujisaki. All rights reserved.
//

import Foundation

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

class RectsInImage{
    var verRectList : [CGRect] = [];
    var horRectList : [CGRect] = [];
    var verFilledRectList : [CGRect] = [];
    var horFilledRectList : [CGRect] = [];
}

class ImageSplitter{
    // @imageMat 白黒二値の行列
    // @in_width 探したい白長方形の横幅
    // @in_height 探したい長方形の立て幅
    class func detectRectangle(binary_image : Matrix,in_width:Int,in_height:Int) -> RectsInImage {
        
        var rect_w: Int; //検出する長方形の横幅
        var rect_h: Int//検出する長方形の縦幅
        var rect_b: Int = 1; //検出する長方形の境界線の幅
        var white_line_thre : Float = 0.99;//長方形の辺上にこの割合以上白点がある場合採用
        
        let internal_scan_span : Int = 3;//内側の黒点を探すときの間隔
        let internal_black_thre : Float = 0.1;//内側の黒点の割合のしきい値。これより多ければ白以外と見なす
        let internal_haku_thre : Float = 0.001;//内側の黒点の割合のしきい値。これより少なければ白と見なす
        let search_ratio : Float = 1.1; // 実画像の何倍まで探すか.0.01刻みでスキャン
        
        var sr_i : Float;
        var xi, yi ,i,j, st_x, st_y, line_whity_score, internal_black_no, internal_point_no, dire_i : Int
        
        var result : RectsInImage = RectsInImage();
        var result_type : Int;
        for(dire_i=0;dire_i<2;dire_i++){
            for(sr_i = 1; sr_i <= search_ratio; sr_i += 0.01){//1%ごとに長方形を拡大してスキャン
                if(dire_i == 0){
                    //縦向きの牌をスキャン
                    rect_w = Int(Float(in_width)  * sr_i) ;
                    rect_h = Int(Float(in_height) * sr_i) ;
                }else{
                    //横向きの牌をスキャン
                    rect_h = Int(Float(in_width)  * sr_i) ;
                    rect_w = Int(Float(in_height) * sr_i) ;
                }
                for (st_y = 0; st_y < binary_image.rows - rect_h - rect_b ; st_y++) {
                    for (st_x = 0; st_x < binary_image.columns - rect_w - rect_b; st_x++) {
                        line_whity_score = 0;
                        //上辺がすべて白いか計算
                        for(xi = st_x;xi < st_x + rect_w; xi++){
                            for(i=0;i<rect_b;i++){
                                if( binary_image[xi,st_y + i] != 0 ){ line_whity_score++; } //白点を見つけたら
                            }
                        }
                        //下辺がすべて白いか計算
                        for(xi = st_x;xi < st_x + rect_w; xi++){
                            for(i=0;i<rect_b;i++){
                                if( binary_image[xi,st_y + rect_h + i] != 0 ){ line_whity_score++; } //白点を見つけたら
                            }
                        }
                        //左辺がすべて白いか計算
                        for(yi = st_y;yi < st_y + rect_h; yi++){
                            for(i=0;i<rect_b;i++){
                                if( binary_image[st_x + i,yi] != 0 ){ line_whity_score++; } //白点を見つけたら
                            }
                        }
                        //右辺がすべて白いか計算
                        for(yi = st_y;yi < st_y + rect_h; yi++){
                            for(i=0;i<rect_b;i++){
                                if( binary_image[st_x + rect_w + i,yi] != 0 ){ line_whity_score++; } //白点を見つけたら
                            }
                        }
                        
                        //長方形の中が白だけではないか計算
                        internal_point_no = 0;
                        internal_black_no = 0;
                        for(xi = st_x;xi < st_x + rect_w; xi += internal_scan_span){
                            for(yi = st_y;yi < st_y + rect_h; yi += internal_scan_span){
                                internal_point_no++;
                                if(binary_image[xi,yi] == 0){ internal_black_no++;} //黒点を見つけた
                            }
                        }
                        let rect : CGRect = CGRectMake(CGFloat(st_x),CGFloat(st_y),CGFloat(rect_w),CGFloat(rect_h))
                        if ( line_whity_score >=
                            Int(Float(( rect_w * 2 + rect_h * 2 ) * rect_b) * white_line_thre )){
                                if( internal_black_no > Int(Float(internal_point_no) * internal_black_thre)){
                                    if(dire_i == 0){
                                        //縦向きの白以外を見つけた
                                        result_type = 0;
                                        result.verRectList.append(rect)
                                    }else{
                                        //横向きの白以外を見つけた
                                        result_type = 1;
                                        result.horRectList.append(rect)
                                    }
                                    
                                }else if (internal_black_no > Int(Float(internal_point_no) * internal_haku_thre)){
                                    if(dire_i == 0){
                                        //縦向きの白を見つけた
                                        result_type = 2;
                                        result.verFilledRectList.append(rect)
                                    }else{
                                        //横向きの白を見つけた
                                        result_type = 3;
                                        result.horFilledRectList.append(rect)
                                    }
                                }else{
                                }
                        }
                    } //end st_x
                } //end st_y
            }//end sr_i
        }
    return result
    }
}

