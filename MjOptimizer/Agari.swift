//
//  Agari.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

//アガリクラス。
//得点計算結果(面子解析、役一覧、翻数、符数、点数)の全てを格納する。
//得点計算中はこのオブジェクトを更新することで計算が進む。
public class Agari:Equatable,Comparable {
    
    public var kyoku: Kyoku     //局の状態
    public var yakuList: [Yaku] //役リスト
    public var fuNum: Int       //符数
    public var hanNum: Int      //翻数
    public var score: Score     //点数
    public var mentsuList: [Mentsu] //面子リスト

    //以下は解析の際にのみ用いるフールド
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
        self.kyoku = Kyoku()
        self.yakuList = []
        self.fuNum = -1
        self.hanNum = -1
        self.score = Score(child:-1,parent:-1,total:-1,manganScale: -1.0 )
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
    //有効なアガリかどうか。役無しやドラのみはfalse
    public func valid() -> Bool{
        return (self.score.total > 0) && !(yakuList.all{$0.isDora})
    }
    //役名のリスト。テストで使う
    public func yakuNameList() -> [String]{
        var strs : [String] = []
        for yaku in yakuList{
            strs.append(yaku.name)
        }
        return strs
    }
    public func copy() -> Agari{return Agari(mentsuList:mentsuList.copy())}
    public func toString() -> String{
        return "\(fuNum)符,\(hanNum)翻," + score.toString() + ",役リスト:" + join(",",yakuList.map({$0.kanji})) + ",面子リスト:" + join(",",mentsuList.map({ $0.toString()}))
    }
}
public func == (lhs: Agari, rhs: Agari) -> Bool {
    let lstr = join(",",lhs.mentsuList.map({ m in m.toString()}))
    let rstr = join(",",rhs.mentsuList.map({ m in m.toString()}))
    return lstr == rstr
}
public func < (lhs: Agari, rhs: Agari) -> Bool {
    return lhs.score.total == rhs.score.total ? lhs.hanNum < rhs.hanNum : lhs.score.total < rhs.score.total
}
public func > (lhs: Agari, rhs: Agari) -> Bool {
    return lhs.score.total == rhs.score.total ? lhs.hanNum > rhs.hanNum : lhs.score.total > rhs.score.total
}


