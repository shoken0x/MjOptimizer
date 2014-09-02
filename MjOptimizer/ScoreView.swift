//
//  ScoreView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/09/01.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class ScoreView:UIView{
    init(agari:Agari){
        super.init(frame: CGRectMake(0, 0, 568, 130))
        self.addSubview(PaiListView(x:0,y:0,paiList: agari.orgPaiList))
        
        
        //得点view
        var scoreView = UILabel(frame:CGRectMake(0,40,300,40))
        scoreView.text = agari.toScoreString()
        self.addSubview(scoreView)
        
        //得点view
        var nextX:CGFloat = 0
        var nextY:CGFloat = 80
        for yaku in agari.yakuList{
            let yakulabel = UILabel(frame:CGRectMake(nextX,nextY,160,40))
            if agari.includeNaki(){
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
        for mentsu in agari.mentsuList{
            let fulabel = UILabel(frame:CGRectMake(nextX,nextY,40,40))
            fulabel.text = String(mentsu.fuNum(agari.kyoku)) + "符"
            self.addSubview( fulabel)
            let paiListView = PaiListView(x: nextX + 40,y:nextY,paiList:mentsu.displayPaiArray())
            self.addSubview( paiListView)
            nextY += 40
        }
    }
}