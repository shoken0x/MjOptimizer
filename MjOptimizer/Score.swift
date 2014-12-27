//
//  Score.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/09/02.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

//得点クラス。
//得点計算結果(面子解析、役一覧、翻数、符数、点数)の全てを格納する。
//得点計算中はこのオブジェクトを更新することで計算が進む。
public class Score:Equatable,Comparable {

    public var agari: Agari     //アガリ
    public var kyoku: Kyoku     //局の状態
    public var yakuList: [Yaku] //役リスト
    public var point: Point     //点数
    public var candidateAgariList: [Agari] //候補となったアガリリスト
    public init(agari:Agari,kyoku:Kyoku,yakuList:[Yaku],point: Point,candidateAgariList:[Agari]) {
        self.agari = agari
        self.kyoku = kyoku
        self.yakuList = yakuList
        self.point = point
        self.candidateAgariList = candidateAgariList
    }
    
    //有効なアガリかどうか。役無しやドラのみはfalse
    public func valid() -> Bool{
        return (self.point.total > 0) && !(self.yakuList.all{$0.isDora})
    }

    //役名のリスト。テストで使う
    public func yakuNameList() -> [String]{
        var strs : [String] = []
        for yaku in yakuList{
            strs.append(yaku.name)
        }
        return strs
    }
    public func toString() -> String{
        return point.toString() + ",役リスト:" + join(",",yakuList.map({$0.kanji})) + ",面子リスト:" + join(",",agari.mentsuList.map({ $0.toString()}))
    }
}

public func == (lhs: Score, rhs: Score) -> Bool {
    let lstr = join(",",lhs.agari.mentsuList.map({ m in m.toString()}))
    let rstr = join(",",rhs.agari.mentsuList.map({ m in m.toString()}))
    return lstr == rstr
}
public func < (lhs: Score, rhs: Score) -> Bool {
    return lhs.point.total == rhs.point.total ? lhs.point.hanNum < rhs.point.hanNum : lhs.point.total < rhs.point.total
}
public func > (lhs: Score, rhs: Score) -> Bool {
    return lhs.point.total == rhs.point.total ? lhs.point.hanNum > rhs.point.hanNum : lhs.point.total > rhs.point.total
}

