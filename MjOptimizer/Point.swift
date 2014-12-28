//
//  Point.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/14.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class Point{
    public var fuNum:Int
    public var hanNum:Int
    public var isTsumo:Bool
    public var isParent:Bool
    public var child:Int //ツモのときの子の支払い
    public var parent:Int //ツモのときの親の支払い
    public var total:Int //収入総額
    public var manganScale:Float //満貫の倍率
    public init(fuNum:Int,hanNum:Int,isTsumo:Bool,isParent:Bool,child:Int,parent:Int,total:Int,manganScale:Float){
        self.fuNum = fuNum
        self.hanNum = hanNum
        self.isTsumo = isTsumo
        self.isParent = isParent
        self.child = child
        self.parent = parent
        self.total = total
        self.manganScale = manganScale
    }
    public func toString() -> String{
        var str : String = "\(fuNum)符,\(hanNum)翻,"
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
        str += "\(total)点 "
        if !isTsumo{
            return str + "(ロン)"
        }else if (isTsumo && isParent) {
            return str + "(ツモ \(child)点オール)"
        }else{
            return str + "(ツモ 子\(child)点/親\(parent)点)"
        }
    }
}


