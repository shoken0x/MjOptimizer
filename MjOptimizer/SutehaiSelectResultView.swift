//
//  ResultView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
class SutehaiSelectResultView:UIView{
    let headerLabel = UILabel(frame: CGRectMake(0, 0, 500, 30))
    let resultView = UIView(frame: CGRectMake(0, 0, 568, 130))

    init(sutehaiCandidateList: [SutehaiCandidate]){
        super.init(frame:CGRect(x: 0, y: 0, width: 700, height: 50 * 4))
        //ヘッダ
        self.headerLabel.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        self.headerLabel.textColor = UIColor.redColor()
        self.headerLabel.text = "  捨牌      受入牌種                総枚数         シャンテン数"
        self.addSubview(headerLabel)
        //ボディ
        self.resultView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.addSubview(resultView)
        
        var x: CGFloat = 5
        var y: CGFloat = 15
        var limit = 3
        var i = 0
        for sutehaiCandidate: SutehaiCandidate in sutehaiCandidateList {
            drawMjImages(x, y, [sutehaiCandidate.pai])
            drawMjImages(x + 50, y,
                sutehaiCandidate.getUkeirePaiToPaiList())
            let totalNumLabel =   UILabel(frame: CGRectMake(x + 215, y + 15, 20, 20))
            totalNumLabel.textColor = UIColor.greenColor()
            totalNumLabel.text = String(sutehaiCandidate.getUkeireTotalNum())
            self.addSubview(totalNumLabel)
            
            let shantenNumLabel = UILabel(frame: CGRectMake(x + 305, y + 15, 20, 20))
            shantenNumLabel.textColor = UIColor.greenColor()
            shantenNumLabel.text = String(sutehaiCandidate.getShantenNum())
            self.addSubview(shantenNumLabel)
            y += 30
            i += 1
            if i > limit { break }
        }
    }
    func drawMjImages(x: CGFloat, _ y: CGFloat, _ paiArray: [Pai], _ rate: CGFloat = 0.5) {
        var width:  CGFloat = 700
        var height: CGFloat = 200
        var imageX: CGFloat = 10
        var imageY: CGFloat = 30
        var deltaX: CGFloat = 44
        
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        for pai in paiArray  {
            let image: UIImage = UIImage(named:pai.toString())
            image.drawAtPoint(CGPointMake(imageX, imageY))
            imageX += deltaX
        }
        let paiImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        let backImage = UIImageView(image: paiImage)
        backImage.frame = CGRectMake(x, y, width * rate, height * rate)
        self.addSubview(backImage)
    }
}