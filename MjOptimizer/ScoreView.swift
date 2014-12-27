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
    
    //牌リストView
    var paiListView : PaiListView
    let PAI_LIST_VIEW_X :CGFloat = 0
    let PAI_LIST_VIEW_Y :CGFloat = 40
    
    //得点View
    var pointView : PointView
    let POINT_VIEW_X :CGFloat = 0
    let POINT_VIEW_Y :CGFloat = 100

    
    //局入力View
    let kyokuView : KyokuView

    var score : Score
    
    init(score:Score,paiList:[Pai]){
        self.score = score
        self.paiListView = PaiListView(x:PAI_LIST_VIEW_X,y:PAI_LIST_VIEW_Y,paiList: paiList)
        self.kyokuView = KyokuView(kyoku:score.kyoku)
        self.pointView = PointView(x:POINT_VIEW_X,y:POINT_VIEW_Y,score:score)
        super.init(frame: CGRectMake(0, 0, 568, 600))
        
        //局ラベル
        kyokuLabel = UILabel(frame:CGRectMake(0,0,560,40))
        kyokuLabel.text = score.kyoku.toPrettyString()
        self.addSubview(kyokuLabel)
        
        //局状態変更ボタン
        kyokuInputButton.frame = CGRectMake(300, 0, 200, 40)
        kyokuInputButton.setTitle("状況変更", forState: UIControlState.Normal)
        kyokuInputButton.addTarget(self, action: "kyokuInputButtonDidPush", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(kyokuInputButton)
        
        //手牌画像
        self.addSubview(self.paiListView)
        
        //得点ラベル
        self.addSubview(self.pointView)
        
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
    
    func addYakuLabelList(){
        //TODO
    }
    func addFuLabelList(){
        
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
        
        //TODO再計算
        let scoreCalcResult :ScoreCalcResult = ScoreCalculator.recalc(score)
        switch scoreCalcResult{
        case let .SUCCESS(score):
            //得点計算に成功
            self.score = score
            //得点更新
            self.pointView.update(score)
        case let .ERROR(msg):
            //得点計算に失敗
            Log.info(msg)
        }

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