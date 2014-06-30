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
    case REVERSE = "r" //裏
}

enum PaiDirection: String {
    case TOP = "t"
    case BOTTOM = "b"
    case LEFT = "l"
    case RIGHT = "r"
}

class Pai: Equatable {
    var name = "ff"
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
    
    func isNaki() -> Bool{
        return self.direction == PaiDirection.LEFT ||
            self.direction == PaiDirection.RIGHT
    }

    func next(range: Int = 1) -> Pai?{
        if self.isShupai() && self.number < 10 - range {
                return Pai(type: self.type,number: self.number + range)
        }else{
            return nil
        }
    }
    
    func prev(range: Int = 1) -> Pai?{
        if self.isShupai() && self.number > range {
            return Pai(type: self.type,number: self.number - range)
        }else{
            return nil
        }
    }
    func getNextPai(range: Int = 1) -> Pai?{ return next(range: range) }

    func getPrevPai(range: Int = 1) -> Pai?{ return prev(range: range) }


    func isNext(pai:Pai) -> Bool{return pai == self.next()}
 
    func isPrev(pai:Pai) -> Bool{return pai == self.prev()}
    
    func equal(other: Pai) -> Bool{ return self.toString() == other.toString() }
    func isJihai() -> Bool{ return self.type == .JIHAI}
    func isShupai() -> Bool{ return self.type == .MANZU || self.type == .PINZU || self.type == .SOUZU}
    func isYaochu() -> Bool{
        return self.isJihai() ||
            (self.isShupai() && (self.number == 1 || self.number == 9))
    }
    func isTon()->Bool{return self.type == .JIHAI && self.number == 1}
    func isNan()->Bool{return self.type == .JIHAI && self.number == 2}
    func isSha()->Bool{return self.type == .JIHAI && self.number == 3}
    func isPei()->Bool{return self.type == .JIHAI && self.number == 4}
    func isHaku()->Bool{return self.type == .JIHAI && self.number == 5}
    func isHatsu()->Bool{return self.type == .JIHAI && self.number == 6}
    func isChun()->Bool{return self.type == .JIHAI && self.number == 7}
    
    func clone() -> Pai{ return Pai(type: self.type,number: self.number,direction: self.direction) }
}

//牌の種類が同じであれば数字の大小で比較する.牌の種類が違うとfalse
func < (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type != rhs.type ? false : lhs.number < rhs.number
}
func > (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type != rhs.type ? false : lhs.number > rhs.number
}

//牌の種類比較
func == (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type == rhs.type && lhs.number == rhs.number
}
func != (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type != rhs.type && lhs.number == rhs.number
}

//牌の種類と向き比較
func === (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type == rhs.type && lhs.number == rhs.number && lhs.direction == rhs.direction
}
