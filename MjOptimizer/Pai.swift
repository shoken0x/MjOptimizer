//
//  Pai.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/14.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public enum PaiType: String {
    case MANZU = "m"
    case SOUZU = "s"
    case PINZU = "p"
    case JIHAI = "j"
    case REVERSE = "r" //裏
}

public enum PaiDirection: String {
    case TOP = "t"
    case BOTTOM = "b"
    case LEFT = "l"
    case RIGHT = "r"
}

public class Pai: Equatable, Comparable {
    var name = "ff"
    public let type: PaiType
    public let number: Int //数牌の場合は1~9, 字牌の場合は1~7(東南西北白発中)を使用する
    public let direction: PaiDirection


    public init(type: PaiType, number: Int, direction: PaiDirection = .TOP ){
        self.type = type
        self.number = number
        self.direction = direction
    }

    //"m1t"などの文字列からオブジェクトを作る
    public class func parse(str: String) -> Pai? {
        if let type = PaiType.fromRaw(str.substring(0, 1)) {
            if let number = str.substring(1, 1).toInt() {
                if let direction = PaiDirection.fromRaw(str.substring(2, 1)) {
                    return Pai(type: type, number: number, direction: direction)
                }
            }
        }
        return nil
    }
    
    public class func parseList(str: String) -> Array<Pai>? {
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

    public func toString() -> String{
        return self.type.toRaw() + String(self.number) + self.direction.toRaw()
    }
    
    public func isNaki() -> Bool{
        return self.direction == PaiDirection.LEFT ||
            self.direction == PaiDirection.RIGHT
    }

    public func next(range: Int = 1) -> Pai?{
        if self.isShupai() && self.number < 10 - range {
                return Pai(type: self.type,number: self.number + range)
        }else{
            return nil
        }
    }
    
    public func prev(range: Int = 1) -> Pai?{
        if self.isShupai() && self.number > range {
            return Pai(type: self.type,number: self.number - range)
        }else{
            return nil
        }
    }
    public func getNextPai(range: Int = 1) -> Pai?{ return next(range: range) }

    public func getPrevPai(range: Int = 1) -> Pai?{ return prev(range: range) }


    public func isNext(pai:Pai) -> Bool{return pai == self.next()}
 
    public func isPrev(pai:Pai) -> Bool{return pai == self.prev()}
    
    public func equal(other: Pai) -> Bool{ return self.toString() == other.toString() }
    public func isJihai() -> Bool{ return self.type == .JIHAI}
    public func isShupai() -> Bool{ return self.type == .MANZU || self.type == .PINZU || self.type == .SOUZU}
    public func isYaochu() -> Bool{
        return self.isJihai() ||
            (self.isShupai() && (self.number == 1 || self.number == 9))
    }
    public func isTon()->Bool{return self.type == .JIHAI && self.number == 1}
    public func isNan()->Bool{return self.type == .JIHAI && self.number == 2}
    public func isSha()->Bool{return self.type == .JIHAI && self.number == 3}
    public func isPei()->Bool{return self.type == .JIHAI && self.number == 4}
    public func isHaku()->Bool{return self.type == .JIHAI && self.number == 5}
    public func isHatsu()->Bool{return self.type == .JIHAI && self.number == 6}
    public func isChun()->Bool{return self.type == .JIHAI && self.number == 7}
    
    func clone() -> Pai{ return Pai(type: self.type,number: self.number,direction: self.direction) }
}

//牌の種類が同じであれば数字の大小で比較する.牌の種類が違うとfalse
public func < (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type != rhs.type ? false : lhs.number < rhs.number
}
public func > (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type != rhs.type ? false : lhs.number > rhs.number
}

//牌の種類比較
public func == (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type == rhs.type && lhs.number == rhs.number
}
func != (lhs: Pai, rhs: Pai) -> Bool {
    return !(lhs == rhs)
}

//牌の種類と向き比較
func === (lhs: Pai, rhs: Pai) -> Bool {
    return lhs.type == rhs.type && lhs.number == rhs.number && lhs.direction == rhs.direction
}
