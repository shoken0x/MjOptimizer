//コンパイルに異常に時間がかかるためコメントアウト

////
////  utehaiSelector.swift
////  MjOptimizer
////
////  Created by ryosuke on 2014/06/18.
////  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
////
//
//import Foundation
//
//public class SutehaiSelector: SutehaiSelectorProtocol{
////class SutehaiSelector{
//    
//    public init () {
//    }
//    
//    public func select(paiList: [Pai]) -> SutehaiSelectResult{
//        
//        var tehai = Tehai(paiList: paiList)
//        
//        // メインロジックをここに書く
//        // とりあえず通常形の上がりパターン解析のみ実装
//        tehai = analyzeAsNormal(tehai)
//        
//        
//        // SutehaiSelectResultを作るための処理
//        var sortedChunkList = tehai.getChunkList()
//        sort(&sortedChunkList){
//            p1,p2 in return p1.getPriority() < p2.getPriority()
//        }
//        var sutehaiCandidateList: [SutehaiCandidate] = []
//        for index in 0...2{
//            var sutehai = sortedChunkList[index].getPaiList()[0]
//            var ukeirePaiList: [UkeirePai] = []
//            for var cIndex = 0; sortedChunkList.count > cIndex; cIndex++ {
//                if index == cIndex {
//                    continue
//                }
//                for missingPai in sortedChunkList[cIndex].getMissingPaiList(){
//                    ukeirePaiList.append(UkeirePai(pai: missingPai, remainNum: 4))  // remainNumは後で
//                }
//            }
//            // ukeirePaiListの重複削除
//            ukeirePaiList = ukeirePaiList.unique()
//            
//            // positionの取得
//            var positionIndex: Int
//            for positionIndex = 0; paiList.count > positionIndex; positionIndex++ {
//                if sutehai == paiList[positionIndex] {
//                    break
//                }
//            }
//            
//            // TODO: シャンテン数は捨てたあと？それとも有効牌を引いたあと？
//            //       いったん0で仮置き
//            sutehaiCandidateList.append( SutehaiCandidate(pai: sutehai, ukeirePaiList: ukeirePaiList, shantenNum: tehai.getShantenNum(), positionIndex: positionIndex))
//        }
//        
//        return SutehaiSelectResult(sutehaiCandidateList: sutehaiCandidateList, tehaiShantenNum: tehai.getShantenNum() + 1, tehai: paiList, isFinishAnalyze: true, successNum: 14)
//    }
//    
//    
//    // 牌リストから指定したタイプの牌だけを選択する
//    public func getSelectByType(paiList: [Pai], type: PaiType) -> [Pai]{
//        
//        var selectedPaiList: [Pai] = []
//        
//        for pai in paiList {
//            if pai.type == type {
//                selectedPaiList.append(pai)
//            }
//        }
//        return selectedPaiList
//    }
//    
//    // 通常のあがり形として解析する
//    func analyzeAsNormal(var tehai: Tehai) -> Tehai{
//        
//        tehai.agariType = AgariType.AGARI_TYPE_NORMAL
//        
//        // 牌リストを残牌リストへコピーする
//        tehai.restPaiList = tehai.basePaiList
//        
//        // Step.1 単独牌を先にsingle_listへ避けることで計算回数を減らす
//        tehai = analyzeSingle(tehai)
//        
//        // もし単独牌が5枚以上であれば計算を終了する
//        if tehai.singleList.count >= 5 {
//            return tehai
//        }
//        
//        // Step.2 字牌を解析する
//        tehai = analyzeJihai(tehai)
//        
//        // Step.3 数牌を解析する
//        // 面子優先と順子優先を試して良い方を採用する
//        // TODO: 本当は1試行ごとに優先順位を変えないと正確ではない
//        var tehai1 = analyzeKazuhai(tehai.copy(), priority: 1)  // 面子優先
//        var tehai2 = analyzeKazuhai(tehai.copy(), priority: 2)  // 順子優先
//        
//        return tehai1.getShantenNum() > tehai2.getShantenNum() ? tehai2 : tehai1
//    }
//    
//    // 七対子として解析する
//    // 未実装
//    func analyzeAsChitoitsu(tehai: Tehai) -> Tehai{
//        return tehai
//    }
//    
//    // 国士無双として解析する
//    // 未実装
//    func analyzeAsKokushimuso(tehai: Tehai) -> Tehai{
//        return tehai
//    }
//    
//    // 通常のあがり形解析に使用する
//    // 単独牌を解析する
//    func analyzeSingle(tehai:Tehai) -> Tehai{
//        
//        // 牌種ごとに、1枚ずつ取り出し距離:2までの範囲に自分以外に牌がなければ単独牌とする
//        for type in [PaiType.MANZU, PaiType.SOUZU, PaiType.PINZU]{
//            var selectedPaiList = getSelectByType(tehai.restPaiList, type: type)
//            for targetPai in selectedPaiList {
//                var aroundPai: [Pai] = []
//                aroundPai = selectedPaiList.filter({ targetPai == $0 })
//                    + selectedPaiList.filter({ targetPai == $0.getNextPai(range: 1) })
//                    + selectedPaiList.filter({ targetPai == $0.getNextPai(range: 2) })
//                    + selectedPaiList.filter({ targetPai == $0.getPrevPai(range: 1) })
//                    + selectedPaiList.filter({ targetPai == $0.getPrevPai(range: 2) })
//                
//                if aroundPai.count == 1 {
//                    tehai.singleList.append( Single(pai: targetPai))
//                    tehai.restPaiList.remove(targetPai)
//                }
//            }
//        }
//        
//        return tehai
//    }
//    
//    // 字牌を解析する
//    func analyzeJihai(tehai:Tehai) -> Tehai{
//        
//        var jihaiList = getSelectByType(tehai.restPaiList, type: PaiType.JIHAI)
//        if jihaiList.count == 0 {
//            return tehai
//        }
//        // Step.1 最初の1枚と同じ牌が何枚あるか
//        var selectedPaiList = jihaiList.filter {$0.toString() == jihaiList[0].toString()}
//        
//        switch(selectedPaiList.count){
//        case 4:
//            // TODO: 槓子対応
//            //       とりあえず、面子+孤立牌として処理する
//            tehai.singleList.append(Single(pai: selectedPaiList[3]))
//            tehai.chunkList.append(Chunk(paiList: selectedPaiList[0...2], type: ChunkType.KOTSU))
//        case 3:
//            tehai.chunkList.append(Chunk(paiList: selectedPaiList[0...2], type: ChunkType.KOTSU))
//        case 2:
//            tehai.toitsuList.append(Toitsu(paiList: selectedPaiList[0...1]))
//        case 1:
//            tehai.singleList.append(Single(pai: selectedPaiList[0]))
//        default:
//            // TODO: ERROR
//            return tehai
//        }
//        
//        // 見つかった牌を残りの手牌から引く
//        for var i = 0; i < selectedPaiList.count; i++ {
//            tehai.restPaiList.remove(selectedPaiList[i])
//        }
//        
//        // 再帰的に処理を続ける
//        return analyzeJihai(tehai)
//    }
//    
//    // 数牌を解析する
//    func analyzeKazuhai(var tehai: Tehai, priority: Int) -> Tehai{
//        if priority == 1 {
//            tehai = analyzeKazuhaichunk(tehai)
//            tehai = analyzeKazuhaiSyuntsu(tehai)
//        }
//        else {
//            tehai = analyzeKazuhaiSyuntsu(tehai)
//            tehai = analyzeKazuhaichunk(tehai)
//        }
//        
//        tehai = analyzeKazuhaiRyanmenchan(tehai)
//        tehai = analyzeKazuhaiKanchan(tehai)
//        tehai = analyzeKazuhaiPechan(tehai)
//        tehai = analyzeKazuhaiToitsu(tehai)
//        
//        for pai in tehai.restPaiList{
//            tehai.singleList.append(Single(pai: pai))
//            tehai.restPaiList.remove(pai)
//        }
//        
//        // 残牌数が0になっていれば正常終了
////        if tehai.restPaiList.count == 0 {
////            tehai.analyzedFlag = true
////        }
//        tehai.analyzedFlag = true
//        
//        return tehai
//    }
//    
//    // 刻子を解析する
//    func analyzeKazuhaichunk(tehai:Tehai) -> Tehai{
//        
//        for targetPai in tehai.restPaiList{
//            //  Xcode 6.1だとエラーになる。そもそもこのif分の存在意義がわからないのでコメントアウト
////            if targetPai == nil{
////                continue
////            }
//            var selectedPaiList: [Pai] = []
//            
//            for pai in tehai.restPaiList{
//                if pai == targetPai {
//                    selectedPaiList.append(pai)
//                }
//            }
//            
//            // filterを使えばrubyのArray#selectみたいなことをできる？
//            //            selectedPaiList = tehai.restPaiList.filter {$0.equal(targetPai)}
//            
//            if selectedPaiList.count >= 3 {
//                if selectedPaiList.count == 4 {
//                    // TODO: 槓子対応
//                    //       とりあえず、面子+孤立牌として処理する
//                    tehai.singleList.append(Single(pai: selectedPaiList[3]))
//                }
//                tehai.chunkList.append(Chunk(paiList: selectedPaiList[0...2], type: ChunkType.KOTSU))
//                for var i = 0; i < selectedPaiList.count; i++ {
//                    tehai.restPaiList.remove(selectedPaiList[i])
//                }
//                return analyzeKazuhaichunk(tehai)
//            }
//        }
//        return tehai
//    }
//    
//    // 順子を解析する
//    func analyzeKazuhaiSyuntsu(tehai:Tehai) -> Tehai{
//        
//        for targetPai in tehai.restPaiList{
//            //  Xcode 6.1だとエラーになる。そもそもこのif分の存在意義がわからないのでコメントアウト
////            if targetPai == nil{
////                continue
////            }
//            
//            var nextPai1: Pai? = nil
//            var nextPai2: Pai? = nil
//            for pai in tehai.restPaiList{
//                if pai == targetPai.getNextPai(range: 1) {
//                    nextPai1 = pai
//                }
//                if pai == targetPai.getNextPai(range: 2) {
//                    nextPai2 = pai
//                }
//            }
//            
//            if nextPai1 != nil && nextPai2 != nil {
//                tehai.chunkList.append(Chunk(paiList: [targetPai, nextPai1!, nextPai2!], type: ChunkType.SHUNTSU))
//                tehai.restPaiList.remove(targetPai)
//                tehai.restPaiList.remove(nextPai1!)
//                tehai.restPaiList.remove(nextPai2!)
//                return analyzeKazuhaiSyuntsu(tehai)
//            }
//        }
//        return tehai
//    }
//    
//    // リャンメンチャンを解析する
//    func analyzeKazuhaiRyanmenchan(tehai:Tehai) -> Tehai{
//        
//        for targetPai in tehai.restPaiList{
////  Xcode 6.1だとエラーになる。そもそもこのif分の存在意義がわからないのでコメントアウト
////            if targetPai == nil{
////                continue
////            }
//            if targetPai.number == 1 || targetPai.number >= 8 {
//                continue
//            }
//            
//            var nextPai: Pai? = nil
//            for pai in tehai.restPaiList{
//                if pai == targetPai.getNextPai(range: 1) {
//                    nextPai = pai
//                }
//            }
//            
//            if nextPai != nil {
//                tehai.tatsuList.append(Tatsu(paiList: [targetPai, nextPai!], type: ChunkType.RYANMENCHAN))
//                tehai.restPaiList.remove(targetPai)
//                tehai.restPaiList.remove(nextPai!)
//                return analyzeKazuhaiRyanmenchan(tehai)
//            }
//        }
//        return tehai
//    }
//    
//    // カンチャンを解析する
//    func analyzeKazuhaiKanchan(tehai:Tehai) -> Tehai{
//        
//        for targetPai in tehai.restPaiList{
////  Xcode 6.1だとエラーになる。そもそもこのif分の存在意義がわからないのでコメントアウト
////            if targetPai == nil{
////                continue
////            }
//            if targetPai.number > 7{
//                continue
//            }
//            
//            var nextPai: Pai? = nil
//            for pai in tehai.restPaiList{
//                if pai == targetPai.getNextPai(range: 2) {
//                    nextPai = pai
//                }
//            }
//            
//            if nextPai != nil {
//                tehai.tatsuList.append(Tatsu(paiList: [targetPai, nextPai!], type: ChunkType.KANCHAN))
//                tehai.restPaiList.remove(targetPai)
//                tehai.restPaiList.remove(nextPai!)
//                return analyzeKazuhaiKanchan(tehai)
//            }
//        }
//        return tehai
//    }
//    
//    // ペンチャンを解析する
//    func analyzeKazuhaiPechan(tehai:Tehai) -> Tehai{
//
//        for targetPai in tehai.restPaiList{
//            //  Xcode 6.1だとエラーになる。そもそもこのif分の存在意義がわからないのでコメントアウト
////            if targetPai == nil{
////                continue
////            }
//            if targetPai.number != 1 || targetPai.number != 8 {
//                continue
//            }
//            
//            var nextPai: Pai? = nil
//            for pai in tehai.restPaiList{
//                if pai == targetPai.getNextPai(range: 1) {
//                    nextPai = pai
//                }
//            }
//            
//            if nextPai != nil {
//                tehai.tatsuList.append(Tatsu(paiList: [targetPai, nextPai!], type: ChunkType.PENCHAN))
//                tehai.restPaiList.remove(targetPai)
//                tehai.restPaiList.remove(nextPai!)
//                return analyzeKazuhaiPechan(tehai)
//            }
//        }
//        return tehai
//    }
//    
//    // 対子を解析する
//    func analyzeKazuhaiToitsu(tehai: Tehai) -> Tehai{
//        
//        for targetPai in tehai.restPaiList{
//            //  Xcode 6.1だとエラーになる。そもそもこのif分の存在意義がわからないのでコメントアウト
////            if targetPai == nil{
////                continue
////            }
//            var selectedPaiList: [Pai] = []
//            
//            for pai in tehai.restPaiList{
//                if pai == targetPai {
//                    selectedPaiList.append(pai)
//                }
//            }
//            
//            // filterを使えばrubyのArray#selectみたいなことをできる？
////            selectedPaiList = tehai.restPaiList.filter {$0.equal(targetPai)}
//            
//            if selectedPaiList.count == 2 {
//                tehai.toitsuList.append(Toitsu(paiList: selectedPaiList))
//                for var i = 0; i < selectedPaiList.count; i++ {
//                    tehai.restPaiList.remove(selectedPaiList[i])
//                }
//                return analyzeKazuhaiToitsu(tehai)
//            }
//        }
//        
//        return tehai
//    }
//}
