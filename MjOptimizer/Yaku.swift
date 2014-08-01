//
//  Yaku.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

protocol YakuProtocol{
    func name() -> String
    func kanji() -> String
    func hanNum() -> Int
    func nakiHanNum() -> Int
    func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool
}
//親クラス
public class Yaku:YakuProtocol{
    public init(){}
    public func name() -> String{return ""}
    public func kanji() -> String{return ""}
    public func hanNum() -> Int{return -200}
    public func nakiHanNum() -> Int{return -200}
    public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool{return false}
}

//-------------
// １翻
//-------------

//リーチ

//平和
public class YakuPinfu : Yaku{
    public init(){}
    override public func name() -> String{return "pinfu"}
    override public func kanji() -> String{return "平和"}
    override public func hanNum() -> Int{return 1}
    override public func nakiHanNum() -> Int{return 0}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        var shuntsuList:[Mentsu] = agari.mentsuList.filter{$0.type() == MentsuType.SHUNTSU}
        var toitsuList:[Mentsu] = agari.mentsuList.filter{$0.type() == MentsuType.TOITSU}
        return  shuntsuList.count == 4 && //4シュンツ
                toitsuList.count == 1 && //1トイツ
                !(toitsuList[0].identical().isSangen) && //雀頭が三元牌ではない
                toitsuList[0].identical() != kyoku.jikaze.toPai() && //雀頭が自風ではない
                toitsuList[0].identical() != kyoku.bakaze.toPai() && //雀頭が場風ではない
            shuntsuList.any{$0.isRyanmenmachi()} //待ちが両面であること
    }
}

//断么九
public class YakuTanyao : Yaku{
    public init(){}
    override public func name() -> String{return "tanyao"}
    override public func kanji() -> String{return "断么九"}
    override public func hanNum() -> Int{return 1}
    override public func nakiHanNum() -> Int{return 1}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        return agari.mentsuList.all({$0.isChuchan()})
    }
}

//一盃口
public class YakuIipeikou : Yaku{
    public init(){}
    override public func name() -> String{return "iipeikou"}
    override public func kanji() -> String{return "一盃口"}
    override public func hanNum() -> Int{return 1}
    override public func nakiHanNum() -> Int{return 0}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        if agari.includeNaki(){return false}
        for mentsuConbi : [Mentsu] in agari.mentsuList.conbination(){
            if mentsuConbi[0] == mentsuConbi[1] {return true}
        }
        return false
    }
}

//一発
//門前清自摸和
//自風(東)
//自風(南)
//自風(西)
//自風(北)
//場風(東)
//場風(南)
//場風(西)
//場風(北)
//白
//發
//中
//海底摸月
//河底撈魚
//嶺上開花
//槍槓

//-------------
// ２翻
//-------------


//ダブル立直
//七対子

public class YakuChantaKei{
    
}

//混全帯么九
public class YakuChanta : Yaku{
    public init(){}
    override public func name() -> String{return "chanta"}
    override public func kanji() -> String{return "混全帯么九"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 1}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        return agari.mentsuList.all{!($0.isChuchan())} && // チュウチャン牌のみからなる面子が一枚もないこと
            agari.mentsuList.any{$0.isJihai()} && // 必ず一つは字牌があること
            agari.mentsuList.any{$0.consistOfDifferentPai()} // 必ず一つはシュンツがあること
    }
}


//一気通貫
public class YakuIkkitsukan : Yaku{
    public init(){}
    override public func name() -> String{return "ikkitsukan"}
    override public func kanji() -> String{return "一気通貫"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 1}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        let manzu:[Mentsu] = agari.mentsuList.filter{($0.consistOfDifferentPai() && $0.paiType() == PaiType.MANZU)}
        let souzu:[Mentsu] = agari.mentsuList.filter{($0.consistOfDifferentPai() && $0.paiType() == PaiType.SOUZU)}
        let pinzu:[Mentsu] = agari.mentsuList.filter{($0.consistOfDifferentPai() && $0.paiType() == PaiType.PINZU)}
        for mentsuList in [manzu,souzu,pinzu]{
            var no123 = 0
            var no456 = 0
            var no789 = 0
            for mentsu in mentsuList{
                switch mentsu.identical().number{
                case 1: no123++
                case 4: no456++
                case 7: no789++
                default: 0//do nothing
                }
            }
            if (no123 > 0 && no456 > 0 && no789 > 0) {
                return true
            }
        }
        return false
    }
}


