//
//  utehaiSelector.swift
//  MjOptimizer
//
//  Created by ryosuke on 2014/06/18.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class SutehaiSelector: SutehaiSelectorProtocol{
//class SutehaiSelector{
    
    init () {
    }
    
    func select(paiList: Pai[]) -> SutehaiSelectResult{
        
        var tehai = Tehai()
        tehai.basePaiList = paiList
        
        // メインロジックをここに書く
        
        
        
        // resultを作るための空オブジェクト
        var ukeirePaiList = [UkeirePai(pai: Pai.parse("m1t")!, remainNum: 0)]
        var sc = [SutehaiCandidate(pai: Pai.parse("m1t")!, ukeirePaiList: ukeirePaiList, shantenNum: 0, positionIndex: 0)]
        //TODO 正しいものを埋めてください
        var result = SutehaiSelectResult(sutehaiCandidateList: sc, tehaiShantenNum: 0,tehai : [],isFinishAnalyze : false,successNum : 0)
        
        return result
    }
    
    
    // 牌リストから指定したタイプの牌だけを選択する
    func getSelectByType(paiList: Pai[], type: PaiType) -> Pai[]{
        
        var selectedPaiList: Pai[] = []
        
        for pai in paiList {
            if pai.type == type {
                selectedPaiList += pai
            }
        }
        return selectedPaiList
    }
    
    // 通常のあがり形として解析する
    func analyzeAsNormal(var tehai: Tehai) -> Tehai{
        
        tehai.agariType = AgariType.AGARI_TYPE_NORMAL
        
        // 牌リストを残牌リストへコピーする
        tehai.restPaiList = tehai.basePaiList
        
        // Step.0 単独牌を先にsingle_listへ避けることで計算回数を減らす
        tehai = analyzeSingle(tehai)
        
        // Step.0-1 もし単独牌が5枚以上であれば計算を終了する
        if tehai.singleList.count >= 5 {
            return tehai
        }
        
        // Step.1 字牌を解析する
        tehai = analyzeJihai(tehai)
        
        // Step.2 数牌を解析する
        // 面子優先と順子優先を試して良い方を採用する
        // TODO: 本当は1試行ごとに優先順位を変えないと正確ではない
        var tehai1 = analyzeKazuhai(tehai, priority: 1)  // 面子優先
        var tehai2 = analyzeKazuhai(tehai, priority: 2)  // 順子優先
        
        return tehai1.getShantenNum() > tehai2.getShantenNum() ? tehai2 : tehai1
    }
    
    // 七対子として解析する
    func analyzeAsChitoitsu(tehai: Tehai) -> Tehai{
        return tehai
    }
    
    // 国士無双として解析する
    func analyzeAsKokushimuso(tehai: Tehai) -> Tehai{
        return tehai
    }
    
    // 通常のあがり形解析に使用する
    // 単独牌を解析する
    func analyzeSingle(tehai:Tehai) -> Tehai{
        return tehai
    }
    func analyzeJihai(tehai:Tehai) -> Tehai{
        return tehai

        
    }
    func analyzeKazuhai(tehai: Tehai, priority: Int) -> Tehai{
        return tehai

        
    }
    func analyzeKazuhaiMentsu(tehai:Tehai) -> Tehai{
        return tehai

        
    }
    func analyzeKazuhaiSyuntsu(tehai:Tehai) -> Tehai{
        return tehai

        
    }
    func analyzeKazuhaiRyanmenchan(tehai:Tehai) -> Tehai{
        return tehai

        
    }
    func analyzeKazuhaiKanchan(tehai:Tehai) -> Tehai{
        return tehai

        
    }
    // ペンチャンを解析する
    func analyzeKazuhaiPechan(tehai:Tehai) -> Tehai{
//        tehai.rest_pai_list.each do |target_pai|
//        next if target_pai.nil?
//        next unless target_pai.number.to_i == 1 || target_pai.number.to_i == 8
//        next1 = tehai.rest_pai_list.find{|pai| pai.pai_type == target_pai.next_pai_type(1)}
//        if next1
//        tehai.tatsu_list << Tatsu.new([target_pai, next1], "p")
//        tehai.rest_pai_list -= [target_pai, next1]
//        return parse_penchan(tehai)
//        end
//        end
        for targetPai in tehai.restPaiList{
            if targetPai == nil{
                continue
            }
            if targetPai.number != 1 && targetPai.number != 8{
                continue
            }
            
            var nextPai: Pai
            for pai in tehai.restPaiList{
                if pai.name() == targetPai.getNextPai(range: 1) {
                    nextPai = pai
                }
            }
            
            if nextPai == nil {
                tehai.tatsuList = Tatsu([targetPai, nextPai], )
                // TODO: 配列引く配列
                //                tehai.restPaiList -= selectedPaiList
                analyzeKazuhaiPechan(tehai)
            }
            
            
//            selectedPaiList = tehai.restPaiList.filter {$0.equal(targetPai.getNextPai(1))}
            
            if selectedPaiList.count == 2 {
                // TODO: += メソッドを作る
                tehai.toitsuList += Toitsu(paiList: selectedPaiList)
                // TODO: 配列引く配列
                //                tehai.restPaiList -= selectedPaiList
                tehai.restPaiList.remove(Pai.parse("m1t")!)
                //                tehai.restPaiList.removeAtIndex(0)
                return analyzeKazuhaiToitsu(tehai)
            }
        }
        return tehai
    }
    
    // 対子を解析する
    func analyzeKazuhaiToitsu(tehai: Tehai) -> Tehai{
        
        for targetPai in tehai.restPaiList{
            if targetPai == nil{
                continue
            }
            var selectedPaiList: Pai[] = []
            
            for pai in tehai.restPaiList{
                if pai.equal(targetPai) {
                    selectedPaiList += pai
                }
            }
            
//            selectedPaiList = tehai.restPaiList.filter {$0.equal(targetPai)}
            
            if selectedPaiList.count == 2 {
                // TODO: += メソッドを作る
                tehai.toitsuList += Toitsu(paiList: selectedPaiList)
                // TODO: 配列引く配列
//                tehai.restPaiList -= selectedPaiList
                tehai.restPaiList.remove(Pai.parse("m1t")!)
//                tehai.restPaiList.removeAtIndex(0)
                return analyzeKazuhaiToitsu(tehai)
            }
        }
        
        return tehai
    }
}
