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
    let number: Int
    let direction: PaiDirection


    init(type: PaiType, number: Int, direction: PaiDirection = .TOP ){
        self.type = type
        self.number = number
        self.direction = direction
    }

    //"m1t"などの文字列からオブジェクトを作る
    class func parse(str: String) -> Pai? {
        if let type = PaiType.fromRaw(str[0..1]) {
            println(str[0..1])
            println(str[0...1])
            println(str[1..2])
            if let number = str[1..2].toInt() {
                if let direction = PaiDirection.fromRaw(str[2..3]) {
                    return Pai(type: type, number: number, direction: direction)
                }
            }
        }
        return nil
    }

    func toString() -> String{
        return self.type.toRaw() + String(self.number) + self.direction.toRaw()
    }
}
