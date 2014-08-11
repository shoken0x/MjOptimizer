//
//  MjParse.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/11.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation
public enum MjParseResult{
    case SUCCESS(Agari) //アガリ
    case ERROR(String) //入力不正
}

public class MjParse{
    //得点計算のメイン関数。引数の文字列から役と得点を計算する。
    public class func parse(paiStr : String,kyoku:Kyoku) -> MjParseResult{
        let paiList : [Pai]? = Pai.parseList(paiStr)
        if(paiList){
            //文字列を面子に分解する
            let mentsuResolveResult = MentsuResolver.resolve(paiList!)
            switch mentsuResolveResult{
            case let .ERROR(str):
                return MjParseResult.ERROR(str)
            case let .SUCCESS(agariList):
                for agari in agariList{
                    //各アガリについて役、翻数、符、点を計算して更新していく
                    //役を計算
                    agari.yakuList = yakuJudge(agari, kyoku:kyoku)
                    if agari.yakuList.count != 0{
                        //翻数を計算
                        var hanNum : Int = 0
                        for yaku in agari.yakuList{
                            hanNum += agari.includeNaki() ?  yaku.nakiHanNum : yaku.hanNum
                        }
                        agari.hanNum = hanNum
                        //符を計算
                        agari.fuNum = calcFuNum(agari,kyoku:kyoku)
                        //点数を計算
                        agari.score = calcPoint(agari.fuNum, hanNum:agari.hanNum,kyoku:kyoku)
                    }
                }//end for
                //deubg
                Log.info("得られたアガリ一覧")
                for agari in agariList{
                    Log.info(agari.toString())
                }
                let maxAgari : Agari = agariList.max()
                if(maxAgari.valid()){
                    return MjParseResult.SUCCESS(maxAgari)
                }else{
                    return MjParseResult.ERROR("役がありません")
                }
            }//end switch
        }
        return MjParseResult.ERROR("引数の文字列が不正な牌リストの形式です:" + paiStr)
    }
    
    //役判定
    public class func yakuJudge(agari:Agari,kyoku:Kyoku)->[Yaku]{
        let yakuCheckerList :[YakuChecker] = [
            YCPinfu(),
            YCTanyao(),
            YCPeikou(),
            YCChanta(),
            YCIkkitsukan(),
            YCSansyoku(),
            YCSansyokudouko(),
            YCToitoihou(),
            YCAnkou(),
            YCKantsu(),
            YCSangen(),
            YCSushihou(),
            YCSomete(),
            YCChitoitsu(),
            YCKokushimuso(),
            YCHaku(),
            YCHatsu(),
            YCChun(),
            YCJikaze(),
            YCBakaze(),
            YCDora(),
            YCReach(),
            YCIppatsu(),
            YCTsumo(),
            YCFinishType()
        ]
        var yakuList:[Yaku] = []
        for yakuChecker in yakuCheckerList{
            var yaku : Yaku? = yakuChecker.check(agari,kyoku:kyoku)
            if(yaku){
                yakuList.append(yaku!)
            }
        }
        //役萬がある場合はそれ以外は除去
        if(yakuList.any{$0.isYakuman}){
            yakuList = yakuList.reject{!($0.isYakuman)}
        }
        return yakuList
    }
    
    //符計算
    public class func calcFuNum(agari:Agari,kyoku:Kyoku)->Int{
        //チートイツ
        if (agari.mentsuList.filter{$0.type() == MentsuType.TOITSU}.count == 7 ){
            return 25
        }else{
            var fuNum = 20
            for mentsu in agari.mentsuList{
                //debug println(mentsu.toString() + ":" + String(mentsu.fuNum(kyoku)))
                fuNum += mentsu.fuNum(kyoku)
            }
            if fuNum == 20 {
                if kyoku.isTsumo && !(agari.includeNaki()){
                    //面前ツモ20符のみはピンフ。例外で20
                    return 20
                }
                if !(kyoku.isTsumo) && agari.includeNaki(){
                    //鳴きロンピンフ系は例外で30符
                    return 30
                }
            }
            if kyoku.isTsumo{//ツモ
                fuNum += 2
            }else{//ロン
                if !(agari.includeNaki()){//鳴き無し
                    fuNum += 10
                }
            }
            return ceil1(fuNum)
        }
    }
    //点数計算
    public class func calcPoint(fuNum:Int,hanNum:Int,kyoku:Kyoku)->Score{
        var isParent = kyoku.isParent
        var isTsumo = kyoku.isTsumo
        var c:Int = 0
        var p:Int = 0
        var t:Int = 0
        var m:Float = 0
        var base:Int = 0
        if hanNum >= 5 {
            if hanNum >= 39 {
                m = 12.0 //トリプル役満
            }else if hanNum >= 26 {
                m = 8.0 //ダブル役満
            }else if hanNum >= 13 {
                m = 4.0 //役満
            }else if hanNum >= 11 {
                m = 3.0
            }else if hanNum >= 8 {
                m = 2.0
            }else if hanNum >= 6 {
                m = 1.5
            }else{
                m = 1.0
            }
            base = Int(m * 2000)
        }else{
            var tmp = 4 //下駄
            hanNum.times{ tmp = tmp * 2 }
            base = fuNum * tmp
            if(base > 2000){ //満貫
                base = 2000
                m = 1.0
            }
        }
        
        if isParent{
            if isTsumo{
                c = ceil10(base*2)
                t = c * 3
            }else{
                t = ceil10(base*6)
            }
        }else{
            if isTsumo{
                c = ceil10(base)
                p = ceil10(base*2)
                t = c * 2 + p
            }else{
                t = ceil10(base*4)
            }
        }
        c += kyoku.honbaNum * 100
        c += kyoku.honbaNum * 100
        t += kyoku.honbaNum * 300
        return Score(child:c,parent:p,total:t,manganScale:m)
    }
    
    //1の位切り上げ
    private class func ceil1(i:Int) -> Int{
        return ( i % 10 == 0 ) ? i : (Int(i / 10) * 10 + 10)
    }
    //10の位切り上げ
    private class func ceil10(i:Int) -> Int{
        return ( i % 100 == 0 ) ? i : (Int(i / 100) * 100 + 100)
    }
}


public class Score{
    public var child:Int //子の支払い
    public var parent:Int //親の支払い
    public var total:Int //収入総額
    public var manganScale:Float //満貫スケール
    public init(child:Int,parent:Int,total:Int,manganScale:Float){
        self.child = child
        self.parent = parent
        self.total = total
        self.manganScale = manganScale
    }
    public func toString() -> String{
        var str : String
        switch manganScale{
        case 1.0: str = "[満貫]"
        case 1.5: str = "[跳満]"
        case 2.0: str = "[倍満]"
        case 3.0: str = "[三倍満]"
        case 4.0: str = "[役満]"
        case 8.0: str = "[ダブル役満]"
        case 12.0: str = "[トリプル役満]"
        case 16.0: str = "[四倍役満]"
        default : str = ""
        }
        if parent == 0 && child == 0{
            return str + String(total) + "点"
        }else if parent == 0 {
            return str + String(child) + "オール 合計" + String(total) + "点"
        }else{
            return str + String(child) + "/" + String(parent) + " 合計" + String(total) + "点"
        }
    }
}


