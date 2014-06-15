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
    
    // "m1tm2tm3t"といった牌の配列文字列をPaiの配列にする
    class func stringToPaiList(paiListStr : String)->Pai[]{
        var strList: String[] = []
        for c in paiListStr {
            var tmp:String = "" + c //charactorをstringにする
            strList.append(tmp)
        }
        if ((strList.count % 3) != 0) {
            println("[エラー] paiListStrの長さが３の倍数ではありません")
            return []
            //TODO 例外を投げる
        }
        
        var paiList: Pai[] = []
        for i in 0...strList.count {
            if i % 3 == 2 {
                paiList.append(Pai(paiStr: strList[i-2] + strList[i-1] + strList[i-0]))
            }
        }
        return paiList
    }
    
    //種類と数字から作るコンストラクタ
    init(type: PaiType,number: Int){
        self.type = type
        self.number = number
        self.direction = PaiDirection.TOP
    }
    
    //種類と数字と向きから作るコンストラクタ
    init(type: PaiType,number: Int,direction: PaiDirection){
        self.type = type
        self.number = number
        self.direction = direction
    }
    
    //"m1t"などの文字列から作るコンストラクタ
    //"m1 "のように、３文字目を空白スペースにした場合はTOPで作られる
    init(paiStr: String){
        //Stringを「長さ１のString」の配列に変換
        var strList: String[] = []
        for c in paiStr {
            var tmp:String = "" + c //charactorをstringにする
            strList.append(tmp)
        }
        
        switch strList[0] {
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
            println("[エラー] 不正なpaiType¥(strList[0])")
            //TODO 例外を投げる
        }
        self.number = strList[1].toInt()!
        switch strList[2] {
        case "t":
            self.direction = PaiDirection.TOP
        case "b":
            self.direction = PaiDirection.BOTTOM
        case "r":
            self.direction = PaiDirection.RIGHT
        case "l":
            self.direction = PaiDirection.LEFT
        case " ":
            self.direction = PaiDirection.TOP
        default:
            self.direction = PaiDirection.TOP
            println("[エラー] 不正なpaiDirection¥(strList[2])")
            //TODO 例外を投げる
        }
    }
    
    // getter and setter
    func getType() -> PaiType{return self.type}
    func getNumber() -> Int{return self.number}
    func getDirection() -> PaiDirection{return self.direction}
    
    // 種類をStringで返す
    func getTypeStr() -> String{
        let typeStrMap = [PaiType.MANZU:"m",PaiType.SOUZU:"s",PaiType.PINZU:"p",PaiType.JIHAI:"j"]
        return typeStrMap[self.type]!
    }
    
    // 向きをStringで返す
    func getDirectionStr() -> String{
        let directionStrMap = [PaiDirection.TOP:"t",PaiDirection.BOTTOM:"b",PaiDirection.RIGHT:"r",PaiDirection.LEFT:"l"]
       return directionStrMap[self.direction]!
    }
    
    // "m1t"といった牌を表す文字列で返す
    func toString() -> String{
        return getTypeStr() + String(self.number) + getDirectionStr()
    }
}