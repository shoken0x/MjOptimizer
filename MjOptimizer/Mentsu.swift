//
//  Mentsu.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class MentsuFactory{
    //paiListをパースして適切なMentsuを生成する
    class func createMentsu(paiList:Pai[]) -> Mentsu?{
        let pl : Pai[] = sort(paiList,<)
        var furoNum : Int = 0
        for pai in pl{
            if pai.isNaki() { furoNum += 1 }
        }
        var isFuro : Bool
        if furoNum == 0 {
            isFuro = false
        }else if furoNum == 1{
            isFuro = true
        }else{
            return nil
        }
        for pai in pl{
            if pai.isNaki() {
                isFuro = true
                break
            }
        }
        if(pl.count == 3 && pl[0].isNext(pl[1]) && pl[1].isNext(pl[2])){
            return isFuro ? ChiMentsu(paiList:pl) : ShuntsuMentsu(paiList:pl)
        }else if(pl.count == 2 && pl[0] == pl[1] && !isFuro){
            return ToitsuMentsu(pai: pl[0])
        }else if(pl.count == 3 && pl[0] == pl[1] && pl[1] == pl[2]){
            return isFuro ? PonMentsu(pai: pl[0]) : AnkouMentsu(pai: pl[0])
        }else if(pl.count == 4 && pl[0] == pl[1] && pl[1] == pl[2] && pl[2] == pl[3]){
            return isFuro ? MinkanMentsu(pai: pl[0]) : AnkanMentsu(pai: pl[0])
        }else if(pl.count == 14){
            return SpecialMentsu(paiList:pl)
        }else{
            return nil
        }
    }
    class func isChi(paiList: Pai[]) -> Bool{
        let pl : Pai[] = sort(paiList,<)
        var furoNum : Int = 0
        for pai in pl{
            if pai.isNaki() { furoNum += 1 }
        }
        return furoNum == 1 && pl.count == 3 && pl[0].isNext(pl[1]) && pl[1].isNext(pl[2])
    }
}

protocol Mentsu{
    func identical() ->Pai
    func toString() -> String
    func fuNum() -> Int
    func isFuro()->Bool
}

//同じ牌で構成される面子の親クラス
class SamePaiMentsu: Mentsu{
    var pai : Pai
    init(pai:Pai){self.pai = pai}
    init(paiList:Pai[]){self.pai = paiList[0]}
    func identical() ->Pai{ return self.pai }
    func toString() -> String{ return pai.type.toRaw() + String(pai.number) }
    func fuNum()->Int{return 0}
    func isFuro()->Bool{return false}
}
class ToitsuMentsu: SamePaiMentsu{
    override func toString() -> String{ return "トイツ:" + super.toString() }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return false}
}
class AnkouMentsu: SamePaiMentsu{
    override func toString() -> String{ return "アンコウ:" + super.toString() }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return false}
}
class PonMentsu: SamePaiMentsu{
    override func toString() -> String{ return "ポン:" + super.toString() }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return true}
}
class AnkanMentsu: SamePaiMentsu{
    override func toString() -> String{ return "アンカン:" + super.toString() }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return false}
}
class MinkanMentsu: SamePaiMentsu{
    override func toString() -> String{ return "ミンカン:" + super.toString() }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return true}
}

//異なる牌で構成される面子の親クラス
class DifferentPaiMentsu: Mentsu{
    var paiList : Pai[]
    init(paiList:Pai[]){self.paiList = sort(paiList,<)}
    func identical() -> Pai{return self.paiList[0]}
    func toString() -> String{
        var str: String = ""
        for pai in paiList{
            str += pai.type.toRaw() + String(pai.number)
        }
        return str
    }
    func fuNum()->Int{return 0}//TODO}
    func isFuro()->Bool{return true}
}
class ShuntsuMentsu: DifferentPaiMentsu{
    override func toString() -> String{
        return "シュンツ:" + super.toString()
    }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return false}
}
class ChiMentsu: DifferentPaiMentsu{
    override func toString() -> String{
        return "チー:" + super.toString()
    }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return true}
}
class SpecialMentsu: DifferentPaiMentsu{
    override func toString() -> String{
        return "特殊系:" + super.toString()
    }
    override func fuNum()->Int{return 0}//TODO}
    override func isFuro()->Bool{return false}
}