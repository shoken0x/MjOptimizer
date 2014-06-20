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
        
        // メインロジック
        
        
        
        
        
        var result = SutehaiSelectResult()
        return result
    }
    
    
    // 牌リストから指定したタイプの牌だけを選択する
    func getSelectByType(paiList: Pai[], type: Pai.PaiType) -> Pai[]{
        
        var selectedPaiList: Pai[] = []
        
        for pai in paiList {
            if pai.type == type {
                selectedPaiList += pai
            }
        }
        return selectedPaiList
    }
    
    // 通常のあがり形として解析する
    func analyzeAsNormal(tehai: Tehai) -> Tehai{
        
        tehai.agariType = Tehai.AgariType.AGARU_TYPE_NORMAL
        
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
        var tehai1 = analyzeKazuhai(tehai, 1)  // 面子優先
        var tehai2 = analyzeKazuhai(tehai, 2)  // 順子優先
        
        return tehai1.ShantenNum > tehai2.ShantenNum ? tehai2 : tehai1
    }
    
    // 七対子として解析する
    func analyzeAsChitoitsu(tehai: Tehai) -> Tehai{
        
    }
    
    // 国士無双として解析する
    func analyzeAsKokushimuso(tehai: Tehai) -> Tehai{
        
    }
    
    // 通常のあがり形解析に使用する
    // 単独牌を解析する
    func analyzeSingle(tehai:Tehai) -> Tehai{
        
    }
    func analyzeJihai(tehai:Tehai) -> Tehai{
        
    }
    func analyzeKazuhai(tehai: Tehai, priority: Int) -> Tehai{
        
    }
    func analyzeKazuhaiMentsu(tehai:Tehai) -> Tehai{
        
    }
    func analyzeKazuhaiSyuntsu(tehai:Tehai) -> Tehai{
        
    }
    func analyzeKazuhaiRyanmenchan(tehai:Tehai) -> Tehai{
        
    }
    func analyzeKazuhaiKanchan(tehai:Tehai) -> Tehai{
        
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
//        tehai
    }
    
    // 対子を解析する
    func analyzeKazuhaiToitsu(tehai: Tehai) -> Tehai{
        
        for targetPai in tehai.restPaiList{
            if targetPai == nil{
                continue
            }
            var selectedPaiList: Pai[] = []
            
            for pai in tehai.restPaiList{
                if pai == targetPai{
                    selectedPaiList += pai
                }
            }
            
            if selectedPaiList.count == 2 {
                tehai.toitsuList += selectedPaiList
                // TODO: 配列引く配列
                tehai.restPaiList -= selectedPaiList
                return analyzeKazuhaiToitsu(tehai)
            }
        }
    }
}
