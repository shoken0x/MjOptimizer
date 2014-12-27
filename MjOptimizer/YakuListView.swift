//
//  YakuListView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/10.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class YakuListView:UIView{
    
    let WIDTH : CGFloat = 160
    let HEIGHT_UNIT : CGFloat = 20
    init(x:CGFloat,y:CGFloat,yakuList:[Yaku],includeNaki:Bool){
        super.init(frame : CGRectMake(x, y, WIDTH, HEIGHT_UNIT * CGFloat(yakuList.count)))
        var nextX:CGFloat = 0
        var nextY:CGFloat = 0
        for yaku in yakuList{
            let yakulabel = UILabel(frame:CGRectMake(nextX,nextY,WIDTH,HEIGHT_UNIT))
            var hanstr:String
            if (includeNaki){
                if (yaku.nakiHanNum != yaku.hanNum){
                    hanstr = "\(yaku.nakiHanNum)翻(食下り)"
                }else{
                    hanstr = "\(yaku.nakiHanNum)翻"
                }
            }else{
                hanstr = "\(yaku.hanNum)翻"
            }
            yakulabel.text = yaku.kanji + ":" + hanstr 
            self.addSubview( yakulabel)
            nextY += HEIGHT_UNIT
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}