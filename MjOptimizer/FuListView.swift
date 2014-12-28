//
//  FuListView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/28.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class FuListView:UIView{
    
    let WIDTH : CGFloat = 160
    let HEIGHT_UNIT : CGFloat = 30
    init(x:CGFloat,y:CGFloat,mentsuList:[Mentsu],kyoku:Kyoku){
        super.init(frame : CGRectMake(x, y, WIDTH, HEIGHT_UNIT * CGFloat(mentsuList.count)))
        var nextX:CGFloat = 0
        var nextY:CGFloat = 0
        
        for mentsu in mentsuList{
            let fulabel = UILabel(frame:CGRectMake(nextX,nextY,40,HEIGHT_UNIT))
            fulabel.text = String(mentsu.fuNum(kyoku)) + "符"
            self.addSubview( fulabel)
            let paiListView = PaiListView(x: nextX + 40,y:nextY,paiList:mentsu.displayPaiArray())
            self.addSubview( paiListView)
            nextY += HEIGHT_UNIT
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}