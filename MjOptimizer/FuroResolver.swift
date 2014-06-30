////
////  FuroResolver.swift
////  MjOptimizer
////
////  Created by fetaro on 2014/06/27.
////  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
////


import Foundation

//getOneFuroの結果。
enum GetOneFuroResult{
    case SUCCESS(Mentsu) //一つの副露面子を取得
    case ERROR(String) //入力不正
    case FINISH(String) //これ以上副露面子はない
}

class FuroResolver {
    
    //paiListの右から検索し、一番最初の副露の面子を一つ返す
    class func getOneFuro(paiList:Pai[]) -> GetOneFuroResult {
        var pl:Pai[] = paiList.reverse()

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
            if pai.type == PaiType.REVERSE {
                reversePai += 1
            }
        }
        
        //メインルーチン
        if pl[0].isNaki() || pl[1].isNaki() || pl[2].isNaki() {
            // step1. Pai配列の1〜3枚目に鳴き牌が存在する場合、チー、ポン、明槓のいずれかの可能性がある
            if pl[0] == pl[1] && pl[1] == pl[2] {
                // step1-1. Pai配列の1〜3枚目が全て同じ牌である場合、ポン、明槓のいずれかの可能性がある
                if pl[3].isNaki() {
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
                    if MentsuFactory.isChi(pl[3..6]) {
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

                    else if pl[4].isNaki() || pl[5].isNaki() || pl[6].isNaki() || pl[7].isNaki() {
                        // step1-1-7-3.
                        // 1〜4枚目の牌が全て同じであり、5〜8枚目の牌のいずれかが鳴き牌だった場合、
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
            else if MentsuFactory.isChi(pl[0..3]) {
                // step1-2. Pai配列の1〜3枚目の組み合わせがチーとなる
                return GetOneFuroResult.SUCCESS(ChiMentsu(paiList: pl[0..3]))
            }//1-2終わり
            else{
                // step1-3. 牌を誤検知している
                return GetOneFuroResult.ERROR("1〜3牌目の中に鳴きの牌があるが、チーでもポンでもない場合である。これは牌を誤検知している")
            }//1-3終わり
        }//step1終わり
        else if pl[3].isNaki(){
            // step2. Pai配列の1〜3枚目に鳴き牌が存在せず、かつ4枚目が鳴き牌の場合、明槓の可能性がある
            if pl[0] == pl[1] && pl[1] == pl[2] && pl[2] == pl[3] {
                // step2-1. Pai配列の1〜4枚目の全てが同じ牌である場合、明槓となる
                return GetOneFuroResult.SUCCESS(MinkanMentsu(pai: pl[0]))
            }else{
                // step2-2. 牌の並びが不正、または4枚目の牌を誤検知している
                return GetOneFuroResult.ERROR("Pai配列の1〜3枚目に鳴き牌が存在せず、かつ4枚目が鳴き牌があるが、4枚の牌が同じではない。これは牌を誤検知している")
            }//2-2終わり
        }//step2終わり
        else if pl[0].type == PaiType.REVERSE || pl[1].type == PaiType.REVERSE {
            // step3. 背面牌が含まれる場合
            if pl[0].type == PaiType.REVERSE && pl[1].type != PaiType.REVERSE && pl[1] == pl[2] && pl[0] == pl[3] {
                // step3-1. 裏表表裏
                return GetOneFuroResult.SUCCESS(AnkanMentsu(pai: pl[1]))
            }
            else if pl[0].type != PaiType.REVERSE && pl[1].type == PaiType.REVERSE && pl[0] == pl[3] && pl[1] == pl[2] {
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
}//クラスの終わり
