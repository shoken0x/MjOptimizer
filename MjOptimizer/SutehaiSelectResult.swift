//
//  SutehaiSelectResult.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class SutehaiSelectResult {
    var sutehaiCandidateList : SutehaiCandidate[]? //候補のリスト
    var tehaiShantenNum : Int? //シャンテン数
    var tehai : Pai[] //手牌
    var isFinishAnalyze : Bool //解析に成功したか
    var successNum : Int //解析に成功した枚数
    
    init(sutehaiCandidateList : SutehaiCandidate[]?,tehaiShantenNum : Int?,tehai : Pai[],isFinishAnalyze : Bool,successNum : Int){
        self.sutehaiCandidateList = sutehaiCandidateList!
        self.tehaiShantenNum = tehaiShantenNum!
        self.tehai = tehai
        self.isFinishAnalyze = isFinishAnalyze
        self.successNum = successNum
        
    }
    func getSutehaiCandidateList() -> SutehaiCandidate[]{return self.sutehaiCandidateList!}
    func getTehaiShantenNum() -> Int{return self.tehaiShantenNum!}
    func getTehai() -> Pai[]{return self.tehai}
    func getSuccessNum() -> Int{return self.successNum}
    
}
