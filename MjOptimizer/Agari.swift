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
    public var mentsuList: MentsuList
    public var furoMentsuList: MentsuList
    public var menzenMentsuList: MentsuList
    public init(tsumoPai:Pai,atama :ToitsuMentsu,menzenMentsuList:MentsuList) {
        self.tsumoPai = tsumoPai
        self.mentsuList = menzenMentsuList
        self.atama = atama
        self.menzenMentsuList = menzenMentsuList
        self.furoMentsuList = MentsuList()
    }
    public func toString() -> String{
        return "ツモ:" + tsumoPai.toString() + ";雀頭:" + atama.toString() + ";面子リスト:" + mentsuList.toString()
    }
    public func addFuroMentsuList(furoMentsuList:MentsuList){
        self.furoMentsuList.union(furoMentsuList)
        self.mentsuList.union(furoMentsuList)
    }
}
public func == (lhs: Agari, rhs: Agari) -> Bool {
    return lhs.tsumoPai == rhs.tsumoPai && lhs.atama == rhs.atama && lhs.mentsuList == rhs.mentsuList
}
