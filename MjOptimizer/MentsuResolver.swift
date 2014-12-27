//
//  MentsuResolver.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/07/24.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public enum MentsuResolveResult{
    case SUCCESS([Agari]) //一つ以上のアガリリストを取得
    case ERROR(String) //入力不正
}

//面子解析クラス
public class MentsuResolver{
    //手牌の解析
    public class func resolve(paiList: [Pai]) -> MentsuResolveResult{
        if paiList.count < 14 || paiList.count > 18{
            return MentsuResolveResult.ERROR("牌の枚数が１４枚〜１８枚ではありません")
        }
        //ふうろを解析する
        let frr : FuroResolveResult = furoResolve(paiList)
        switch frr{
        case let .SUCCESS(furoMentsuList):
            //ふうろ以外の牌（＝めんぜん牌）を取得する
            let menzenPaiNum:Int = paiList.count - furoMentsuList.paiCount()
            let menzenPaiList = paiList.get(0..<menzenPaiNum)
            //面前牌を解析する
            let mmr : MenzenResolveResult = menzenResolve(menzenPaiList)
            switch mmr{
            case let .SUCCESS(agariList):
                for agari in agariList{
                    //面前の面子リストだけ入っているアガリに対して、ふうろを追加する
                    for m in furoMentsuList.array{agari.addMentsu(m)}
                }
                //面子の構成が正しいか確認
                for agari in agariList{
                    let toitsuNum = agari.mentsuList.filter{$0.type() == MentsuType.TOITSU}.count
                    let specialNum = agari.mentsuList.filter{($0.type() == MentsuType.KOKUSHI) || ($0.type() == MentsuType.SHISAN)}.count
                    let mentsuNum = agari.mentsuList.count
                    if !((mentsuNum == 5 && toitsuNum == 1 ) ||
                        (mentsuNum == 7 && toitsuNum == 7 ) ||
                        (mentsuNum == 1 && specialNum == 1 )){
                            return MentsuResolveResult.ERROR("5面子(うち1対子)、7対子、国士、シーサンのいずれでもありません。面子の数:" + String(mentsuNum) + ",トイツの数:" + String(toitsuNum) + ",特殊系数:" + String(specialNum))
                    }
                }
                return MentsuResolveResult.SUCCESS(agariList)
            case let .ERROR(msg):
                return MentsuResolveResult.ERROR(msg)
            }
        case let .ERROR(msg):
            return MentsuResolveResult.ERROR(msg)
        }
    }
    
    //牌リストから副露面子のリストを取得する
    public class func furoResolve(paiList:[Pai]) -> FuroResolveResult{
        var mentsuList : MentsuList = MentsuList()
        var tmpPaiList = paiList
        while true{
            let getOneFuroResult :GetOneFuroResult = getOneFuro(tmpPaiList)
            switch getOneFuroResult{
            case let .SUCCESS(mentsu):
                mentsuList.append(mentsu)
                Log.debug("副露面子取得：" + mentsu.toString())
                tmpPaiList = tmpPaiList[0..(tmpPaiList.count - mentsu.size())]//paiListを短くする
                continue
            case let .ERROR(str):
                Log.error("副露面子取得失敗：" + str)
                return FuroResolveResult.ERROR("副露面子取得失敗：" + str)
            case let .FINISH(str):
                Log.debug("副露面子取得完了：" + str)
                return FuroResolveResult.SUCCESS(mentsuList)
            }
        }
    }
    //paiListの右から検索し、一番最初の副露の面子を一つ返す
    public class func getOneFuro(paiList:[Pai]) -> GetOneFuroResult {
        Log.debug("副露面子解析開始：" + paiList.map{(pai:Pai) -> String in return pai.toString()}.implode(" ")!)
        var pl:[Pai] = paiList.reverse()
        
        if pl.count == 2 && pl[0] == pl[1]{
            return GetOneFuroResult.FINISH("牌の数が2枚なので終了(頭を残すのみ)")
        }
        else if pl.count == 2 && pl[0] != pl[1]{
            return GetOneFuroResult.ERROR("牌の数が2枚だが、違う種類であり、誤検知している")
        }
        else if pl.count < 5 {
            return GetOneFuroResult.ERROR("牌の数が1枚,3枚,4枚のいずれかであり、誤検知している")
        }
        
