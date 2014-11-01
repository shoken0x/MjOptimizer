//
//  KyokuView.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/25.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
import UIKit

class KyokuView: UIView {
    
    let isReachView     = SwitchView(x: 0, y: 50 * 0,name:"リーチ")
    let isIppatsuView   = SwitchView(x: 120, y: 50 * 0,name:"一発")
    let isTsumoView     = IsTsumoView(x: 240, y: 50 * 0)
    let doraNumView     = NumStepperView(x: 0, y: 50 * 1,name:"ドラ")
    let honbaNumView    = NumStepperView(x: 240, y: 50 * 1,name:"本場")
    let jikazeView      = KazeSelectorView(x: 0, y: 50 * 2,name:"自風")
    let bakazeView      = KazeSelectorView(x: 240, y: 50 * 2,name:"場風")
    let finishTypeView  = FinishTypeSelectorView(x: 0, y: 50 * 3)
    var kyoku : Kyoku
    init(kyoku:Kyoku){
        self.kyoku = kyoku
        super.init(frame: CGRectMake(0, 0, 700, 50 * 4))
        let color = UIColor.grayColor()
        self.backgroundColor = color.colorWithAlphaComponent(0.85)
        
        commit();
        
        self.addSubview(self.isReachView)
        self.addSubview(self.isIppatsuView)
        self.addSubview(self.isTsumoView)
        self.addSubview(self.doraNumView)
        self.addSubview(self.honbaNumView)
        self.addSubview(self.jikazeView)
        self.addSubview(self.bakazeView)
        self.addSubview(self.finishTypeView)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //デフォルトに戻す
    internal func clear(){
        self.kyoku = Kyoku()
        commit()
    }
    //画面の内容をデータに戻す
    internal func rollback(){
        self.isReachView.setCtrl(kyoku.isReach)
        self.isIppatsuView.setCtrl(kyoku.isIppatsu)
        self.isTsumoView.setCtrl(kyoku.isTsumo)
        self.doraNumView.setCtrl(kyoku.doraNum)
        self.honbaNumView.setCtrl(kyoku.honbaNum)
        self.jikazeView.setCtrl(kyoku.jikaze)
        self.bakazeView.setCtrl(kyoku.bakaze)
        self.finishTypeView.setCtrl(kyoku.finishType)
    }
    //画面の内容でデータを更新する
    internal func commit(){
        self.kyoku.isReach = isReachView.value()
        self.kyoku.isIppatsu = isIppatsuView.value()
        self.kyoku.isTsumo = isTsumoView.value()
        self.kyoku.doraNum = doraNumView.value()
        self.kyoku.honbaNum = honbaNumView.value()
        self.kyoku.bakaze = bakazeView.value()
        self.kyoku.jikaze = jikazeView.value()
        self.kyoku.finishType = finishTypeView.value()
    }
    //画面・データともに更新する
    internal func setKyoku(kyoku:Kyoku){
        self.kyoku = kyoku
        commit()
    }
    
    internal func getKyoku() -> Kyoku{
        return self.kyoku
    }
    
}


class SwitchView:UIView{
    var label = UILabel()
    var ctrl = UISwitch()
    init(x:Int, y:Int, name:String){
        super.init(frame:CGRect(x: x, y: y, width: 180, height: 40))
        self.label = UILabel(frame:CGRect(x: 0, y: 0, width: 60, height: 40))
        self.label.text = name
        self.addSubview(self.label)
        self.ctrl = UISwitch(frame:CGRect(x: 60, y: 0, width: 120, height: 40))!
        self.ctrl.addTarget(self,action: "update",forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(self.ctrl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(){
        println(self.ctrl.on)
    }
    func value() -> Bool{
        return self.ctrl.on
    }
    func setCtrl(b:Bool){
        self.ctrl.setOn(b, animated: true)
    }
}

class IsTsumoView:UIView{
    var label = UILabel()
    var ctrl = UISegmentedControl(items:["ロン","ツモ"])!
    init(x:Int, y:Int){
        super.init(frame:CGRect(x: x, y: y, width: 180, height: 40))
        self.label = UILabel(frame:CGRect(x: 0, y: 0, width: 60, height: 40))
        self.label.text = "アガリ"
        self.addSubview(self.label)
        self.ctrl.frame = CGRect(x: 60, y: 0, width: 80, height: 40)
        self.ctrl.selectedSegmentIndex = 0
        self.ctrl.addTarget(self,action: "update",forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(self.ctrl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(){
        println(self.ctrl.selectedSegmentIndex == 0 ? "ロン" : "ツモ")
    }
    func value() -> Bool{ //ツモならtrue ロンならfalse
        return self.ctrl.selectedSegmentIndex == 1
    }
    func setCtrl(isTsumo:Bool){
        ctrl.selectedSegmentIndex = isTsumo ? 0 : 1
    }
}

class NumStepperView: UIView{
    var label = UILabel()
    var num = UILabel()
    var ctrl = UIStepper()
    init(x:Int, y:Int, name:String){
        super.init(frame:CGRect(x: x, y: y, width: 240, height: 40))
        self.label = UILabel(frame:  CGRect(x:  0, y: 0, width:  40, height: 40))
        self.label.text = name
        self.addSubview(self.label)
        self.num = UILabel(frame:  CGRect(x:  40, y: 0, width:  20, height: 40))
        self.num.text = "0"
        self.addSubview(self.num)
        self.ctrl = UIStepper(frame:CGRect(x: 60, y: 0, width: 180, height: 40))
        self.ctrl.addTarget(self,action: "update",forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.ctrl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(){
        println(String(Int(self.ctrl.value)))
        self.num.text = String(Int(self.ctrl.value))
    }
    func value() -> Int{
        return Int(self.ctrl.value)
    }
    func setCtrl(num:Int){
        self.num.text = String(num)
    }
}

class KazeSelectorView:UIView{
    let kazeList : [Kaze] = [Kaze.TON,Kaze.NAN,Kaze.SHA,Kaze.PEI]
    var label = UILabel()
    var ctrl = UISegmentedControl(items:["東","南","西","北"])!
    init(x:Int, y:Int, name:String){
        super.init(frame:CGRect(x: x, y: y, width: 220, height: 40))
        self.label = UILabel(frame:CGRect(x: 0, y: 0, width: 60, height: 40))
        self.label.text = name
        self.addSubview(self.label)
        self.ctrl.frame = CGRect(x: 60, y: 0, width: 160, height: 40)
        self.ctrl.selectedSegmentIndex = 0
        self.ctrl.addTarget(self,action: "update",forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(self.ctrl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(){
        println(kazeList[self.ctrl.selectedSegmentIndex].rawValue)
    }
    func value() -> Kaze{
        return kazeList[self.ctrl.selectedSegmentIndex]
    }
    func setCtrl(kaze:Kaze){
        ctrl.selectedSegmentIndex = kazeList.indexOf(kaze)!
    }
}

class FinishTypeSelectorView:UIView{
    let finishTypeList:[FinishType] = [FinishType.NORMAL,FinishType.HAITEI,FinishType.RINSHAN,FinishType.CHANKAN,FinishType.CHIHO,FinishType.TENHO]
    var label = UILabel()
    var ctrl = UISegmentedControl(items:["なし","海底","嶺上","槍槓","地和","天和"])!
    init(x:Int, y:Int){
        super.init(frame:CGRect(x: x, y: y, width: 300, height: 40))
        self.label = UILabel(frame:CGRect(x: 0, y: 0, width: 60, height: 40))
        self.label.text = "その他"
        self.addSubview(self.label)
        self.ctrl.frame = CGRect(x: 60, y: 0, width: 240, height: 40)
        self.ctrl.selectedSegmentIndex = 0
        self.ctrl.addTarget(self,action: "update",forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(self.ctrl)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(){
        println(finishTypeList[self.ctrl.selectedSegmentIndex].rawValue)
    }
    func value() -> FinishType{
        return finishTypeList[self.ctrl.selectedSegmentIndex]
    }
    func setCtrl(finishType:FinishType){
        ctrl.selectedSegmentIndex = finishTypeList.indexOf(finishType)!
    }
}
