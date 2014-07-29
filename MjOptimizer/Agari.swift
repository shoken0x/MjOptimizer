//
//  Agari.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

public class Agari:Equatable{
    public var tsumoPai: Pai
    public var atama: ToitsuMentsu
    public var mentsuList: [Mentsu]
    public var furoMentsuList: [Mentsu]
    public var menzenMentsuList: [Mentsu]
    public init(tsumoPai:Pai,atama :ToitsuMentsu,menzenMentsuList:[Mentsu]) {
        self.tsumoPai = tsumoPai
        self.mentsuList = menzenMentsuList
        self.atama = atama
        self.menzenMentsuList = menzenMentsuList
        self.furoMentsuList = []
    }
    public func toString() -> String{
        return "ツモ:" + tsumoPai.toString() + ";雀頭:" + atama.toString() + ";面子リスト:" + join(",",mentsuList.map({ m in m.toString()}))
    }
    public func addFuroMentsuList(furoMentsuList:[Mentsu]){
        for mentsu in furoMentsuList{
            self.furoMentsuList.append(mentsu)
            self.mentsuList.append(mentsu)
        }
    }
}
public func == (lhs: Agari, rhs: Agari) -> Bool {
    let lstr = join(",",lhs.mentsuList.map({ m in m.toString()}))
    let rstr = join(",",rhs.mentsuList.map({ m in m.toString()}))
    return lhs.tsumoPai == rhs.tsumoPai && lhs.atama == rhs.atama && lstr == rstr
}
