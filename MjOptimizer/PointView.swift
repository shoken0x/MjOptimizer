//
//  PointView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/12/28.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class PointView:UIView{
    
    var pointLabel : UILabel
    
    //役一覧View
    var yakuListView : YakuListView
    let YAKU_LIST_VIEW_X :CGFloat = 0
    let YAKU_LIST_VIEW_Y :CGFloat = 40
    
    //符一覧View
    var fuListView :FuListView
    let FU_LIST_VIEW_X :CGFloat = 150
    let FU_LIST_VIEW_Y :CGFloat = 40
    
    var score : Score
    init(x:CGFloat,y:CGFloat,score:Score){
        self.score = score
        self.pointLabel = UILabel(frame:CGRectMake(0,0,400,40))
        self.yakuListView = YakuListView(x:YAKU_LIST_VIEW_X,y:YAKU_LIST_VIEW_Y,yakuList:score.yakuList ,includeNaki:score.agari.includeNaki())
        self.fuListView = FuListView(x:FU_LIST_VIEW_X,y:FU_LIST_VIEW_Y,mentsuList: score.agari.mentsuList,kyoku:score.kyoku)
        super.init(frame : CGRectMake(x, y, 400, 400))
        self.pointLabel.text = "\(self.score.point.fuNum)符\(self.score.point.hanNum)翻 \(self.score.point.toString())"
        self.addSubview(self.pointLabel)
        self.addSubview(self.yakuListView)
        self.addSubview(self.fuListView)
    }
    
    func update(score:Score){
        self.score = score
        //役一覧を更新
        self.yakuListView.removeFromSuperview()
        self.yakuListView = YakuListView(x:YAKU_LIST_VIEW_X,y:YAKU_LIST_VIEW_Y,yakuList:score.yakuList ,includeNaki:score.agari.includeNaki())
        self.addSubview(self.yakuListView)
        //符一覧を更新
        self.fuListView.removeFromSuperview()
        self.fuListView = FuListView(x:FU_LIST_VIEW_X,y:FU_LIST_VIEW_Y,mentsuList: score.agari.mentsuList,kyoku:score.kyoku)
        self.addSubview(fuListView)
        //得点を更新
        self.pointLabel.text = "\(self.score.point.fuNum)符\(self.score.point.hanNum)翻 \(self.score.point.toString())"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}