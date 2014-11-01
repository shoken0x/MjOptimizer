//
//  Agari.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

//アガリクラス。
public class Agari:Equatable {
    
    public var mentsuList: [Mentsu] //面子リスト
    public var paiList:[Pai]
    public var paiNumList: PaiNumList
    
    public init(mentsuList:[Mentsu]) {
        self.mentsuList = mentsuList
        self.paiList = []
        for mentsu in mentsuList{
            for pai in mentsu.paiArray(){
                self.paiList.append(pai)
            }
        }
        self.paiNumList = PaiNumList(paiList:self.paiList)
        //以下のフィールドは初期化時にはダミーの値をいれておき、後で埋める
    }
    public func addMentsu(mentsu:Mentsu) {
        self.mentsuList.append(mentsu)
        for pai in mentsu.paiArray(){
            self.paiNumList.incNum(pai)
        }
    }
    
    //面前面子のリスト。アンカン含まず。
    public func menzenMentsuList() -> [Mentsu]{ return mentsuList.filter{$0.isMenzen()} }
    //副露面子のリスト。アンカンを含む
    public func furoMentsuList() -> [Mentsu]{return mentsuList.filter{$0.isFuro()} }
    //鳴き面子リスト。アンカン含まず。
    public func nakiMentsuList() -> [Mentsu]{return mentsuList.filter{$0.isNaki()} }
    //鳴いてない面子リスト。アンカン含む。
    public func notNakiMentsuList() -> [Mentsu]{return mentsuList.filter{!($0.isNaki())} }
    //鳴き面子があるか。
    public func includeNaki()-> Bool{return self.nakiMentsuList().count > 0}
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
    public func copy() -> Agari{return Agari(mentsuList:mentsuList.copy())}
    public func toString() -> String{
        return "面子リスト:" + join(",",mentsuList.map({ $0.toString()}))
    }
}
public func == (lhs: Agari, rhs: Agari) -> Bool {
    let lstr = join(",",lhs.mentsuList.map({ m in m.toString()}))
    let rstr = join(",",rhs.mentsuList.map({ m in m.toString()}))
    return lstr == rstr
}


