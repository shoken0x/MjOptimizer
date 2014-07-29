//
//  Kyoku.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/30.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public enum Kaze : String{
    case TON = "ton"
    case NAN = "nan"
    case SHA = "sha"
    case PEI = "pei"
    public func toPai() -> Pai{
        switch self{
        case .TON: return PaiMaster.ton
        case .NAN: return PaiMaster.nan
        case .SHA: return PaiMaster.sha
        case .PEI: return PaiMaster.pei
        }
    }
}

public class Kyoku{
    public var isTsumo:Bool = false
    public var isHaitei:Bool = false
    public var doraNum:Int = 0
    public var bakaze:Kaze = Kaze.TON
    public var jikaze:Kaze = Kaze.TON
    public var isParent:Bool = true
    public var honbaNum:Int = 0
    public var reachNum:Int = 0 //ダブリーなら2
    public var isIppatsu:Bool = false
    public var isRinshan:Bool = false
    public var isChankan:Bool = false
    public var isTenho:Bool = false
    public var isChiho:Bool = false
    public init(){}
}