        //背面を向けた牌の数を計算
        var reversePai : Int = 0
        for pai in pl {
            if pai.isUra {
                reversePai += 1
            }
        }
        
        //メインルーチン
        if pl[0].isFuro || pl[1].isFuro || pl[2].isFuro {
            // step1. Pai配列の1〜3枚目に鳴き牌が存在する場合、チー、ポン、明槓のいずれかの可能性がある
            if pl[0] == pl[1] && pl[1] == pl[2] {
                // step1-1. Pai配列の1〜3枚目が全て同じ牌である場合、ポン、明槓のいずれかの可能性がある
                if pl[3].isFuro {
                    // step1-1-1.Pai配列の4枚目が鳴き牌である場合、ポンとなる
                    return GetOneFuroResult.SUCCESS(PonMentsu(pai: pl[0]))
                }
                else if pl[0] != pl[3] {
                    // step1-1-2. Pai配列の4枚目が1枚目と異なる牌である場合、ポンとなる
                    return GetOneFuroResult.SUCCESS(PonMentsu(pai: pl[0]))
                }//1-1-2終わり
                else if pl.count == 5 {
                    // step1-1-3. Pai配列の残り枚数が5枚の場合、ポンとなる（残りの2枚は雀頭）
                    // 到達不可能（残り枚数が2枚の場合、残りの2枚は確実に元の3枚と異なる牌であるため、step1-1-2が該当する）
                    return GetOneFuroResult.ERROR("到達不可能な分岐。プログラムのバグ")
                }
                else if pl.count == 6 {
                    // step1-1-4. Pai配列の残り枚数が6枚の場合、明槓となる（残りの2枚は雀頭）
                    return GetOneFuroResult.SUCCESS(MinkanMentsu(pai: pl[0]))
                }//1-1-4終わり
                else if pl.count == 7 {
                    // step1-1-5. Pai配列の残り枚数が7枚の場合、誤検知（雀頭が成立しなくなる）
                    return GetOneFuroResult.ERROR("残り枚数が７枚で雀頭が成立しなくなる。誤検知")
                }
                else if pl.count == 8 {
                    // step1-1-6. Pai配列の残り枚数が8枚の場合、ポンとなる（残りの5枚は雀頭＋面子）
                    return GetOneFuroResult.SUCCESS(PonMentsu(pai: pl[0]))
                }
                else{
                    // step1-1-7. Pai配列の残り枚数が9枚以上で、かつ4枚目が1〜3枚目と同じ牌である場合、ポン、明槓のいずれかの可能性がある
                    if ChiMentsu.isMadeFrom(pl[3..6]) {
                        // step1-1-7-1.
                        // 1〜4枚目の牌が全て同じ牌であり、4〜6枚目の牌の組み合わせがチーとなる（鳴き牌は6枚目）場合、
                        // 4〜6枚目の牌の組がチー面子となるのは確実であるため、1〜3枚目の牌の組はポン面子となる。
                        // (1〜3枚目の牌と4枚目の牌が同じであることは偶然。）
                        return GetOneFuroResult.SUCCESS(PonMentsu(pai: pl[0]))
                    }
                        // step1-1-7-2.
                        // 1〜4枚目の牌が全て同じであり、5〜7枚目の牌の組み合わせがチーとなる（鳴き牌は7枚目）場合、
                        // 1〜4枚目の牌は組となることが確実であるため、明槓面子となる。
                        // 不要処理（step1-1-7-3で包含され、かつ結果が同じため不要）
                        
                    else if pl[4].isFuro || pl[5].isFuro || pl[6].isFuro || pl[7].isFuro || pl[4].isUra || pl[5].isUra || pl[6].isUra || pl[7].isUra {
                        // step1-1-7-3.
                        // 1〜4枚目の牌が全て同じであり、5〜8枚目の牌のいずれかが鳴き牌か裏牌だった場合、
                        // この時点で4枚目を含むチー面子は存在せず、かつ同一牌が4枚までしか存在しないことから、
                        // 1〜4枚目の牌は組となることが確実であるため、明槓面子となる。
                        return GetOneFuroResult.SUCCESS(MinkanMentsu(pai:pl[0]))
                    }
                    else{
                        // step1-1-7-4.
                        // 4〜8枚目の全ての牌が鳴き牌でない場合、4または5枚目以降の牌は全て門前であることが確定となる。
                        if (pl.count - reversePai / 2) % 3 == 0 {
                            // step1-1-7-4-2. Pai配列の残り枚数から、背面を向けた牌の数の半分を引いた数が、3で割り切れる場合、1〜4枚目は明槓となる
                            return GetOneFuroResult.SUCCESS(MinkanMentsu(pai: pl[0]))
                        }
                        else if (pl.count - reversePai / 2) % 3 == 2 {
                            // step1-1-7-4-3. Pai配列の残り枚数から、背面を向けた牌の数の半分を引いた数が、3で割った余りが2の場合、1〜3枚目はポンとなる
                            return GetOneFuroResult.SUCCESS(PonMentsu(pai: pl[0]))
                        }
                        else{
                            // step1-1-7-4-4. Pai配列の残り枚数から、背面を向けた牌の数の半分を引いた数が、3で割った余りが1の場合、牌を誤検知している
                            return GetOneFuroResult.ERROR("Pai配列の残り枚数から、背面を向けた牌の数の半分を引いた数が、3で割った余りが1の場合、牌を誤検知している")
                            // self.MentsuResolvResult.code = MentsuResolvResult.ERROR_NAKI
                        }//1-1-7-4-4終わり
                    }//1-1-7-4終わり
                }//1-1-7終わり
            }//1-1終わり
            else if ChiMentsu.isMadeFrom(pl[0..3]) {
                // step1-2. Pai配列の1〜3枚目の組み合わせがチーとなる
                return GetOneFuroResult.SUCCESS(ChiMentsu(paiList: pl[0..3]))
            }//1-2終わり
            else{
                // step1-3. 牌を誤検知している
                return GetOneFuroResult.ERROR("1〜3牌目の中に鳴きの牌があるが、チーでもポンでもない場合である。これは牌を誤検知している")
            }//1-3終わり
        }//step1終わり
        else if pl[3].isFuro{
            // step2. Pai配列の1〜3枚目に鳴き牌が存在せず、かつ4枚目が鳴き牌の場合、明槓の可能性がある
            if pl[0] == pl[1] && pl[1] == pl[2] && pl[2] == pl[3] {
                // step2-1. Pai配列の1〜4枚目の全てが同じ牌である場合、明槓となる
                return GetOneFuroResult.SUCCESS(MinkanMentsu(pai: pl[0]))
            }else{
                // step2-2. 牌の並びが不正、または4枚目の牌を誤検知している
                return GetOneFuroResult.ERROR("Pai配列の1〜3枚目に鳴き牌が存在せず、かつ4枚目が鳴き牌があるが、4枚の牌が同じではない。これは牌を誤検知している")
            }//2-2終わり
        }//step2終わり
        else if pl[0].isUra || pl[1].isUra || pl[2].isUra || pl[3].isUra {
            // step3. 背面牌が含まれる場合
            if pl[0].isUra && !(pl[1].isUra) && !(pl[2].isUra) && pl[3].isUra && pl[1] == pl[2] {
                // step3-1. 裏表表裏
                return GetOneFuroResult.SUCCESS(AnkanMentsu(pai: pl[1]))
            }
            else if !(pl[0].isUra) && pl[1].isUra && pl[2].isUra && !(pl[3].isUra) && pl[0] == pl[3] {
                // step3-2. 表裏裏表
                return GetOneFuroResult.SUCCESS(AnkanMentsu(pai: pl[0]))
            }
            else{
                // step3-3
                return GetOneFuroResult.ERROR("1〜4枚目に背面を踏むにもかかわらず、裏表表裏、表裏裏表、のいずれでもない場合")
            }//step3-3終わり
        }//step3終わり
        return GetOneFuroResult.FINISH("1〜4枚目にも鳴き牌が存在せず、背面牌もない")
    }//funcの終わり
    
