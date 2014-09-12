//
//  ScoreView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/09/01.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class ScoreView:UIView{
    init(score:Score){
        super.init(frame: CGRectMake(0, 0, 568, 130))
        self.addSubview(PaiListView(x:0,y:0,paiList: score.paiList))
        
        
        //得点view
        var scoreView = UILabel(frame:CGRectMake(0,40,300,40))
        scoreView.text = score.toPointString()
        self.addSubview(scoreView)
        
        //得点view
        var nextX:CGFloat = 0
        var nextY:CGFloat = 80
        for yaku in score.yakuList{
            let yakulabel = UILabel(frame:CGRectMake(nextX,nextY,160,40))
            if score.agari.includeNaki(){
                yakulabel.text = "\(yaku.kanji) (\(yaku.nakiHanNum)翻)"
            }else{
                yakulabel.text = "\(yaku.kanji) (\(yaku.hanNum)翻)"
            }
            self.addSubview( yakulabel)
            nextY += 40
        }
        
        //不計算view
        nextX = 400
        nextY = 80
        for mentsu in score.agari.mentsuList{
            let fulabel = UILabel(frame:CGRectMake(nextX,nextY,40,40))
            fulabel.text = String(mentsu.fuNum(score.kyoku)) + "符"
            self.addSubview( fulabel)
            let paiListView = PaiListView(x: nextX + 40,y:nextY,paiList:mentsu.displayPaiArray())
            self.addSubview( paiListView)
            nextY += 40
        }
    }
}