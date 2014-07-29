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
    func isConcluded(agari:Agari) -> Bool
}
public class Yaku:YakuProtocol{
    public init(){}
    public func name() -> String{return ""}
    public func kanji() -> String{return ""}
    public func hanNum() -> Int{return -200}
    public func nakiHanNum() -> Int{return -200}
    public func isConcluded(agari:Agari) -> Bool{return false}
}

////  ### リーチ
//def reach?(tehai, kyoku)
//kyoku.reach?
//end
//
//### 平和
//def pinfu?(tehai, kyoku)
//#鳴きなし判定
//return false if tehai.naki?
//
//#全てが順子であること
//return false unless tehai.mentsu_list.all? {|mentsu| mentsu.shuntsu? }
//
//#頭が役牌ではないこと
//return false if tehai.atama.yakupai?(kyoku)
//
//#待ちが両面であること
//return false unless tehai.ryanmen_agari?
//
//return true
//end
//

//### 断么九
//def tanyao?(tehai, kyoku)
//return false if tehai.atama.yaochu?
//return false if tehai.mentsu_list.any?{|mentsu| mentsu.yaochu? }
//
//return true
//end
//
public class YakuTanyao : Yaku{
    public init(){}
    override public func name() -> String{return "tanyao"}
    override public func kanji() -> String{return "断么九"}
    override public func hanNum() -> Int{return 1}
    override public func nakiHanNum() -> Int{return 1}
    override public func isConcluded(agari:Agari) -> Bool {
        for mentsu in agari.mentsuList{
            if !(mentsu.isChuchan()) {
                return false
            }
        }
        return true
    }
}

//### 一盃口
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