//
//  Yaku.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/29.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class Yaku {
    public let name:String
    public let kanji:String
    public let hanNum:Int
    public let nakiHanNum:Int
    public let isYakuman:Bool
    init(name:String,kanji:String,hanNum:Int = 13,nakiHanNum:Int = 13){
        self.name = name
        self.kanji = kanji
        self.hanNum = hanNum
        self.nakiHanNum = nakiHanNum
        self.isYakuman = hanNum == 13
    }
}

protocol YakuChecker {
    func check(agari:Agari,kyoku:Kyoku) -> Yaku?
}

//平和
public class YCPinfu : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        var shuntsuList:[Mentsu] = agari.mentsuList.filter{$0.type() == MentsuType.SHUNTSU}
        var toitsuList:[Mentsu] = agari.mentsuList.filter{$0.type() == MentsuType.TOITSU}
        if( shuntsuList.count == 4 && //4シュンツ
            toitsuList.count == 1 && //1トイツ
            !(toitsuList[0].identical().isSangen) && //雀頭が三元牌ではない
            toitsuList[0].identical() != kyoku.jikaze.toPai() && //雀頭が自風ではない
            toitsuList[0].identical() != kyoku.bakaze.toPai() && //雀頭が場風ではない
            shuntsuList.any{$0.isRyanmenmachi()} //待ちが両面であること
            ){
                return Yaku(name:"pinfu",kanji:"平和",hanNum:1,nakiHanNum:0)
        }
        return nil
    }
}

//断么九
public class YCTanyao : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        if agari.mentsuList.all({$0.isChuchan()}) {
            return Yaku(name:"tanyao",kanji:"断么九",hanNum:1,nakiHanNum:1)
        }
        return nil
    }
}

//一盃口/二盃口
public class YCPeikou : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        if agari.includeNaki(){return nil}
        var count = 0
        for mentsuConbi : [Mentsu] in agari.mentsuList.conbination(){
            if mentsuConbi[0] == mentsuConbi[1] {count++ }
        }
        switch count{
        case 1: return Yaku(name:"iipeikou",kanji:"一盃口",hanNum:1,nakiHanNum:0)
        case 2: return Yaku(name:"ryanpeikou",kanji:"二盃口",hanNum:3,nakiHanNum:0)
        default: return nil
        }
    }
}


//混全帯么九/混老頭/純全帯么九/清老頭
public class YCChanta : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        if ( agari.mentsuList.all{!($0.isChuchan())} ){ // チュウチャン牌のみからなる面子が一枚もないこと=ヤオチュウ+123+789
            if ( agari.mentsuList.any{$0.isJihai()} ){ // 字牌があること
                if ( agari.mentsuList.any{$0.consistOfDifferentPai()} ){// シュンツがある
                    return Yaku(name:"chanta",kanji:"混全帯么九",hanNum:2,nakiHanNum:1)
                }else { //シュンツがない
                    return Yaku(name:"honroutou",kanji:"混老頭",hanNum:2,nakiHanNum:2)
                }
            }else {// 字牌がない
                if ( agari.mentsuList.any{$0.consistOfDifferentPai()} ){// シュンツがある
                    return Yaku(name:"chanta",kanji:"純全帯么九",hanNum:3,nakiHanNum:2)
                }else { //シュンツがない
                    return Yaku(name:"chinroutou",kanji:"清老頭")
                }
            }
        }
        return nil
    }
}

//一気通貫
public class YCIkkitsukan : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
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
                return Yaku(name:"ikkitsukan",kanji:"一気通貫",hanNum:2,nakiHanNum:1)
            }
        }
        return nil
    }
}


//三色同順
public class YCSansyoku : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        //シュンツorチー面子を３個組にしたリストを取得
        let tmp = (agari.mentsuList.filter{$0.consistOfDifferentPai()}).tripleConbination()
        for mentsuConbi : [Mentsu] in tmp{
            if( mentsuConbi[0].identical().type != mentsuConbi[1].identical().type &&
                mentsuConbi[1].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().number == mentsuConbi[1].identical().number &&
                mentsuConbi[1].identical().number == mentsuConbi[2].identical().number ){
                    return Yaku(name:"sansyoku",kanji:"三色同順",hanNum:2,nakiHanNum:1)
            }
        }
        return nil
    }
}

//三色同刻
public class YCSansyokudouko : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        //アンコウorミンコウorアンカンorミンカン面子を３個組にしたリストを取得
        let tmp = (agari.mentsuList.filter{($0.consistOfSamePai() && $0.type() != MentsuType.TOITSU)}).tripleConbination()
        for mentsuConbi : [Mentsu] in tmp{
            if( mentsuConbi[0].identical().type != mentsuConbi[1].identical().type &&
                mentsuConbi[1].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().type != mentsuConbi[2].identical().type &&
                mentsuConbi[0].identical().number == mentsuConbi[1].identical().number &&
                mentsuConbi[1].identical().number == mentsuConbi[2].identical().number ){
                    return Yaku(name:"sansyokudouko",kanji:"三色同刻",hanNum:2,nakiHanNum:2)
            }
        }
        return nil
    }
}

