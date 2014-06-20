//
//  SutehaiSelectorProtocol.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

protocol SutehaiSelectorProtocol{
    // TODO 五十嵐さんが実装する
    func select(paiList: Pai[]) -> SutehaiSelectResult

//    // 牌リストから指定したタイプの牌だけを選択する
//    func getSelectByType(paiList: Pai[], type: PaiType) -> Pai[]
//    
//    // 通常のあがり形として解析する
//    func analyzeAsNormal(result: SutehaiSelectResult) -> SutehaiSelectResult
//    
//    // 七対子として解析する
//    func analyzeAsChitoitsu(result: SutehaiSelectResult) -> SutehaiSelectResult
//    
//    // 国士無双として解析する
//    func analyzeAsKokushimuso(result: SutehaiSelectResult) -> SutehaiSelectResult
//    
//    // 通常のあがり形解析に使用する
//    // 単独牌を解析する
//    func analyzeSingle(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeJihai(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeKazuhai(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeKazuhaiMentsu(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeKazuhaiSyuntsu(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeKazuhaiRyanmenchan(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeKazuhaiKanchan(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeKazuhaiPechan(result: SutehaiSelectResult) -> SutehaiSelectResult
//    func analyzeKazuhaiToitsu(result: SutehaiSelectResult) -> SutehaiSelectResult
}