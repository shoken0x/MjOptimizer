//
//  PaiListView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/09/02.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class PaiListView:UIView{
    let TATE_W : CGFloat = 24
    let TATE_H : CGFloat = 36
    let YOKO_W : CGFloat = 32
    let YOKO_H : CGFloat = 28
    
    init(paiList:[Pai]){
        let yokoNum = paiList.filter({$0.isYoko}).count
        let tateNum = paiList.filter({!$0.isYoko}).count
        let YOKO_MAX:CGFloat = CGFloat(yokoNum) * YOKO_W + CGFloat(tateNum) * TATE_W
        super.init(frame: CGRectMake(0, 0, YOKO_MAX, TATE_H))
        var nextX : CGFloat = 0
        UIGraphicsBeginImageContext(CGSizeMake( YOKO_MAX , TATE_H)) //描画領域を確保
        for pai in paiList{
            let image: UIImage = UIImage(named:pai.toString())
            if pai.isYoko{
                image.drawAtPoint(CGPointMake(nextX, TATE_H - YOKO_H))
                nextX += YOKO_W
            }else{
                image.drawAtPoint(CGPointMake(nextX, 0))
                nextX += TATE_W
            }
        }
        let paiImage = UIGraphicsGetImageFromCurrentImageContext();//描画領域を代入
        UIGraphicsEndImageContext();//描画領域を解放
        let backImage = UIImageView(image: paiImage)
        backImage.frame = CGRectMake(0, 0, YOKO_MAX, TATE_H)
        self.addSubview(backImage)
        
    }
}