//
//  FinishType.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/11/01.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public enum FinishType : String{
    case HAITEI = "haitei" //海底摸月(河底撈魚)
    case RINSHAN = "rinshan" //嶺上開花
    case CHANKAN = "chankan" //槍槓
    case TENHO = "tenho" //天和
    case CHIHO = "chiho" //地和
    case NORMAL = "normal" //上記のいずれでもない
    public func toKanji() -> String{
        switch self{
        case .HAITEI: return "海底"
        case .RINSHAN: return "嶺上"
        case .CHANKAN: return "槍槓"
        case .TENHO: return "天和"
        case .CHIHO: return "地和"
        case .NORMAL: return "通常"
        }
    }
}