//三色同順
public class YakuSansyoku : Yaku{
    public init(){}
    override public func name() -> String{return "sansyoku"}
    override public func kanji() -> String{return "三色同順"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 1}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        //シュンツorチー面子を３個組にしたリストを取得
        let tmp = (agari.mentsuList.filter{$0.consistOfDifferentPai()}).tripleConbination()
        for mentsuConbi : [Mentsu] in tmp{
            if( mentsuConbi[0].identical().type != mentsuConbi[1].identical().type &&
                mentsuConbi[1].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().number == mentsuConbi[1].identical().number &&
                mentsuConbi[1].identical().number == mentsuConbi[2].identical().number ){
            return true
            }
        }
        return false
    }
}

//三色同刻
public class YakuSansyokudouko : Yaku{
    public init(){}
    override public func name() -> String{return "sansyokudouko"}
    override public func kanji() -> String{return "三色同刻"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 2}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        //アンコウorミンコウorアンカンorミンカン面子を３個組にしたリストを取得
        let tmp = (agari.mentsuList.filter{($0.consistOfSamePai() && $0.type() != MentsuType.TOITSU)}).tripleConbination()
        for mentsuConbi : [Mentsu] in tmp{
            if( mentsuConbi[0].identical().type != mentsuConbi[1].identical().type &&
                mentsuConbi[1].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().number == mentsuConbi[1].identical().number &&
                mentsuConbi[1].identical().number == mentsuConbi[2].identical().number ){
                    return true
            }
        }
        return false
    }
}


//対々和
public class YakuToitoihou : Yaku{
    public init(){}
    override public func name() -> String{return "toitoihou"}
    override public func kanji() -> String{return "対々和"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 2}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        return agari.mentsuList.all{$0.consistOfSamePai()}
    }
}

//三暗刻
public class YakuSanankou : Yaku{
    public init(){}
    override public func name() -> String{return "sanankou"}
    override public func kanji() -> String{return "三暗刻"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 2}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        if kyoku.isTsumo{
            return agari.mentsuList.filter{$0.type() == MentsuType.ANKOU}.count == 3
        }else{
            //ロンの場合はアガリ牌を含む面子は除外
            return agari.mentsuList.filter{( $0.type() == MentsuType.ANKOU && !($0.includeAgariPai()) )}.count == 3
        }
    }
}

//三槓子
public class YakuSankantsu : Yaku{
    public init(){}
    override public func name() -> String{return "sankantsu"}
    override public func kanji() -> String{return "三槓子"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 2}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        return agari.mentsuList.filter{($0.type() == MentsuType.ANKAN || $0.type() == MentsuType.MINKAN)}.count == 3
    }
}

//小三元
public class YakuShousangen : Yaku{
    public init(){}
    override public func name() -> String{return "shousangen"}
    override public func kanji() -> String{return "小三元"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 2}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        return agari.mentsuList.filter{$0.isSangen()}.count == 3 && //三元牌からなる面子が３つある
            agari.mentsuList.filter{($0.isSangen() && $0.type() == MentsuType.TOITSU)}.count == 1 //三元牌からなるトイツが一つある
    }
}

//混老頭
public class YakuHonroutou : Yaku{
    public init(){}
    override public func name() -> String{return "Honroutou"}
    override public func kanji() -> String{return "混老頭"}
    override public func hanNum() -> Int{return 2}
    override public func nakiHanNum() -> Int{return 2}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        return agari.mentsuList.all{$0.isYaochu()} && // １９字牌しかないこと
            agari.mentsuList.any{$0.isJihai()} && // 必ず一つは字牌があること
            agari.mentsuList.any{!($0.isJihai())} // 必ず一つは数牌があること
    }
}