//対々和
public class YCToitoihou : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        if(agari.mentsuList.all{$0.consistOfSamePai()}){
            return Yaku(name:"toitoihou",kanji:"対々和",hanNum:2,nakiHanNum:2)
        }
        return nil
    }
}

//三暗刻//四暗刻
public class YCAnkou : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        var ankouNum : Int
        if kyoku.isTsumo{
            ankouNum = agari.mentsuList.filter{$0.type() == MentsuType.ANKOU}.count
        }else{
            //ロンの場合はアガリ牌を含む面子は除外
            ankouNum = agari.mentsuList.filter{( $0.type() == MentsuType.ANKOU && !($0.includeAgariPai()) )}.count
        }
        switch ankouNum{
        case 3: return Yaku(name:"sanankou",kanji:"三暗刻",hanNum:2,nakiHanNum:2)
        case 4: return Yaku(name:"suankou",kanji:"四暗刻") // TODO すったん
        default: return nil
        }
    }
}

//三槓子//四槓子
public class YCKantsu : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        var kantsuNum = agari.mentsuList.filter{($0.type() == MentsuType.ANKAN || $0.type() == MentsuType.MINKAN)}.count
        switch kantsuNum{
        case 3: return Yaku(name:"sankantsu",kanji:"三槓子",hanNum:2,nakiHanNum:2)
        case 4: return Yaku(name:"sukantsu",kanji:"四槓子")
        default: return nil
        }
    }
}

//小三元/大三元
public class YCSangen : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        if(agari.mentsuList.filter{$0.isSangen()}.count == 3){//三元牌からなる面子が３つある
            var toitsuNum:Int = agari.mentsuList.filter{($0.isSangen() && $0.type() == MentsuType.TOITSU)}.count
            switch toitsuNum{
            case 1: return Yaku(name:"shousangen",kanji:"小三元",hanNum:1,nakiHanNum:0)//三元牌からなるトイツが一つある
            case 0: return Yaku(name:"daisangen",kanji:"大三元")
            default:return nil //三元牌を含むチートイなど
            }
        }
        return nil
    }
}



//小四喜/大四喜
public class YCSushihou : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        if(agari.mentsuList.filter{$0.isKaze()}.count == 4){//風牌からなる面子が4つある
            var toitsuNum:Int = agari.mentsuList.filter{($0.isKaze() && $0.type() == MentsuType.TOITSU)}.count
            switch toitsuNum{
            case 1: return Yaku(name:"shousushi",kanji:"小四喜")//風牌からなるトイツが一つある
            case 0: return Yaku(name:"daisushi",kanji:"大四喜")
            default:return nil //風牌を含むチートイなど
            }
        }
        return nil
    }
}

//混一色//清一色//字一色//緑一色//九蓮宝燈
public class YCSomete : YakuChecker{
    public init(){} ; public func check(agari:Agari,kyoku:Kyoku) -> Yaku?{
        let jihaiNum : Int = agari.mentsuList.filter{$0.isJihai()}.count
        let manzuNum : Int = agari.mentsuList.filter{$0.identical().type == PaiType.MANZU}.count
        let souzuNum : Int = agari.mentsuList.filter{$0.identical().type == PaiType.SOUZU}.count
        let pinzuNum : Int = agari.mentsuList.filter{$0.identical().type == PaiType.PINZU}.count
        if ((manzuNum == 0 && souzuNum == 0 ) ||
            (souzuNum == 0 && pinzuNum == 0 ) ||
            (manzuNum == 0 && pinzuNum == 0 )){ //１色しかない
                //まずは緑一色判定
                if (agari.mentsuList.all{$0.isGreen()}){
                    return Yaku(name:"ryuisou",kanji:"緑一色")
                }
                if (jihaiNum == 0){ //字牌なし
                    //九蓮宝燈判定
                    if(!agari.includeNaki()){//鳴きはない
                        //すべての牌をカウントして、1と9が3枚以上、2〜8が１枚以上であれば成立
                        var count:[Int] = [0,0,0,0,0,0,0,0,0,0]
                        for mentsu in agari.mentsuList{
                            for pai in mentsu.paiArray(){
                                count[pai.number]++
                            }
                        }
                        //TODO 純正九蓮宝燈
                        if count[1] >= 3 && count[2] >= 1 && count[3] >= 1 && count[4] >= 1 && count[5] >= 1 && count[6] >= 1 && count[7] >= 1 && count[8] >= 1 && count[9] >= 3{
                             return Yaku(name:"honisou",kanji:"九蓮宝燈")
                        }
                    }
                    return Yaku(name:"honisou",kanji:"清一色",hanNum:6,nakiHanNum:5)
                }else{ // 字牌あり
                    if (manzuNum == 0 && pinzuNum == 0 && souzuNum == 0){ //数牌無し
                        return Yaku(name:"tsuisou",kanji:"文一色")
                    }else{
                        return Yaku(name:"honisou",kanji:"混一色",hanNum:3,nakiHanNum:2)
                }
                
            }
        }
        return nil
    }
}

//七対子

//国士無双

//---------------------
// 局で決まる役
//---------------------

//ドラ
//リーチ
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
//ダブル立直
//天和
//地和
//しーさんぷーた