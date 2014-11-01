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
    private let kyoku = Kyoku()
    override init(){
        super.init(frame:CGRect(x: 0, y: 0, width: 700, height: 50 * 4))
        let color = UIColor.grayColor()
        self.backgroundColor = color.colorWithAlphaComponent(0.5)
        self.addSubview(self.isReachView)
        self.addSubview(self.isIppatsuView)
        self.addSubview(self.isTsumoView)
        self.addSubview(self.doraNumView)
        self.addSubview(self.honbaNumView)
        self.addSubview(self.jikazeView)
        self.addSubview(self.bakazeView)
        self.addSubview(self.finishTypeView)
        
        
        let btOk = UIButton(frame:CGRect(x: 380, y: 50 * 3, width: 40, height: 50))
        btOk.backgroundColor = UIColor(red: 0.0, green: 0.4, blue: 1, alpha: 1)
        btOk.setTitle("OK", forState: UIControlState.Normal)
        btOk.addTarget(self,action: "okButtonPush",forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btOk)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func okButtonPush(){
        self.hidden = true
        
        println(self.value().toString())
    }
    public func value() -> Kyoku{
        self.kyoku.isReach = isReachView.value()
        self.kyoku.isIppatsu = isIppatsuView.value()
        self.kyoku.isTsumo = isTsumoView.value()
        self.kyoku.doraNum = doraNumView.value()
        self.kyoku.honbaNum = honbaNumView.value()
        self.kyoku.bakaze = bakazeView.value()
        self.kyoku.jikaze = jikazeView.value()
        self.kyoku.finishType = finishTypeView.value()
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
}

class FinishTypeSelectorView:UIView{
    let kazeList:[FinishType] = [FinishType.NORMAL,FinishType.HAITEI,FinishType.RINSHAN,FinishType.CHANKAN,FinishType.CHIHO,FinishType.TENHO]
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
        println(kazeList[self.ctrl.selectedSegmentIndex].rawValue)
    }
    func value() -> FinishType{
        return kazeList[self.ctrl.selectedSegmentIndex]
    }
}
