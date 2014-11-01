//
//  ScoreView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/09/01.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class ScoreView:UIView{
    let kyokuInputButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let kyokuOKButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    let kyokuCancelButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
    var kyokuLabel = UILabel()
    let kyokuView : KyokuView
    let score : Score
    init(score:Score){
        self.score = score
        self.kyokuView = KyokuView(kyoku:score.kyoku)

        super.init(frame: CGRectMake(0, 0, 568, 600))
        
        //局ラベル
        kyokuLabel = UILabel(frame:CGRectMake(0,0,560,40))
        kyokuLabel.text = score.kyoku.toPrettyString()
        self.addSubview(kyokuLabel)
        
        //局状態変更ボタン
        kyokuInputButton.frame = CGRectMake(400, 0, 200, 40)
        kyokuInputButton.setTitle("状況変更", forState: UIControlState.Normal)
        kyokuInputButton.addTarget(self, action: "kyokuInputButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(kyokuInputButton)
        
        //手牌画像
        self.addSubview(PaiListView(x:0,y:40,paiList: score.paiList))

        //得点ラベル
        var scoreView = UILabel(frame:CGRectMake(40,80,300,40))
        scoreView.text = score.toPointString()
        self.addSubview(scoreView)
        
        //役一覧
        var nextX:CGFloat = 0
        var nextY:CGFloat = 120
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
        
        //符計算
        nextX = 400
        nextY = 120
        for mentsu in score.agari.mentsuList{
            let fulabel = UILabel(frame:CGRectMake(nextX,nextY,40,40))
            fulabel.text = String(mentsu.fuNum(score.kyoku)) + "符"
            self.addSubview( fulabel)
            let paiListView = PaiListView(x: nextX + 40,y:nextY,paiList:mentsu.displayPaiArray())
            self.addSubview( paiListView)
            nextY += 40
        }

        //局OKボタン
        kyokuOKButton.frame = CGRectMake(0, 50 * 4, 200, 100)
        kyokuOKButton.setTitle("OK", forState: UIControlState.Normal)
        kyokuOKButton.addTarget(self, action: "kyokuOKButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)

        //局キャンセルボタン
        kyokuCancelButton.frame = CGRectMake(200, 50 * 4, 200, 100)
        kyokuCancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        kyokuCancelButton.addTarget(self, action: "kyokuCancelButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //「局の状態を変更」ボタンを押したとき
    func kyokuInputButtonDidPush(){
        Log.info("kyokuInput")
        self.addSubview(self.kyokuView)
        self.addSubview(self.kyokuOKButton)
        self.addSubview(self.kyokuCancelButton)
    }
    
    //OKボタン
    func kyokuOKButtonDidPush(){
        Log.info("OK")
        self.kyokuView.removeFromSuperview()
        self.kyokuOKButton.removeFromSuperview()
        self.kyokuCancelButton.removeFromSuperview()
        //局を更新
        self.kyokuView.commit()
        self.score.kyoku = self.kyokuView.getKyoku()
        kyokuLabel.text = score.kyoku.toPrettyString()
        
        //再計算
        
    }
    //Cancelボタン
    func kyokuCancelButtonDidPush(){
        Log.info("canceled")
        self.kyokuView.removeFromSuperview()
        self.kyokuOKButton.removeFromSuperview()
        self.kyokuCancelButton.removeFromSuperview()
        self.kyokuView.rollback()
    }
}