    //面前手牌の解析
    public class func menzenResolve(paiList: [Pai]) -> MenzenResolveResult{
        if paiList.count < 2{
            Log.error("入力の牌のリストが0〜1枚");
            return MenzenResolveResult.ERROR("入力の牌のリストが0〜1枚")
        }
        let agariPai : Pai = paiList.last!
        //頭候補計算
        //辞書順に並び替え
        var sortedList = paiList
        sort(&sortedList,{(p1:Pai,p2:Pai) -> Bool in return p1.toString() < p2.toString()})
        //牌の枚数ごとに整理した配列
        let paiNumList = PaiNumList(paiList:sortedList)
        //アガリ配列。以降はこの配列を埋めて、最後にリターンする
        var agariList: [Agari] = []
        
        //七対子判定
        if (sortedList.count == 14 && paiNumList.list.all{($0.num == 0 || $0.num == 2)} ){
            agariList.append(Agari(mentsuList:[
                ToitsuMentsu(pai:sortedList[0]),
                ToitsuMentsu(pai:sortedList[2]),
                ToitsuMentsu(pai:sortedList[4]),
                ToitsuMentsu(pai:sortedList[6]),
                ToitsuMentsu(pai:sortedList[8]),
                ToitsuMentsu(pai:sortedList[10]),
                ToitsuMentsu(pai:sortedList[12])
                ]))
        }

