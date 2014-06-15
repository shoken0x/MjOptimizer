//
//  Pai.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/14.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

enum PaiType{
    case MANZU
    case SOUZU
    case PINZU
    case JIHAI
}

enum PaiDirection{
    case TOP
    case BOTTOM
    case LEFT
    case RIGHT
}

class Pai {
    
    var type: PaiType
    var number: Int
    var direction: PaiDirection

    init(type: PaiType,number: Int,direction: PaiDirection){
        self.type = type
        self.number = number
        self.direction = direction
    }
    
    //"m1t"などの文字列からオブジェクトを作る
    init(paiStr: String){
        var _ary: String[] = []
        for c in paiStr {
            var tmp:String = "" + c //convert c from charactor to string
            _ary.append(tmp)
        }
        switch _ary[0] {
        case "m":
            self.type = PaiType.MANZU
        case "s":
            self.type = PaiType.SOUZU
        case "p":
            self.type = PaiType.PINZU
        case "j":
            self.type = PaiType.JIHAI
        default:
            self.type = PaiType.MANZU
            println("[MjOptimizer ERROR] Invalied paiType¥(_ary[0])")
            //TODO 例外を投げる
        }
        self.number = _ary[1].toInt()!
        switch _ary[2] {
        case "t":
            self.direction = PaiDirection.TOP
        case "b":
            self.direction = PaiDirection.BOTTOM
        case "r":
            self.direction = PaiDirection.RIGHT
        case "l":
            self.direction = PaiDirection.LEFT
        default:
            self.direction = PaiDirection.TOP
            println("[MjOptimizer ERROR] Invalied paiDirection¥(_ary[2])")
            //TODO 例外を投げる
        }
    }
    
    func getTypeStr() -> String{
        let typeStrMap = [PaiType.MANZU:"m",PaiType.SOUZU:"s",PaiType.PINZU:"p",PaiType.JIHAI:"j"]
        return typeStrMap[self.type]!
    }
    func getDirectionStr() -> String{
        let directionStrMap = [PaiDirection.TOP:"t",PaiDirection.BOTTOM:"b",PaiDirection.RIGHT:"r",PaiDirection.LEFT:"l"]
       return directionStrMap[self.direction]!
    }
    func toString() -> String{
        return getTypeStr() + String(self.number) + getDirectionStr()
    }
}