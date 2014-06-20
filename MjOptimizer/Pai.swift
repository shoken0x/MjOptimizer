//
//  Pai.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/14.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation


enum PaiType: String {
    case MANZU = "m"
    case SOUZU = "s"
    case PINZU = "p"
    case JIHAI = "j"
}

enum PaiDirection: String {
    case TOP = "t"
    case BOTTOM = "b"
    case LEFT = "l"
    case RIGHT = "r"
}

class Pai {
    
    let type: PaiType
    let number: Int //数牌の場合は1~9, 字牌の場合は1~7(東南西北白発中)を使用する
    let direction: PaiDirection


    init(type: PaiType, number: Int, direction: PaiDirection = .TOP ){
        self.type = type
        self.number = number
        self.direction = direction
    }

    //"m1t"などの文字列からオブジェクトを作る
    class func parse(str: String) -> Pai? {
        if let type = PaiType.fromRaw(str.substring(0, 1)) {
            if let number = str.substring(1, 1).toInt() {
                if let direction = PaiDirection.fromRaw(str.substring(2, 1)) {
                    return Pai(type: type, number: number, direction: direction)
                }
            }
        }
        return nil
    }
    
    class func parseList(str: String) -> Array<Pai>? {
        var result = Array<Pai>()
        for substr in str.sliceWith(3) {
            if let pai = Pai.parse(substr) {
                result.append(pai)
            } else {
                return nil
            }
        }
        return result
    }

    func toString() -> String{
        return self.type.toRaw() + String(self.number) + self.direction.toRaw()
    }
    
    // インスタンスの次のPaiを取得する
    func getNextPai(range: Int = 1) -> String{
        // TODO: 正規表現の書き方を調べる
        if (self.type == .MANZU || self.type == .PINZU || self.type == .SOUZU) &&
            self.number < 10 - range {
            return self.type.toRaw() + String(self.number + range)
        }
        else{
            return ""
        }
    }
    
    // インスタンスの前のPaiを取得する
    func getPrevPai(range: Int = 1) -> String{
        // TODO: 正規表現の書き方を調べる
        if (self.type == .MANZU || self.type == .PINZU || self.type == .SOUZU) &&
            self.number > range {
                return self.type.toRaw() + String(self.number - range)
        }
        else{
            return ""
        }
    }
    
    
    
    func equal(other: Pai) -> Bool{
        return self.toString() == other.toString()
    }
}
