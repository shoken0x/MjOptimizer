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
    case REVERSE = "r" //裏 r0tのみ
}

public enum PaiDirection: String {
    case TOP = "t"
    case BOTTOM = "b"
    case LEFT = "l"
    case RIGHT = "r"
}

public class Pai: Equatable, Comparable {
    public let type: PaiType
    public let number: Int //数牌の場合は1~9, 字牌の場合は1~7(東南西北白発中),裏は1を使用する
    public let direction: PaiDirection
    public let isYaochu: Bool
    public let isChuchan: Bool
    public let isFuro: Bool
    public let isShupai : Bool
    public let isSangen : Bool
    init(type: PaiType, number: Int, direction: PaiDirection = .TOP ){
        self.type = type
        self.number = number
        self.direction = direction
        self.isYaochu = (type == PaiType.JIHAI || number == 1 || number == 9)
        self.isChuchan = !(isYaochu) && type != PaiType.REVERSE
        self.isFuro = (direction == PaiDirection.LEFT || direction == PaiDirection.RIGHT)
        self.isShupai = (type == PaiType.MANZU || type == PaiType.SOUZU || type == PaiType.PINZU)
        self.isSangen = ((type == PaiType.JIHAI) && (number == 5 || number == 6 || number == 7))
    }

    //"m1t"などの文字列からオブジェクトを作る
    public class func parse(str: String) -> Pai? {
        if let pai = PaiMaster.pais[str] {
           return pai
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
    
    public func next(range: Int = 1) -> Pai?{
        if self.isShupai && self.number < 10 - range {
                return Pai(type: self.type,number: self.number + range)
        }else{
            return nil
        }
    }
    
    public func prev(range: Int = 1) -> Pai?{
        if self.isShupai && self.number > range {
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
    public func isTon()->Bool{return self.type == .JIHAI && self.number == 1}
    public func isNan()->Bool{return self.type == .JIHAI && self.number == 2}
    public func isSha()->Bool{return self.type == .JIHAI && self.number == 3}
    public func isPei()->Bool{return self.type == .JIHAI && self.number == 4}
    public func isHaku()->Bool{return self.type == .JIHAI && self.number == 5}
    public func isHatsu()->Bool{return self.type == .JIHAI && self.number == 6}
    public func isChun()->Bool{return self.type == .JIHAI && self.number == 7}
    
    public func clone() -> Pai{ return Pai(type: self.type,number: self.number,direction: self.direction) }
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

//牌マスタ。キャッシュ用
public struct PaiMaster{
    public static let pais : Dictionary<String,Pai> = [
        "m1t" : Pai(type: PaiType.MANZU,number:1,direction:PaiDirection.TOP),
        "m2t" : Pai(type: PaiType.MANZU,number:2,direction:PaiDirection.TOP),
        "m3t" : Pai(type: PaiType.MANZU,number:3,direction:PaiDirection.TOP),
        "m4t" : Pai(type: PaiType.MANZU,number:4,direction:PaiDirection.TOP),
        "m5t" : Pai(type: PaiType.MANZU,number:5,direction:PaiDirection.TOP),
        "m6t" : Pai(type: PaiType.MANZU,number:6,direction:PaiDirection.TOP),
        "m7t" : Pai(type: PaiType.MANZU,number:7,direction:PaiDirection.TOP),
        "m8t" : Pai(type: PaiType.MANZU,number:8,direction:PaiDirection.TOP),
        "m9t" : Pai(type: PaiType.MANZU,number:9,direction:PaiDirection.TOP),
        "s1t" : Pai(type: PaiType.SOUZU,number:1,direction:PaiDirection.TOP),
        "s2t" : Pai(type: PaiType.SOUZU,number:2,direction:PaiDirection.TOP),
        "s3t" : Pai(type: PaiType.SOUZU,number:3,direction:PaiDirection.TOP),
        "s4t" : Pai(type: PaiType.SOUZU,number:4,direction:PaiDirection.TOP),
        "s5t" : Pai(type: PaiType.SOUZU,number:5,direction:PaiDirection.TOP),
        "s6t" : Pai(type: PaiType.SOUZU,number:6,direction:PaiDirection.TOP),
        "s7t" : Pai(type: PaiType.SOUZU,number:7,direction:PaiDirection.TOP),
        "s8t" : Pai(type: PaiType.SOUZU,number:8,direction:PaiDirection.TOP),
        "s9t" : Pai(type: PaiType.SOUZU,number:9,direction:PaiDirection.TOP),
        "p1t" : Pai(type: PaiType.PINZU,number:1,direction:PaiDirection.TOP),
        "p2t" : Pai(type: PaiType.PINZU,number:2,direction:PaiDirection.TOP),
        "p3t" : Pai(type: PaiType.PINZU,number:3,direction:PaiDirection.TOP),
        "p4t" : Pai(type: PaiType.PINZU,number:4,direction:PaiDirection.TOP),
        "p5t" : Pai(type: PaiType.PINZU,number:5,direction:PaiDirection.TOP),
        "p6t" : Pai(type: PaiType.PINZU,number:6,direction:PaiDirection.TOP),
        "p7t" : Pai(type: PaiType.PINZU,number:7,direction:PaiDirection.TOP),
        "p8t" : Pai(type: PaiType.PINZU,number:8,direction:PaiDirection.TOP),
        "p9t" : Pai(type: PaiType.PINZU,number:9,direction:PaiDirection.TOP),
        "j1t" : Pai(type: PaiType.JIHAI,number:1,direction:PaiDirection.TOP),
        "j2t" : Pai(type: PaiType.JIHAI,number:2,direction:PaiDirection.TOP),
        "j3t" : Pai(type: PaiType.JIHAI,number:3,direction:PaiDirection.TOP),
        "j4t" : Pai(type: PaiType.JIHAI,number:4,direction:PaiDirection.TOP),
        "j5t" : Pai(type: PaiType.JIHAI,number:5,direction:PaiDirection.TOP),
        "j6t" : Pai(type: PaiType.JIHAI,number:6,direction:PaiDirection.TOP),
        "j7t" : Pai(type: PaiType.JIHAI,number:7,direction:PaiDirection.TOP),
        
        "m1r" : Pai(type: PaiType.MANZU,number:1,direction:PaiDirection.RIGHT),
        "m2r" : Pai(type: PaiType.MANZU,number:2,direction:PaiDirection.RIGHT),
        "m3r" : Pai(type: PaiType.MANZU,number:3,direction:PaiDirection.RIGHT),
        "m4r" : Pai(type: PaiType.MANZU,number:4,direction:PaiDirection.RIGHT),
        "m5r" : Pai(type: PaiType.MANZU,number:5,direction:PaiDirection.RIGHT),
        "m6r" : Pai(type: PaiType.MANZU,number:6,direction:PaiDirection.RIGHT),
        "m7r" : Pai(type: PaiType.MANZU,number:7,direction:PaiDirection.RIGHT),
        "m8r" : Pai(type: PaiType.MANZU,number:8,direction:PaiDirection.RIGHT),
        "m9r" : Pai(type: PaiType.MANZU,number:9,direction:PaiDirection.RIGHT),
        "s1r" : Pai(type: PaiType.SOUZU,number:1,direction:PaiDirection.RIGHT),
        "s2r" : Pai(type: PaiType.SOUZU,number:2,direction:PaiDirection.RIGHT),
        "s3r" : Pai(type: PaiType.SOUZU,number:3,direction:PaiDirection.RIGHT),
        "s4r" : Pai(type: PaiType.SOUZU,number:4,direction:PaiDirection.RIGHT),
        "s5r" : Pai(type: PaiType.SOUZU,number:5,direction:PaiDirection.RIGHT),
        "s6r" : Pai(type: PaiType.SOUZU,number:6,direction:PaiDirection.RIGHT),
        "s7r" : Pai(type: PaiType.SOUZU,number:7,direction:PaiDirection.RIGHT),
        "s8r" : Pai(type: PaiType.SOUZU,number:8,direction:PaiDirection.RIGHT),
        "s9r" : Pai(type: PaiType.SOUZU,number:9,direction:PaiDirection.RIGHT),
        "p1r" : Pai(type: PaiType.PINZU,number:1,direction:PaiDirection.RIGHT),
        "p2r" : Pai(type: PaiType.PINZU,number:2,direction:PaiDirection.RIGHT),
        "p3r" : Pai(type: PaiType.PINZU,number:3,direction:PaiDirection.RIGHT),
        "p4r" : Pai(type: PaiType.PINZU,number:4,direction:PaiDirection.RIGHT),
        "p5r" : Pai(type: PaiType.PINZU,number:5,direction:PaiDirection.RIGHT),
        "p6r" : Pai(type: PaiType.PINZU,number:6,direction:PaiDirection.RIGHT),
        "p7r" : Pai(type: PaiType.PINZU,number:7,direction:PaiDirection.RIGHT),
        "p8r" : Pai(type: PaiType.PINZU,number:8,direction:PaiDirection.RIGHT),
        "p9r" : Pai(type: PaiType.PINZU,number:9,direction:PaiDirection.RIGHT),
        "j1r" : Pai(type: PaiType.JIHAI,number:1,direction:PaiDirection.RIGHT),
        "j2r" : Pai(type: PaiType.JIHAI,number:2,direction:PaiDirection.RIGHT),
        "j3r" : Pai(type: PaiType.JIHAI,number:3,direction:PaiDirection.RIGHT),
        "j4r" : Pai(type: PaiType.JIHAI,number:4,direction:PaiDirection.RIGHT),
        "j5r" : Pai(type: PaiType.JIHAI,number:5,direction:PaiDirection.RIGHT),
        "j6r" : Pai(type: PaiType.JIHAI,number:6,direction:PaiDirection.RIGHT),
        "j7r" : Pai(type: PaiType.JIHAI,number:7,direction:PaiDirection.RIGHT),
        
        "j1b" : Pai(type: PaiType.JIHAI,number:1,direction:PaiDirection.BOTTOM),
        "j2b" : Pai(type: PaiType.JIHAI,number:2,direction:PaiDirection.BOTTOM),
        "j3b" : Pai(type: PaiType.JIHAI,number:3,direction:PaiDirection.BOTTOM),
        "j4b" : Pai(type: PaiType.JIHAI,number:4,direction:PaiDirection.BOTTOM),
        "j5b" : Pai(type: PaiType.JIHAI,number:5,direction:PaiDirection.BOTTOM),
        "j6b" : Pai(type: PaiType.JIHAI,number:6,direction:PaiDirection.BOTTOM),
        "j7b" : Pai(type: PaiType.JIHAI,number:7,direction:PaiDirection.BOTTOM),
        "m1b" : Pai(type: PaiType.MANZU,number:1,direction:PaiDirection.BOTTOM),
        "m2b" : Pai(type: PaiType.MANZU,number:2,direction:PaiDirection.BOTTOM),
        "m3b" : Pai(type: PaiType.MANZU,number:3,direction:PaiDirection.BOTTOM),
        "m4b" : Pai(type: PaiType.MANZU,number:4,direction:PaiDirection.BOTTOM),
        "m5b" : Pai(type: PaiType.MANZU,number:5,direction:PaiDirection.BOTTOM),
        "m6b" : Pai(type: PaiType.MANZU,number:6,direction:PaiDirection.BOTTOM),
        "m7b" : Pai(type: PaiType.MANZU,number:7,direction:PaiDirection.BOTTOM),
        "m8b" : Pai(type: PaiType.MANZU,number:8,direction:PaiDirection.BOTTOM),
        "m9b" : Pai(type: PaiType.MANZU,number:9,direction:PaiDirection.BOTTOM),
        "s1b" : Pai(type: PaiType.SOUZU,number:1,direction:PaiDirection.BOTTOM),
        "s2b" : Pai(type: PaiType.SOUZU,number:2,direction:PaiDirection.BOTTOM),
        "s3b" : Pai(type: PaiType.SOUZU,number:3,direction:PaiDirection.BOTTOM),
        "s4b" : Pai(type: PaiType.SOUZU,number:4,direction:PaiDirection.BOTTOM),
        "s5b" : Pai(type: PaiType.SOUZU,number:5,direction:PaiDirection.BOTTOM),
        "s6b" : Pai(type: PaiType.SOUZU,number:6,direction:PaiDirection.BOTTOM),
        "s7b" : Pai(type: PaiType.SOUZU,number:7,direction:PaiDirection.BOTTOM),
        "s8b" : Pai(type: PaiType.SOUZU,number:8,direction:PaiDirection.BOTTOM),
        "s9b" : Pai(type: PaiType.SOUZU,number:9,direction:PaiDirection.BOTTOM),
        "p1b" : Pai(type: PaiType.PINZU,number:1,direction:PaiDirection.BOTTOM),
        "p2b" : Pai(type: PaiType.PINZU,number:2,direction:PaiDirection.BOTTOM),
        "p3b" : Pai(type: PaiType.PINZU,number:3,direction:PaiDirection.BOTTOM),
        "p4b" : Pai(type: PaiType.PINZU,number:4,direction:PaiDirection.BOTTOM),
        "p5b" : Pai(type: PaiType.PINZU,number:5,direction:PaiDirection.BOTTOM),
        "p6b" : Pai(type: PaiType.PINZU,number:6,direction:PaiDirection.BOTTOM),
        "p7b" : Pai(type: PaiType.PINZU,number:7,direction:PaiDirection.BOTTOM),
        "p8b" : Pai(type: PaiType.PINZU,number:8,direction:PaiDirection.BOTTOM),
        "p9b" : Pai(type: PaiType.PINZU,number:9,direction:PaiDirection.BOTTOM),
        
        "j1l" : Pai(type: PaiType.JIHAI,number:1,direction:PaiDirection.LEFT),
        "j2l" : Pai(type: PaiType.JIHAI,number:2,direction:PaiDirection.LEFT),
        "j3l" : Pai(type: PaiType.JIHAI,number:3,direction:PaiDirection.LEFT),
        "j4l" : Pai(type: PaiType.JIHAI,number:4,direction:PaiDirection.LEFT),
        "j5l" : Pai(type: PaiType.JIHAI,number:5,direction:PaiDirection.LEFT),
        "j6l" : Pai(type: PaiType.JIHAI,number:6,direction:PaiDirection.LEFT),
        "j7l" : Pai(type: PaiType.JIHAI,number:7,direction:PaiDirection.LEFT),
        "m1l" : Pai(type: PaiType.MANZU,number:1,direction:PaiDirection.LEFT),
        "m2l" : Pai(type: PaiType.MANZU,number:2,direction:PaiDirection.LEFT),
        "m3l" : Pai(type: PaiType.MANZU,number:3,direction:PaiDirection.LEFT),
        "m4l" : Pai(type: PaiType.MANZU,number:4,direction:PaiDirection.LEFT),
        "m5l" : Pai(type: PaiType.MANZU,number:5,direction:PaiDirection.LEFT),
        "m6l" : Pai(type: PaiType.MANZU,number:6,direction:PaiDirection.LEFT),
        "m7l" : Pai(type: PaiType.MANZU,number:7,direction:PaiDirection.LEFT),
        "m8l" : Pai(type: PaiType.MANZU,number:8,direction:PaiDirection.LEFT),
        "m9l" : Pai(type: PaiType.MANZU,number:9,direction:PaiDirection.LEFT),
        "s1l" : Pai(type: PaiType.SOUZU,number:1,direction:PaiDirection.LEFT),
        "s2l" : Pai(type: PaiType.SOUZU,number:2,direction:PaiDirection.LEFT),
        "s3l" : Pai(type: PaiType.SOUZU,number:3,direction:PaiDirection.LEFT),
        "s4l" : Pai(type: PaiType.SOUZU,number:4,direction:PaiDirection.LEFT),
        "s5l" : Pai(type: PaiType.SOUZU,number:5,direction:PaiDirection.LEFT),
        "s6l" : Pai(type: PaiType.SOUZU,number:6,direction:PaiDirection.LEFT),
        "s7l" : Pai(type: PaiType.SOUZU,number:7,direction:PaiDirection.LEFT),
        "s8l" : Pai(type: PaiType.SOUZU,number:8,direction:PaiDirection.LEFT),
        "s9l" : Pai(type: PaiType.SOUZU,number:9,direction:PaiDirection.LEFT),
        "p1l" : Pai(type: PaiType.PINZU,number:1,direction:PaiDirection.LEFT),
        "p2l" : Pai(type: PaiType.PINZU,number:2,direction:PaiDirection.LEFT),
        "p3l" : Pai(type: PaiType.PINZU,number:3,direction:PaiDirection.LEFT),
        "p4l" : Pai(type: PaiType.PINZU,number:4,direction:PaiDirection.LEFT),
        "p5l" : Pai(type: PaiType.PINZU,number:5,direction:PaiDirection.LEFT),
        "p6l" : Pai(type: PaiType.PINZU,number:6,direction:PaiDirection.LEFT),
        "p7l" : Pai(type: PaiType.PINZU,number:7,direction:PaiDirection.LEFT),
        "p8l" : Pai(type: PaiType.PINZU,number:8,direction:PaiDirection.LEFT),
        "p9l" : Pai(type: PaiType.PINZU,number:9,direction:PaiDirection.LEFT),

        "r0t" : Pai(type: PaiType.REVERSE,number:0,direction:PaiDirection.TOP),
    ]
    public static let j1:Pai = PaiMaster.pais["j1t"]!
    public static let j2:Pai = PaiMaster.pais["j2t"]!
    public static let j3:Pai = PaiMaster.pais["j3t"]!
    public static let j4:Pai = PaiMaster.pais["j4t"]!
    public static let j5:Pai = PaiMaster.pais["j5t"]!
    public static let j6:Pai = PaiMaster.pais["j6t"]!
    public static let j7:Pai = PaiMaster.pais["j7t"]!
    
    public static let m1:Pai = PaiMaster.pais["m1t"]!
    public static let m2:Pai = PaiMaster.pais["m2t"]!
    public static let m3:Pai = PaiMaster.pais["m3t"]!
    public static let m4:Pai = PaiMaster.pais["m4t"]!
    public static let m5:Pai = PaiMaster.pais["m5t"]!
    public static let m6:Pai = PaiMaster.pais["m6t"]!
    public static let m7:Pai = PaiMaster.pais["m7t"]!
    public static let m8:Pai = PaiMaster.pais["m8t"]!
    public static let m9:Pai = PaiMaster.pais["m9t"]!
    
    public static let s1:Pai = PaiMaster.pais["s1t"]!
    public static let s2:Pai = PaiMaster.pais["s2t"]!
    public static let s3:Pai = PaiMaster.pais["s3t"]!
    public static let s4:Pai = PaiMaster.pais["s4t"]!
    public static let s5:Pai = PaiMaster.pais["s5t"]!
    public static let s6:Pai = PaiMaster.pais["s6t"]!
    public static let s7:Pai = PaiMaster.pais["s7t"]!
    public static let s8:Pai = PaiMaster.pais["s8t"]!
    public static let s9:Pai = PaiMaster.pais["s9t"]!
    
    public static let p1:Pai = PaiMaster.pais["p1t"]!
    public static let p2:Pai = PaiMaster.pais["p2t"]!
    public static let p3:Pai = PaiMaster.pais["p3t"]!
    public static let p4:Pai = PaiMaster.pais["p4t"]!
    public static let p5:Pai = PaiMaster.pais["p5t"]!
    public static let p6:Pai = PaiMaster.pais["p6t"]!
    public static let p7:Pai = PaiMaster.pais["p7t"]!
    public static let p8:Pai = PaiMaster.pais["p8t"]!
    public static let p9:Pai = PaiMaster.pais["p9t"]!
    
    public static let r0:Pai = PaiMaster.pais["r0t"]!
    
    public static let ton:Pai   = PaiMaster.j1
    public static let nan:Pai   = PaiMaster.j2
    public static let sha:Pai   = PaiMaster.j3
    public static let pei:Pai   = PaiMaster.j4
    public static let haku:Pai  = PaiMaster.j5
    public static let hatsu:Pai = PaiMaster.j6
    public static let chun:Pai  = PaiMaster.j7
    public static let ura:Pai  = PaiMaster.r0
}
