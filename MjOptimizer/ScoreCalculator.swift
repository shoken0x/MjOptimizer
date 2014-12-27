//
//  PointCalculator.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/08/11.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

//得点計算結果
public enum ScoreCalcResult{
    case SUCCESS(Score) //得点計算に成功した場合、Scoreを返す
    case ERROR(String) //得点計算に失敗した場合、エラーメッセージを返す
}

//得点計算のメイン関数。
//これをUI側から呼び出して得点を計算する。
public class ScoreCalculator{
    //引数の文字列("m1tm2tm3t")と局状態から役と得点を計算する。
    public class func calcFromStr(paiStr : String,kyoku:Kyoku = Kyoku()) -> ScoreCalcResult{
        let paiList : [Pai]? = Pai.parseList(paiStr)
        if(paiList != nil){
            return calc(paiList!,kyoku:kyoku)
        }
        return ScoreCalcResult.ERROR("引数の文字列が不正な牌リストの形式です:" + paiStr)
    }

    //牌のリストと局状態から役と得点を計算する。
    public class func calc(paiList:[Pai],kyoku:Kyoku = Kyoku())  -> ScoreCalcResult{
        //文字列を面子に分解する
        let mentsuResolveResult = MentsuResolver.resolve(paiList)
        switch mentsuResolveResult{
        case let .ERROR(str):
            return ScoreCalcResult.ERROR(str)
        case let .SUCCESS(agariList):
            return calcScore(agariList,kyoku: kyoku)
        }
    }
    
    //再計算する.局の情報が更新されたときに使う
    public class func recalc(score:Score) -> ScoreCalcResult{
        return calcScore(score.candidateAgariList,kyoku: score.kyoku)
    }
    
    //各アガリについて役、翻数、符、点を計算してScoreを作っていく
    public class func calcScore(agariList:[Agari],kyoku:Kyoku = Kyoku())  -> ScoreCalcResult{
        var scoreList : [Score] = []
        for agari in agariList{
            //役を計算
            var yakuList:[Yaku] = yakuJudge(agari, kyoku:kyoku)
            if yakuList.count != 0{
                //翻数を計算
                var hanNum : Int = 0
                for yaku in yakuList{
                    hanNum += agari.includeNaki() ?  yaku.nakiHanNum : yaku.hanNum
                }
                //符を計算
                var fuNum : Int = calcFuNum(agari,kyoku:kyoku)
                //点数を計算
                var point : Point = calcPoint(fuNum, hanNum:hanNum,kyoku:kyoku)
                //Scoreを作成
                scoreList.append(Score(agari: agari, kyoku: kyoku, yakuList: yakuList, point: point,candidateAgariList: agariList))
            }
        }//end for
        //deubg
        Log.info("得られたScore一覧")
        for score in scoreList{
            Log.info(score.toString())
        }
        if scoreList.count != 0 {
            let maxScore : Score = scoreList.max()
            if(maxScore.valid()){
                return ScoreCalcResult.SUCCESS(maxScore)
            }else{
                return ScoreCalcResult.ERROR("役がありません")
            }
        }else{
            return ScoreCalcResult.ERROR("役がありません")
        }

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
            if(yaku != nil){
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
    public class func calcPoint(fuNum:Int,hanNum:Int,kyoku:Kyoku)->Point{
        var isParent = kyoku.isParent()
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
        return Point(fuNum:fuNum,hanNum:hanNum,child:c,parent:p,total:t,manganScale:m)
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
