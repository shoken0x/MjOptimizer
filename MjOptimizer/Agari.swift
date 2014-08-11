//
//  Agari.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

public class Agari:Equatable,Comparable {
    public var mentsuList: [Mentsu]
    public var paiList:[Pai]
    public var paiNumList: PaiNumList
    
    //初期化時にはダミーの値をいれておき、後で埋める
    public var kyoku: Kyoku = Kyoku()
    public var yakuList: [Yaku] = []
    public var fuNum: Int = -1
    public var hanNum: Int = -1
    public var score: Score = Score(c:-1,p:-1,t:-1,m:-1.0)
    
    public init(mentsuList:[Mentsu]) {
        self.mentsuList = mentsuList
        self.paiList = []
        for mentsu in mentsuList{
            for pai in mentsu.paiArray(){
                self.paiList.append(pai)
            }
        }
        self.paiNumList = PaiNumList(paiList:self.paiList)
    }
    public func menzenMentsuList() -> [Mentsu]{ return mentsuList.filter{$0.isMenzen()} }
    public func furoMentsuList() -> [Mentsu]{return mentsuList.filter{$0.isFuro()} }
    public func nakiMentsuList() -> [Mentsu]{return mentsuList.filter{$0.isNaki()} }
    public func notNakiMentsuList() -> [Mentsu]{return mentsuList.filter{!($0.isNaki())} }
    public func includeNaki()-> Bool{return self.nakiMentsuList().count > 0}
    public func toString() -> String{
        return "\(fuNum)符,\(hanNum)翻," + score.toString() + ",役リスト:" + join(",",yakuList.map({$0.kanji})) + ",面子リスト:" + join(",",mentsuList.map({ $0.toString()})) 
    }
    public func copy() -> Agari{
        return Agari(mentsuList:mentsuList.copy())
    }
    //面子を入れ替えたAgariを返す。
    public func replaceMenzenOneMentsu(oldMentsu:Mentsu,newMentsu:Mentsu) -> Agari{
        var newAgari = self.copy()
        for (var i = 0 ; i < newAgari.mentsuList.count; i++){
            if newAgari.mentsuList[i] == oldMentsu{
                newAgari.mentsuList[i] = newMentsu
                return newAgari
            }
        }
        return newAgari
    }
    //有効なアガリかどうか。役無しはfalse
    public func valid() -> Bool{
        return self.score.t > 0
    }
}
public func == (lhs: Agari, rhs: Agari) -> Bool {
    let lstr = join(",",lhs.mentsuList.map({ m in m.toString()}))
    let rstr = join(",",rhs.mentsuList.map({ m in m.toString()}))
    return lstr == rstr
}
public func < (lhs: Agari, rhs: Agari) -> Bool {
    return lhs.score.t < rhs.score.t
}
public func > (lhs: Agari, rhs: Agari) -> Bool {
    return lhs.score.t > rhs.score.t
}


