//
//  Kyoku.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

//局状態
public class Kyoku{
    public var isReach:Bool = false   //リーチかどうか
    public var isIppatsu:Bool = false  //一発かどうか
    public var isTsumo:Bool = false   //ツモかどうか（面前、鳴きあり問わず）
    public var doraNum:Int = 0        //ドラ枚数
    public var honbaNum:Int = 0       //本場
    public var bakaze:Kaze = Kaze.TON //場風
    public var jikaze:Kaze = Kaze.TON //自風
    public var finishType:FinishType = FinishType.NORMAL //あがり型
    public init(){}
    public func isParent() -> Bool {
        return jikaze == Kaze.TON
    }
    public func toString() -> String{
        return "isReach:\(isReach) isIppatsu:\(isIppatsu) doraNum:\(doraNum) honbaNum:\(honbaNum) bakaze:\(bakaze.rawValue) jikaze:\(jikaze.rawValue) finishType:\(finishType.rawValue)"
    }
    public func toPrettyString() -> String{
        var str = "\(bakaze.toKanji())場 \(honbaNum)本場 \(jikaze.toKanji())家 ドラ\(doraNum)枚 "
        str += isReach ? "リーチ有り " : "リーチ無し "
        str += isIppatsu ? "一発有り " : "一発無し "
        str += finishType == FinishType.NORMAL ? "" : finishType.toKanji()
        return str
    }
}

