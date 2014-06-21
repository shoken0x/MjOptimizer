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
        // とりあえず通常形の上がりパターン解析のみ実装
        tehai = analyzeAsNormal(tehai)
        
        
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
        
        // Step.1 単独牌を先にsingle_listへ避けることで計算回数を減らす
        tehai = analyzeSingle(tehai)
        
        // もし単独牌が5枚以上であれば計算を終了する
        if tehai.singleList.count >= 5 {
            return tehai
        }
        
        // Step.2 字牌を解析する
        tehai = analyzeJihai(tehai)
        
        // Step.3 数牌を解析する
        // 面子優先と順子優先を試して良い方を採用する
        // TODO: 本当は1試行ごとに優先順位を変えないと正確ではない
        var tehai1 = analyzeKazuhai(tehai, priority: 1)  // 面子優先
        var tehai2 = analyzeKazuhai(tehai, priority: 2)  // 順子優先
        
        return tehai1.getShantenNum() > tehai2.getShantenNum() ? tehai2 : tehai1
    }
    
    // 七対子として解析する
    // 未実装
    func analyzeAsChitoitsu(tehai: Tehai) -> Tehai{
        return tehai
    }
    
    // 国士無双として解析する
    // 未実装
    func analyzeAsKokushimuso(tehai: Tehai) -> Tehai{
        return tehai
    }
    
    // 通常のあがり形解析に使用する
    // 単独牌を解析する
    func analyzeSingle(tehai:Tehai) -> Tehai{
//        
//        # 数牌で単独牌を抽出
//        [Type::Manzu, Type::Pinzu, Type::Souzu].each do |pai_type|
//        # 重複しない かつ 2つ以内の牌がない
//        manzu_list = get_selected_by_type(tehai.rest_pai_list, pai_type)
//        manzu_list.each do |target_pai|
//        selected_list = manzu_list.select do |pai|
//        pai == target_pai ||
//        pai.pai_type == target_pai.next_pai_type(1) ||
//        pai.pai_type == target_pai.next_pai_type(2) ||
//        pai.pai_type == target_pai.prev_pai_type(1) ||
//        pai.pai_type == target_pai.prev_pai_type(2)
//        end
//        if selected_list.count == 1
//        tehai.single_list << target_pai
//        tehai.rest_pai_list -= [target_pai]
//        end
//        end
//        end
        
        for type in [PaiType.MANZU, PaiType.SOUZU, PaiType.PINZU]{
            var selectedPaiList = getSelectByType(tehai.restPaiList, type: type)
            for pai in selectedPaiList {
                
            }
        }
        
        return tehai
    }
    
    // 字牌を解析する
    func analyzeJihai(tehai:Tehai) -> Tehai{
        
        var jihaiList = getSelectByType(tehai.restPaiList, type: PaiType.JIHAI)
        if jihaiList.count == 0 {
            return tehai
        }
        // Step.1 最初の1枚と同じ牌が何枚あるか
        var selectedPaiList = tehai.restPaiList.filter {$0.type == PaiType.JIHAI}
        
        switch(selectedPaiList.count){
        case 4:
            // TODO: 槓子対応
            //       とりあえず、面子+孤立牌として処理する
            tehai.singleList += selectedPaiList[3]
            tehai.mentsuList += Mentsu(paiList: selectedPaiList[0...2], type: MentsuType.KOTSU)
        case 3:
            tehai.mentsuList += Mentsu(paiList: selectedPaiList[0...2], type: MentsuType.KOTSU)
        case 2:
            tehai.toitsuList += Toitsu(paiList: selectedPaiList[0...1])
        case 1:
            tehai.singleList += selectedPaiList[0]
        default:
            // TODO: ERROR
            return tehai
        }
        
        // 見つかった牌を残りの手牌から引く
        for var i = 0; i < selectedPaiList.count; i++ {
            tehai.restPaiList.remove(selectedPaiList[i])
        }
        
        // 再帰的に処理を続ける
        return analyzeJihai(tehai)
    }
    
    // 数牌を解析する
    func analyzeKazuhai(var tehai: Tehai, priority: Int) -> Tehai{
        if priority == 1 {
            tehai = analyzeKazuhaiMentsu(tehai)
            tehai = analyzeKazuhaiSyuntsu(tehai)
        }
        else {
            tehai = analyzeKazuhaiSyuntsu(tehai)
            tehai = analyzeKazuhaiMentsu(tehai)
        }
        
        tehai = analyzeKazuhaiRyanmenchan(tehai)
        tehai = analyzeKazuhaiKanchan(tehai)
        tehai = analyzeKazuhaiPechan(tehai)
        tehai = analyzeKazuhaiToitsu(tehai)
        
        // 残牌数が0になっていれば正常終了
        if tehai.restPaiList.count == 0 {
            tehai.analyzedFlag = true
        }
        
        return tehai
    }
    
    // 刻子を解析する
    func analyzeKazuhaiMentsu(tehai:Tehai) -> Tehai{
        
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
            
            // filterを使えばrubyのArray#selectみたいなことをできる？
            //            selectedPaiList = tehai.restPaiList.filter {$0.equal(targetPai)}
            
            if selectedPaiList.count >= 3 {
                if selectedPaiList.count == 4 {
                    // TODO: 槓子対応
                    //       とりあえず、面子+孤立牌として処理する
                    tehai.singleList += selectedPaiList[3]
                }
                tehai.mentsuList += Mentsu(paiList: selectedPaiList[0...2], type: MentsuType.KOTSU)
                for var i = 0; i < selectedPaiList.count; i++ {
                    tehai.restPaiList.remove(selectedPaiList[i])
                }
                return analyzeKazuhaiToitsu(tehai)
            }
        }
        return tehai
    }
    
    // 順子を解析する
    func analyzeKazuhaiSyuntsu(tehai:Tehai) -> Tehai{
        
        for targetPai in tehai.restPaiList{
            if targetPai == nil{
                continue
            }
            
            var nextPai1: Pai? = nil
            var nextPai2: Pai? = nil
            for pai in tehai.restPaiList{
                if pai == targetPai.getNextPai(range: 1) {
                    nextPai1 = pai
                }
                if pai == targetPai.getNextPai(range: 2) {
                    nextPai2 = pai
                }
            }
            
            if nextPai1 != nil && nextPai2 != nil {
                tehai.mentsuList += Mentsu(paiList: [targetPai, nextPai1!, nextPai2!], type: MentsuType.SHUNTSU)
                tehai.restPaiList.remove(targetPai)
                tehai.restPaiList.remove(nextPai1!)
                tehai.restPaiList.remove(nextPai2!)
                analyzeKazuhaiPechan(tehai)
            }
        }
        return tehai
    }
    
    // リャンメンチャンを解析する
    func analyzeKazuhaiRyanmenchan(tehai:Tehai) -> Tehai{
        
        for targetPai in tehai.restPaiList{
            if targetPai == nil{
                continue
            }
            if targetPai.number == 1 && targetPai.number >= 8 {
                continue
            }
            
            var nextPai: Pai? = nil
            for pai in tehai.restPaiList{
                if pai == targetPai.getNextPai(range: 1) {
                    nextPai = pai
                }
            }
            
            if nextPai != nil {
                tehai.tatsuList += Tatsu(paiList: [targetPai, nextPai!], type: TatsuType.RYANMENCHAN)
                tehai.restPaiList.remove(targetPai)
                tehai.restPaiList.remove(nextPai!)
                analyzeKazuhaiPechan(tehai)
            }
        }
        return tehai
    }
    
    // カンチャンを解析する
    func analyzeKazuhaiKanchan(tehai:Tehai) -> Tehai{
        
        for targetPai in tehai.restPaiList{
            if targetPai == nil{
                continue
            }
            if targetPai.number > 7{
                continue
            }
            
            var nextPai: Pai? = nil
            for pai in tehai.restPaiList{
                if pai == targetPai.getNextPai(range: 2) {
                    nextPai = pai
                }
            }
            
            if nextPai != nil {
                tehai.tatsuList += Tatsu(paiList: [targetPai, nextPai!], type: TatsuType.KANCHAN)
                tehai.restPaiList.remove(targetPai)
                tehai.restPaiList.remove(nextPai!)
                analyzeKazuhaiPechan(tehai)
            }
        }
        return tehai
    }
    
    // ペンチャンを解析する
    func analyzeKazuhaiPechan(tehai:Tehai) -> Tehai{

        for targetPai in tehai.restPaiList{
            if targetPai == nil{
                continue
            }
            if targetPai.number != 1 && targetPai.number != 8{
                continue
            }
            
            var nextPai: Pai? = nil
            for pai in tehai.restPaiList{
                if pai == targetPai.getNextPai(range: 1) {
                    nextPai = pai
                }
            }
            
            if nextPai != nil {
                tehai.tatsuList += Tatsu(paiList: [targetPai, nextPai!], type: TatsuType.PENCHAN)
                tehai.restPaiList.remove(targetPai)
                tehai.restPaiList.remove(nextPai!)
                analyzeKazuhaiPechan(tehai)
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
            
            // filterを使えばrubyのArray#selectみたいなことをできる？
//            selectedPaiList = tehai.restPaiList.filter {$0.equal(targetPai)}
            
            if selectedPaiList.count == 2 {
                tehai.toitsuList += Toitsu(paiList: selectedPaiList)
                for var i = 0; i < selectedPaiList.count; i++ {
                    tehai.restPaiList.remove(selectedPaiList[i])
                }
                return analyzeKazuhaiToitsu(tehai)
            }
        }
        
        return tehai
    }
}
