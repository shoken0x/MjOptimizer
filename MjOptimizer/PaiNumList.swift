//
//  PaiNumList.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/12.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

//牌とその数を表すクラス。解析用
public class PaiNum{
    var pai : Pai
    var num : Int
    init(pai:Pai,num:Int){self.pai = pai;self.num = num}
    func inc(){num++}
    public func toString()->String{return pai.type.rawValue + String(pai.number) + "=" + String(num)}
    func copy()->PaiNum{return PaiNum(pai: self.pai,num: self.num)}
}

public class PaiNumList {
    public var list : [PaiNum] = [
        PaiNum(pai: PaiMaster.pais["m1t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m2t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m3t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m4t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m5t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m6t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m7t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m8t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["m9t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s1t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s2t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s3t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s4t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s5t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s6t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s7t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s8t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["s9t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p1t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p2t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p3t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p4t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p5t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p6t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p7t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p8t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["p9t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["j1t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["j2t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["j3t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["j4t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["j5t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["j6t"]!, num:0),
        PaiNum(pai: PaiMaster.pais["j7t"]!, num:0)
    ]
    public init(list:[PaiNum]){
        self.list = list
    }
    public init(paiList:[Pai]){
        for pai in paiList {
            for paiNum in self.list{
                if pai == paiNum.pai {
                    paiNum.inc()
                }
            }
        }
    }
    func copy() -> PaiNumList{
        var tmp : [PaiNum] = []
        for paiNum in self.list{
            tmp.append(paiNum.copy())
        }
        return PaiNumList(list: tmp)
    }
    //自身をコピーして、牌の数をnumだけ減らして、返す
    public func remove(pai : Pai,num : Int) -> PaiNumList?{
        var tmp : PaiNumList = self.copy()
        for paiNum in tmp.list{
            if pai == paiNum.pai {
                if paiNum.num < num{
                    return nil
                }else{
                    paiNum.num -= num
                }
            }
        }
        return tmp
    }
    //牌の枚数
    public func count() -> Int{
        var count = 0
        for paiNum in self.list{
            count += paiNum.num
        }
        return count
    }
    //index番目の要素を返す
    public func get(index:Int)->PaiNum{
        return self.list[index]
    }
    //引数paiの枚数を返す
    public func getNum(pai:Pai) -> Int{
        for paiNum in self.list{
            if paiNum.pai == pai {return paiNum.num}
        }
        return 0
    }
    //引数paistrの枚数を返す
    public func getNum(paiStr:String) -> Int{
        let pai = PaiMaster.pais[paiStr]!
        for paiNum in self.list{
            if paiNum.pai == pai {return paiNum.num}
        }
        return 0
    }
    //引数paiの枚数を一枚減らす
    public func decNum(pai:Pai){
        for paiNum in self.list{
            if paiNum.pai == pai {paiNum.num -= 1}
        }
    }
    //引数paiの枚数を一枚増やす
    public func incNum(pai:Pai){
        for paiNum in self.list{
            if paiNum.pai == pai {paiNum.num += 1}
        }
    }
    //paiの個数が0以上か？
    public func include(pai:Pai) -> Bool{
        return self.getNum(pai) > 0
    }
    //paiから始まるシュンツはあるか？
    public func includeShuntsuFrom(pai:Pai) -> Bool{
        return self.include(pai) && pai.next() != nil && self.include(pai.next()!) && pai.next(range: 2) != nil && self.include(pai.next(range: 2)!)
    }
    //paiからなるアンコウはあるか？
    public func includeAnkouOf(pai:Pai) -> Bool{
        return self.getNum(pai) >= 3
    }
    //paiからなるアンコウを削除したPaiNumListを返す
    public func removeAnkouOf(pai:Pai) -> PaiNumList?{
        var tmp : PaiNumList = self.copy()
        for paiNum in tmp.list{
            if pai == paiNum.pai {
                if paiNum.num < 3 {
                    return nil
                }else{
                    paiNum.num -= 3
                }
            }
        }
        return tmp
    }
    //paiから始まるシュンツを削除したPaiNumListを返す
    public func removeShuntsuFrom(pai:Pai) -> PaiNumList?{
        if(pai.type == PaiType.JIHAI || pai.number > 7){
            return nil
        }
        if self.getNum(pai) >= 1 && self.getNum(pai.next()!) >= 1 && self.getNum(pai.next(range:2)!) >= 1 {
            var tmp : PaiNumList = self.copy()
            tmp.decNum(pai)
            tmp.decNum(pai.next()!)
            tmp.decNum(pai.next(range:2)!)
            return tmp
        }else{
            return nil
        }
    }
    public func toString()->String{
        var str = ""
        for pn in list{
            if pn.num != 0 {
                str += pn.toString() + ","
            }
        }
        return str
    }
}