//
//  MenzenResolver.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/01.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

enum MakeMentsuResult{
    case SUCCESS(MentsuList[]) //一つ以上の面子リストを取得
    case ERROR(String) //入力不正
    case CONFLICT  //入力不正ではないが、面子が不成立
    case FINISH   //これ以上面子はない
}

class MenzenResolver {

    //面前手牌の解析
    class func resolve(paiList: Pai[]) -> Agari[]?{
        let paiNumMaster : PaiNum[] = []
        //頭候補計算
        //辞書順に並び替え
        var sortedList  = sort(paiList,{(p1:Pai,p2:Pai) -> Bool in return p1.toString() < p2.toString()})
        var agariList: Agari[] = []
        //雀頭候補を検索
        for var i = 0; i < sortedList.count - 1; ++i {
            if sortedList[i] == sortedList[i+1]{ //雀頭候補発見
                var atama = ToitsuMentsu(pai: sortedList[i])
                //雀頭以外でPaiNumList作成して、面子解析
                var mmr:MakeMentsuResult = makeMentsuList(PaiNumList(paiList : sortedList.cut(i,i+1)))
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    //面子解析で得た結果のリストに対して、雀頭を足してagariオブジェクトを作っていく
                    for mentsuList in mentsuListList{
                        mentsuList.append(atama)
                        var agari :Agari = Agari(
                            atama: atama,
                            mentsuList: mentsuList
                        )
                        agariList.append(agari)
                    }
                case let .ERROR(msg):
                    Log.error("面子解析でエラー：" + msg);
                    return nil
                case let .FINISH:
                    Log.error("入力不正。メンゼン牌が０枚")
                    return nil
                case let .CONFLICT:
                    //この雀頭候補では残りの面子が成立しない
                    continue
                }
            }
        }
        //print debug
        for agari in agariList{
            Log.debug(agari.toString())
        }
        return agariList.unique()
    }
    


    //引数の牌のリストを解析し、可能性のある面子リストに分解
    //可能性のある面子リストが存在しない場合は空配列を返す
    class func makeMentsuList(paiNumList:PaiNumList,nest:Int = 0) -> MakeMentsuResult{
        Log.debug("[" + String(nest) + "]" + "makeMentsuList start " + String(nest) + " 引数：" + paiNumList.toString())
        var result : MentsuList[] = []
        if(paiNumList.count() == 0){
            Log.debug("[" + String(nest) + "]" + "残り枚数が0であるため、return")
            return MakeMentsuResult.FINISH
        }
        if(paiNumList.count() % 3 != 0){
            Log.error("[" + String(nest) + "]" + "残り枚数が3の倍数ではないため、入力不正")
            return MakeMentsuResult.ERROR("[" + String(nest) + "]" + "残り枚数が3の倍数ではないため、入力不正")
        }
        for paiNum in paiNumList.list{
            Log.debug("[" + String(nest) + "]" + "この牌について判定：" + paiNum.pai.toString())
            //アンコウを発見
            if paiNumList.includeAnkouOf(paiNum.pai) {
                Log.debug("[" + String(nest) + "]" + "アンコウを発見")
                var remainPaiNumList = paiNumList.removeAnkouOf(paiNum.pai)!
                var mentsu = AnkouMentsu(pai: paiNum.pai)
                Log.debug("[" + String(nest) + "]" + "除去した面子" + mentsu.toString())
                Log.debug("[" + String(nest) + "]" + "面子を除去した後の牌リスト" + remainPaiNumList.toString())
                //残りの牌を再帰計算
                var mmr : MakeMentsuResult = makeMentsuList(remainPaiNumList,nest:nest + 1)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    Log.debug("[" + String(nest) + "]" + "再帰計算で取得したMentsuListList: count=" + String(mentsuListList.count))
                    //print debug
                    for mentsuList in mentsuListList{
                        Log.debug("[" + String(nest) + "]" + " - " + mentsuList.toString())
                    }
                    //再帰計算の結果、残りの牌から面子リストのリストがかえってきた場合、そのリストに対して除去した面子を追記したリストを結果に追記
                    for mentsuList in mentsuListList{
                        //除去した面子を、再帰計算結果に追加
                        mentsuList.append(mentsu)
                        result.append(mentsuList)
                    }
                case let .FINISH:
                    //再帰計算の結果、残りの牌からは面子が見つからなかった場合、除去した面子だけを格納した面子リストを結果に追記
                    result.append(MentsuList(list: [mentsu]))
                case let .CONFLICT:
                    return MakeMentsuResult.CONFLICT
                case let .ERROR(msg):
                    return MakeMentsuResult.ERROR(msg)
                }
            }
            if paiNumList.includeShuntsuFrom(paiNum.pai) {
                //シュンツを発見
                Log.debug("[" + String(nest) + "]" + "シュンツを発見")
                var remainPaiNumList = paiNumList.removeShuntsuFrom(paiNum.pai)!
                var mentsu = ShuntsuMentsu(paiList: [paiNum.pai, paiNum.pai.next()!, paiNum.pai.next(range: 2)!])
                Log.debug("[" + String(nest) + "]" + "除去した面子" + mentsu.toString())
                Log.debug("[" + String(nest) + "]" + "面子を除去した後の牌リスト" + remainPaiNumList.toString())
                //残りの牌を再帰計算
                var mmr : MakeMentsuResult = makeMentsuList(remainPaiNumList,nest:nest + 1)
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    Log.debug("[" + String(nest) + "]" + "再帰計算で取得したMentsuListList: count=" + String(mentsuListList.count))
                    //print debug
                    for mentsuList in mentsuListList{
                        Log.debug("[" + String(nest) + "]" + " - " + mentsuList.toString())
                    }
                    //残りの牌から面子リストのリストがかえってきた場合、そのリストに対して除去した面子を追記したリストを結果に追記
                    for mentsuList in mentsuListList{
                        //除去した面子を、再帰計算結果に追加
                        mentsuList.append(mentsu)
                        result.append(mentsuList)
                    }
                case let .FINISH:
                    //残りの牌が０枚であった場合、除去した面子だけを格納した面子リストを結果に追記
                    result.append(MentsuList(list: [mentsu]))
                case let .CONFLICT:
                    //残り牌では面子が構成できない場合は、同じエラーを返す
                    return MakeMentsuResult.CONFLICT
                case let .ERROR(msg):
                    //残り牌が不正だった場合、同じエラーを返す
                    return MakeMentsuResult.ERROR(msg)
                }
            }
            if paiNumList.includeAnkouOf(paiNum.pai) || paiNumList.includeShuntsuFrom(paiNum.pai){
                //シュンツかトイツを見つけていた場合は即リターン
                //並び替え
                for mentsuList in result {
                    mentsuList.sortting()
                }
                //debug print
                Log.debug("[" + String(nest) + "]" + "return result")
                for mentsuList in result {
                    Log.debug("[" + String(nest) + "]" + " - " + mentsuList.toString())
                }
                return MakeMentsuResult.SUCCESS(result.unique())
            }
        }
        //ここまで処理が来るということはシュンツもアンコウも見つからなかったため、この入力では面子は成立しない
        return MakeMentsuResult.CONFLICT
    }
}