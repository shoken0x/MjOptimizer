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
        if agari.includeFuro(){return false}
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
        return agari.mentsuList.all{$0.isYaochu()} && // 頭と全ての面子がヤオチュウ牌であること
        agari.mentsuList.any{$0.isJihai()} && // 必ず一つは字牌があること
        agari.mentsuList.any{$0 is DifferentPaiMentsu} // 必ず一つはシュンツがあること
    }
}


//一気通貫
// def ikkitsukan?(tehai, kyoku)
//   flag_onetwothree = false
//   flag_fourfivesix = false
//   flag_seveneightnine = false

//   //マンズ
//   tehai.shuntsu_list.each do |mentsu|
//     if mentsu.identical.manzu?
//       case mentsu.identical.number
//       when 1
//         flag_onetwothree = true
//       when 4
//         flag_fourfivesix = true
//       when 7
//         flag_seveneightnine = true
//       end
//     end
//   end
//   if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
//     return true
//   end

//   flag_onetwothree = false
//   flag_fourfivesix = false
//   flag_seveneightnine = false

//   //ソウズ
//   tehai.shuntsu_list.each do |mentsu|
//     if mentsu.identical.souzu?
//       case mentsu.identical.number
//       when 1
//         flag_onetwothree = true
//       when 4
//         flag_fourfivesix = true
//       when 7
//         flag_seveneightnine = true
//       end
//     end
//   end
//   if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
//     return true
//   end

//   flag_onetwothree = false
//   flag_fourfivesix = false
//   flag_seveneightnine = false

//   //ピンズ
//   tehai.shuntsu_list.each do |mentsu|
//     if mentsu.identical.pinzu?
//       case mentsu.identical.number
//       when 1
//         flag_onetwothree = true
//       when 4
//         flag_fourfivesix = true
//       when 7
//         flag_seveneightnine = true
//       end
//     end
//   end
//   if flag_onetwothree && flag_fourfivesix && flag_seveneightnine
//     return true
//   end

//   return false
// end

//三色同順
// def sanshoku?(tehai, kyoku)
//   tehai.shuntsu_list.each do |mentsu|
//     tehai.shuntsu_list.each do |mentsu2|
//       next unless mentsu.identical.type != mentsu2.identical.type
//       next unless mentsu.identical.number == mentsu2.identical.number
//       tehai.shuntsu_list.each do |mentsu3|
//         next unless mentsu.identical.type != mentsu3.identical.type && mentsu2.identical.type != mentsu3.identical.type
//         return true if mentsu.identical.number == mentsu3.identical.number
//       end
//     end
//   end
//   return false
// end

//三色同刻
// def sanshokudouko?(tehai, kyoku)
//   tehai.koutsu_list.each do | mentsu |
//     tehai.koutsu_list.each do | mentsu2 |
//       next unless mentsu.identical.type != mentsu2.identical.type
//       next unless  mentsu.identical.number == mentsu2.identical.number
//       tehai.koutsu_list.each do | mentsu3 |
//         next unless mentsu.identical.type != mentsu3.identical.type && mentsu2.identical.type != mentsu3.identical.type
//         return true if mentsu.identical.number == mentsu3.identical.number
//       end
//     end
//   end
//   return false
// end

//対々和
// def toitoihou?(tehai, kyoku)
//   // 特殊系ではない かつ 全ての面子が刻子ならOK
//   return false if tehai.tokusyu?
//   tehai.mentsu_list.all?{|mentsu| mentsu.koutsu? }
// end

//三暗刻
// def sanankou?(tehai, kyoku)
//   return false if tehai.tokusyu?
//   tehai.koutsu_list.count{|mentsu| mentsu.ankou? } >= 3
// end

//三槓子
// def sankantsu?(tehai, kyoku)
//   return false if tehai.tokusyu?
//   tehai.kantsu_list.count >= 3
// end


//小三元
// def shousangen?(tehai, kyoku)
//   //頭が三元牌じゃなかったらfalse
//   return false unless tehai.atama.sangenpai?

//   //三元牌の刻子、槓子があること
//   has_haku = tehai.koutsu_list.any? {|mentsu| mentsu.identical.haku? }
//   has_hatsu = tehai.koutsu_list.any? {|mentsu| mentsu.identical.hatsu? }
//   has_chun = tehai.koutsu_list.any? {|mentsu| mentsu.identical.chun? }

//   return (has_haku && has_hatsu) || (has_haku && has_chun) || (has_hatsu && has_chun)
// end

//混老頭
// def honroutou?(tehai, kyoku)
//   // 頭がヤオチュウ牌であること
//   return false unless tehai.atama.yaochu?

//   // 全ての面子がヤオチュウ牌関連 かつ 刻子であること
//   return false unless tehai.mentsu_list.all?{|mentsu| mentsu.koutsu? and mentsu.yaochu? }

//   // 必ず一つは字牌があること
//   return false unless tehai.atama.jihai? or tehai.mentsu_list.any?{|mentsu| mentsu.jihai? }

//   // 必ず一つは数牌があること
//   return false unless tehai.atama.suhai? or tehai.mentsu_list.any?{|mentsu| mentsu.suhai? }

//   return true
// end

