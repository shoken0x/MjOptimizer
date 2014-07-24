//
//  Agari.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/23.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

class Agari:Equatable{
    var tsumoPai: Pai
    var atama: ToitsuMentsu
    var mentsuList: MentsuList
    var furoMentsuList: MentsuList
    var menzenMentsuList: MentsuList
    init(tsumoPai:Pai,atama :ToitsuMentsu,menzenMentsuList:MentsuList) {
        self.tsumoPai = tsumoPai
        self.mentsuList = menzenMentsuList
        self.atama = atama
        self.menzenMentsuList = menzenMentsuList
        self.furoMentsuList = MentsuList()
    }
    func toString() -> String{
        return "ツモ:" + tsumoPai.toString() + ";雀頭:" + atama.toString() + ";面子リスト:" + mentsuList.toString()
    }
    func addFuroMentsuList(furoMentsuList:MentsuList){
        self.furoMentsuList.union(mentsuList)
        self.mentsuList.union(mentsuList)
    }
}
func == (lhs: Agari, rhs: Agari) -> Bool {
    return lhs.tsumoPai == rhs.tsumoPai && lhs.atama == rhs.atama && lhs.mentsuList == rhs.mentsuList
}
