//
//  PaiNumList.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/12.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class PaiNum{
    var pai : Pai
    var num : Int
    init(pai:Pai,num:Int){self.pai = pai;self.num = num}
    func inc(){num++}
    func toString()->String{return pai.type.toRaw() + String(pai.number) + "=" + String(num)}
    func copy()->PaiNum{return PaiNum(pai: self.pai,num: self.num)}
}

class PaiNumList {
    var list : PaiNum[] = [
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 7), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 8), num:0),
        PaiNum(pai: Pai(type: PaiType.MANZU, number: 9), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 7), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 8), num:0),
        PaiNum(pai: Pai(type: PaiType.SOUZU, number: 9), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 7), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 8), num:0),
        PaiNum(pai: Pai(type: PaiType.PINZU, number: 9), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 1), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 2), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 3), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 4), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 5), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 6), num:0),
        PaiNum(pai: Pai(type: PaiType.JIHAI, number: 7), num:0)
    ]
    init(list:PaiNum[]){
        self.list = list
    }
    init(paiList:Pai[]){
        for pai in paiList {
            for paiNum in self.list{
                if pai == paiNum.pai {
                    paiNum.inc()
                }
            }
        }
    }
    func copy() -> PaiNumList{
        var tmp : PaiNum[] = []
        for paiNum in self.list{
            tmp.append(paiNum.copy())
        }
        return PaiNumList(list: tmp)
    }
    //自身をコピーして、牌の数をnumだけ減らして、返す
    func remove(pai : Pai,num : Int) -> PaiNumList?{
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
    func count() -> Int{
        var count = 0
        for paiNum in self.list{
            count += paiNum.num
        }
        return count
    }
    func get(index:Int)->PaiNum{
        return self.list[index]
    }
    func getNum(pai:Pai) -> Int{
        for paiNum in self.list{
            if paiNum.pai == pai {return paiNum.num}
        }
        return 0
    }
    //paiの個数が0以上か？
    func include(pai:Pai) -> Bool{
        return self.getNum(pai) > 0
    }
    //paiから始まるシュンツはあるか？
    func includeShuntsuFrom(pai:Pai) -> Bool{
        return self.include(pai) && pai.next() != nil && self.include(pai.next()!) && pai.next(range: 2) != nil && self.include(pai.next(range: 2)!)
    }
    //paiからなるアンコウはあるか？
    func includeAnkouOf(pai:Pai) -> Bool{
        return self.getNum(pai) >= 3
    }
    //paiからなるアンコウを削除したPaiNumListを返す
    func removeAnkouOf(pai:Pai) -> PaiNumList?{
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
    func removeShuntsuFrom(pai:Pai) -> PaiNumList?{
        var tmp : PaiNumList = self.copy()
        var i = 0;
        for i = 0; i < tmp.count(); i++ {
            if tmp.list[i].pai == pai{
                break
            }
        }
        if tmp.get(i).num >= 1 {
            tmp.get(i).num -= 1
        }else {
            return nil
        }
        if tmp.get(i + 1).num >= 1 && tmp.get(i).pai.type == tmp.get(i + 1).pai.type {
            tmp.get(i + 1).num -= 1
        }else{
            return nil
        }
        if tmp.get(i + 2).num >= 1 && tmp.get(i + 1).pai.type == tmp.get(i + 2).pai.type {
            tmp.get(i + 2).num -= 1
        }else{
            return nil
        }
        return tmp
    }
    func toString()->String{
        var str = ""
        for pn in list{
            if pn.num != 0 {
                str += pn.toString() + ","
            }
        }
        return str
    }
}