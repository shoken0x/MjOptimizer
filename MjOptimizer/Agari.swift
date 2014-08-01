//
//  Agari.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

public class Agari:Equatable{
    public var mentsuList: [Mentsu]
    public init(mentsuList:[Mentsu]) {
        self.mentsuList = mentsuList
    }
    public func menzenMentsuList() -> [Mentsu]{ return mentsuList.filter{$0.isMenzen()} }
    public func furoMentsuList() -> [Mentsu]{return mentsuList.filter{$0.isFuro()} }
    public func nakiMentsuList() -> [Mentsu]{return mentsuList.filter{$0.isNaki()} }
    public func notNakiMentsuList() -> [Mentsu]{return mentsuList.filter{!($0.isNaki())} }
    public func includeNaki()-> Bool{return self.nakiMentsuList().count > 0}
    public func toString() -> String{
        return "面子リスト:" + join(",",mentsuList.map({ $0.toString()}))
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
}
public func == (lhs: Agari, rhs: Agari) -> Bool {
    let lstr = join(",",lhs.mentsuList.map({ m in m.toString()}))
    let rstr = join(",",rhs.mentsuList.map({ m in m.toString()}))
    return lstr == rstr
}
