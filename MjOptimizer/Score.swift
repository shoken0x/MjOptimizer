//
//  Score.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/14.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class Score{
    public var child:Int //子の支払い
    public var parent:Int //親の支払い
    public var total:Int //収入総額
    public var manganScale:Float //満貫の倍率
    public init(child:Int,parent:Int,total:Int,manganScale:Float){
        self.child = child
        self.parent = parent
        self.total = total
        self.manganScale = manganScale
    }
    public func toString() -> String{
        var str : String
        switch manganScale{
        case 1.0: str = "[満貫]"
        case 1.5: str = "[跳満]"
        case 2.0: str = "[倍満]"
        case 3.0: str = "[三倍満]"
        case 4.0: str = "[役満]"
        case 8.0: str = "[ダブル役満]"
        case 12.0: str = "[トリプル役満]"
        case 16.0: str = "[四倍役満]"
        default : str = ""
        }
        if parent == 0 && child == 0{
            return str + String(total) + "点"
        }else if parent == 0 {
            return str + String(child) + "オール 合計" + String(total) + "点"
        }else{
            return str + String(child) + "/" + String(parent) + " 合計" + String(total) + "点"
        }
    }
}