        //国士無双が成立するかどうか
        if sortedList.count == 14 {
            let strs = ["m1t","m9t","s1t","s9t","p1t","p9t","j1t","j2t","j3t","j4t","j5t","j6t","j7t"]
            if (strs.all{paiNumList.getNum(PaiMaster.pais[$0]!) >= 1} ){//牌が14枚で国士無双牌すべてが１枚以上あれば成立
                agariList.append(Agari(mentsuList:[KokushiMentsu(paiList:sortedList)]))
            }
        }
        //TODOしーさんぷーたが成立するかどうか
        if sortedList.count == 14 {
            if false{
                agariList.append(Agari(mentsuList:[ShisanputaMentsu(paiList:sortedList)]))
            }
        }
        
        //通常の４面子１雀頭構成
        //雀頭候補を検索
        for var i = 0; i < sortedList.count - 1; ++i {
            if sortedList[i] == sortedList[i+1]{ //雀頭候補発見
                var atama = ToitsuMentsu(pai: sortedList[i])
                //雀頭以外でPaiNumList作成して、面子解析
                var mmr : makeMenzenMentsuResult = makeMenzenMentsuList(PaiNumList(paiList : sortedList.cut(i,i+1)))
                switch mmr{
                case let .SUCCESS(mentsuListList):
                    //面子解析で得た結果のリストに対して、雀頭を足してagariオブジェクトを作っていく
                    for mentsuList in mentsuListList{
                        mentsuList.append(atama)
                        var agari :Agari = Agari(
                            mentsuList: mentsuList.array
                        )
                        agariList.append(agari)
                    }
                case let .ERROR(msg):
                    Log.error("面子解析でエラー：" + msg);
                    return MenzenResolveResult.ERROR("面子解析でエラー：" + msg);
                case let .FINISH:
                    //面子解析をした結果、雀頭以外の面子は0枚であった。雀頭だけでagariオブジェクトを作る
                    var mentsuList : [Mentsu] = [atama]
                    var agari :Agari = Agari( mentsuList: mentsuList)
                    agariList.append(agari)
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
        //重複除去
        agariList = agariList.unique()
        //ツモがどの面子に含まれるかを計算し、面子候補が複数ある場合はagariを分割する
        var newAgariList:[Agari] = []
        for agari in agariList{
            for mentsu in agari.notNakiMentsuList(){
                if mentsu.include(agariPai){
                    //ツモ牌を含む面子を見つけたため、その面子を「ツモ牌を含む面子」に交換して、newAgariListに追加
                    var newMentsu = mentsu.copy()
                    newMentsu.agariPai = agariPai
                    newAgariList.append(agari.replaceMenzenOneMentsu(mentsu,newMentsu:newMentsu))
                }
            }
        }
        if newAgariList.count == 0{
            return MenzenResolveResult.ERROR("プログラミングエラー。メンゼン牌にツモ牌が含まれていない")
        }
        //print debug
        for agari in newAgariList{
            Log.debug(agari.toString())
        }
        return MenzenResolveResult.SUCCESS(newAgariList.unique())
    }
    
    
    
    //引数の牌のリストを解析し、可能性のある面子リストに分解
    //可能性のある面子リストが存在しない場合は空配列を返す
    public class func makeMenzenMentsuList(paiNumList:PaiNumList,nest:Int = 0) -> makeMenzenMentsuResult{
        Log.debug("[" + String(nest) + "]" + "makeMenzenMentsuList start " + String(nest) + " 引数：" + paiNumList.toString())
        var result : [MentsuList] = []
        if(paiNumList.count() == 0){
            Log.debug("[" + String(nest) + "]" + "残り枚数が0であるため、return")
            return makeMenzenMentsuResult.FINISH
        }
        if(paiNumList.count() % 3 != 0){
            Log.error("[" + String(nest) + "]" + "残り枚数が3の倍数ではないため、入力不正")
            return makeMenzenMentsuResult.ERROR("[" + String(nest) + "]" + "残り枚数が3の倍数ではないため、入力不正")
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
                var mmr : makeMenzenMentsuResult = makeMenzenMentsuList(remainPaiNumList,nest:nest + 1)
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
                    return makeMenzenMentsuResult.CONFLICT
                case let .ERROR(msg):
                    return makeMenzenMentsuResult.ERROR(msg)
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
                var mmr : makeMenzenMentsuResult = makeMenzenMentsuList(remainPaiNumList,nest:nest + 1)
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
                    return makeMenzenMentsuResult.CONFLICT
                case let .ERROR(msg):
                    //残り牌が不正だった場合、同じエラーを返す
                    return makeMenzenMentsuResult.ERROR(msg)
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
                return makeMenzenMentsuResult.SUCCESS(result.unique())
            }
        }
        //ここまで処理が来るということはシュンツもアンコウも見つからなかったため、この入力では面子は成立しない
        return makeMenzenMentsuResult.CONFLICT
    }
    

}



public class MentsuList:Equatable{
    var array : [Mentsu]
    public init(){self.array = []}
    public init(list : [Mentsu]){ self.array = list }
    public func append(mentsu : Mentsu){self.array.append(mentsu)}
    public func toString() -> String{
        return "面子リスト:" + join(",",self.array.map({$0.toString() }))
    }
    public subscript(index:Int)->Mentsu{
        get{ return self.array[index] }
        set(mentsu){ self.array[index] = mentsu }
    }
    public func sortting(){
        sort(&self.array){return $0 < $1}
    }
    //含まれる牌の総数を返す
    public func paiCount() -> Int{
        var sum = 0
        for mentsu in self.array{
            sum += mentsu.size()
        }
        return sum
    }
    public func union(mentsuList:MentsuList){
        for mentsu in mentsuList.array{
            self.array.append(mentsu)
        }
    }
}

public func == (lhs: MentsuList, rhs: MentsuList) -> Bool {
    return lhs.toString() == rhs.toString()
}

public enum GetOneFuroResult{
    case SUCCESS(Mentsu) //一つの副露面子を取得
    case ERROR(String) //入力不正
    case FINISH(String) //これ以上副露面子はない
}

public enum FuroResolveResult {
    case SUCCESS(MentsuList)
    case ERROR(String)
}


public enum makeMenzenMentsuResult{
    case SUCCESS([MentsuList]) //一つ以上の面子リストを取得
    case ERROR(String) //入力不正
    case CONFLICT  //入力不正ではないが、面子が不成立
    case FINISH   //これ以上面子はない
}

public enum MenzenResolveResult {
    case SUCCESS([Agari])
    case ERROR(String)
}
