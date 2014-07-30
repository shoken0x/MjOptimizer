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
    //通常のコンストラクタ
    public init(tsumoPai:Pai,atama :ToitsuMentsu,menzenMentsuList:[Mentsu],furoMentsuList:[Mentsu]) {
        self.tsumoPai = tsumoPai
        self.atama = atama
        self.menzenMentsuList = menzenMentsuList
        self.furoMentsuList = furoMentsuList
        self.mentsuList = menzenMentsuList
        for m in furoMentsuList{
            self.mentsuList.append(m)
        }
    }
    //先に面前牌を登録し、後から副露牌を足す場合のコンストラクタ
    public init(tsumoPai:Pai,atama :ToitsuMentsu,menzenMentsuList:[Mentsu]) {
        self.tsumoPai = tsumoPai
        self.mentsuList = menzenMentsuList
        self.atama = atama
        self.menzenMentsuList = menzenMentsuList
        self.furoMentsuList = []
    }
    public func addFuroMentsuList(furoMentsuList:[Mentsu]){
        for mentsu in furoMentsuList{
            self.furoMentsuList.append(mentsu)
            self.mentsuList.append(mentsu)
        }
    }
    //このアガリ系で両面待ちがあり得るか
    public func isRyanmenMachi()->Bool{
        for mentsu in menzenMentsuList{
            if mentsu.include(tsumoPai) {
                if let shuntsu = mentsu as? ShuntsuMentsu{
                    switch shuntsu.paiList.indexOf(tsumoPai)!{
                    case 0: return true
                    case 2: return true
                    default: -1 //do nothing
                    }
                }
            }
        }
        return false
    }
    public func toString() -> String{
        return "ツモ:" + tsumoPai.toString() + ";雀頭:" + atama.toString() + ";面子リスト:" + join(",",mentsuList.map({ $0.toString()}))
    }
}
public func == (lhs: Agari, rhs: Agari) -> Bool {
    let lstr = join(",",lhs.mentsuList.map({ m in m.toString()}))
    let rstr = join(",",rhs.mentsuList.map({ m in m.toString()}))
    return lhs.tsumoPai == rhs.tsumoPai && lhs.atama == rhs.atama && lstr == rstr
}
