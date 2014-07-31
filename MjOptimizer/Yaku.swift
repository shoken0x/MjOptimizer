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

//リーチ

//平和
public class YakuPinfu : Yaku{
    public init(){}
    override public func name() -> String{return "pinfu"}
    override public func kanji() -> String{return "平和"}
    override public func hanNum() -> Int{return 1}
    override public func nakiHanNum() -> Int{return 0}
    override public func isConcluded(agari:Agari,kyoku:Kyoku) -> Bool {
        return  agari.mentsuList.filter{$0 is ShuntsuMentsu}.count == 4 && //4シュンツ
                agari.mentsuList.filter{$0 is ToitsuMentsu}.count == 1 && //1トイツ
                !(agari.atama.pai.isSangen)  && //雀頭が三元牌ではない
                agari.atama.pai != kyoku.jikaze.toPai() && //雀頭が自風ではない
                agari.atama.pai != kyoku.bakaze.toPai() && //雀頭が場風ではない
                agari.isRyanmenMachi() //待ちが両面であること
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
        for mentsuConbi : [Mentsu] in agari.mentsuList.conbination(){
            if mentsuConbi[0] == mentsuConbi[1] {
                return true
            }
        }
        return false
    }
}
//def iipeikou?(tehai, kyoku)
//#鳴きなし判定
//return false if tehai.naki?
//
//tehai.shuntsu_list.combination(2).any? do |pair|
//pair[0] == pair[1]
//end
//end
//
//### 一発
//def ippatsu?(tehai, kyoku)
//kyoku.is_ippatsu
//end
//
//### 門前清自摸和
//def tsumo?(tehai, kyoku)
//kyoku.is_tsumo and not tehai.naki?
//end
//
//### 自風(東)
//def jikazeton?(tehai, kyoku)
//return false if kyoku.jikaze != Kyoku::KYOKU_KAZE_TON
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.ton?
//end
//end
//
//### 自風(南)
//def jikazenan?(tehai, kyoku)
//return false if kyoku.jikaze != Kyoku::KYOKU_KAZE_NAN
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.nan?
//end
//end
//
//### 自風(西)
//def jikazesha?(tehai, kyoku)
//return false if kyoku.jikaze != Kyoku::KYOKU_KAZE_SHA
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.sha?
//end
//end
//
//### 自風(北)
//def jikazepei?(tehai, kyoku)
//return false if kyoku.jikaze != Kyoku::KYOKU_KAZE_PEI
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.pei?
//end
//end
//
//### 場風(東)
//def bakazeton?(tehai, kyoku)
//return false if kyoku.bakaze != Kyoku::KYOKU_KAZE_TON
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.ton?
//end
//end
//
//### 場風(南)
//def bakazenan?(tehai, kyoku)
//return false if kyoku.bakaze != Kyoku::KYOKU_KAZE_NAN
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.nan?
//end
//end
//
//### 場風(西)
//def bakazesha?(tehai, kyoku)
//return false if kyoku.bakaze != Kyoku::KYOKU_KAZE_SHA
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.sha?
//end
//end
//
//### 場風(北)
//def bakazepei?(tehai, kyoku)
//return false if kyoku.bakaze != Kyoku::KYOKU_KAZE_PEI
//
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.pei?
//end
//end
//
//### 白
//def haku?(tehai, kyoku)
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.haku?
//end
//end
//
//### 發
//def hatsu?(tehai, kyoku)
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.hatsu?
//end
//end
//
//### 中
//def chun?(tehai, kyoku)
//tehai.mentsu_list.any? do |mentsu|
//(mentsu.koutsu? or mentsu.kantsu?) and mentsu.identical.chun?
//end
//end
//
//### 海底摸月
//def haitei?(tehai, kyoku)
//kyoku.is_haitei and kyoku.is_tsumo
//end
//
//### 河底撈魚
//def houtei?(tehai, kyoku)
//kyoku.is_haitei and not kyoku.is_tsumo
//end
//
//### 嶺上開花
//def rinshan?(tehai, kyoku)
//kyoku.is_rinshan and kyoku.is_tsumo
//end
//
//### 槍槓
//def chankan?(tehai, kyoku)
//kyoku.is_chankan and not kyoku.is_tsumo
//end
//
////