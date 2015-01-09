//
//  TemplateImage.swift
//  MjOptimizer
//
//  Created by fetaro on 2015/01/08.
//  Copyright (c) 2015年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class TemplateImage{
    let pai:Pai
    let trimed:Bool //牌画像をトリミングした画像を使う場合はtrue
    let uiimage:UIImage
    let assetName: String
    let no: Int // 同一の牌の種類で複数のテンプレートがある場合はここを1以外にする
    init(_ paiStr: String, _ trimed:Bool, _ no:Int = 1){
        self.pai = Pai.parse(paiStr)!
        self.trimed = trimed
        self.no = no
        self.assetName = "tpl-" + self.pai.toShortStr() + (no == 1 ? "" : "_\(no)" ) + ( trimed ? "-trimed" : "" ) + ".jpg"
        let tmp = UIImage(named:self.assetName)!
        //TODO direction
        switch self.pai.direction{
        case .TOP:     self.uiimage = tmp
        case .RIGHT:   self.uiimage = UIImageUtil.rotate(tmp,angle:90)
        case .BOTTOM:  self.uiimage = UIImageUtil.rotate(tmp,angle:180)
        case .LEFT:    self.uiimage = UIImageUtil.rotate(tmp,angle:270)
        }
    }
}