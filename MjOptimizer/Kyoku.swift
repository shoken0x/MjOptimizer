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
        return "isReach:\(isReach) isIppatsu:\(isIppatsu) doraNum:\(doraNum) honbaNum:\(honbaNum) bakaze:\(bakaze.toRaw()) jikaze:\(jikaze.toRaw()) finishType:\(finishType.toRaw())"
    }
}


public enum Kaze : String{
    case TON = "ton"
    case NAN = "nan"
    case SHA = "sha"
    case PEI = "pei"
    public func toPai() -> Pai{
        switch self{
        case .TON: return PaiMaster.pais["j1t"]!
        case .NAN: return PaiMaster.pais["j2t"]!
        case .SHA: return PaiMaster.pais["j3t"]!
        case .PEI: return PaiMaster.pais["j4t"]!
        }
    }
}
public enum FinishType : String{
    case HAITEI = "haitei" //海底摸月(河底撈魚)
    case RINSHAN = "rinshan" //嶺上開花
    case CHANKAN = "chankan" //槍槓
    case TENHO = "tenho" //天和
    case CHIHO = "chiho" //地和
    case NORMAL = "normal" //上記のいずれでもない
}
