//
//  ScoreView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/09/01.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class ScoreView:UIView{
    var width:  CGFloat = 700
    var height: CGFloat = 200
    var imageX: CGFloat = 10
    var imageY: CGFloat = 30
    var deltaX: CGFloat = 44

    init(agari:Agari){
        super.init(frame: CGRectMake(0, 0, 568, 130))
        for mentsu in agari.mentsuList{
            UIGraphicsBeginImageContext(CGSizeMake(width, height))
            for pai in mentsu.paiArray(){
                println(pai.toString())
                let image: UIImage = UIImage(named:pai.toString())
                image.drawAtPoint(CGPointMake(imageX, imageY))
                imageX += deltaX
            }
            let paiImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            let backImage = UIImageView(image: paiImage)
            backImage.frame = CGRectMake(0, 0, width * 0.5, height * 0.5)
            self.addSubview(backImage)
            
        }
    }
}