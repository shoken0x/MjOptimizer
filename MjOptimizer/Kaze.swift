//
//  Kaze.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/11/01.
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
        case .TON: return PaiMaster.pais["j1t"]!
        case .NAN: return PaiMaster.pais["j2t"]!
        case .SHA: return PaiMaster.pais["j3t"]!
        case .PEI: return PaiMaster.pais["j4t"]!
        }
    }
    public func toKanji() -> String{
        switch self{
        case .TON: return "東"
        case .NAN: return "南"
        case .SHA: return "西"
        case .PEI: return "北"
        }
    }
}
