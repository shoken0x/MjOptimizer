//
//  SutehaiSelectResult.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class SutehaiSelectResult {
<<<<<<< HEAD
    var sutehaiCandidateList : SutehaiCandidate[]
    var tehaiShantenNum : Int
    
    init(sutehaiCandidateList : SutehaiCandidate[],tehaiShantenNum : Int){
=======
    var sutehaiCandidateList : SutehaiCandidate[] //シャンテ数
    var tehaiShantenNum : Int //シャンテン数
    var tehai : Pai[] //手牌
    var isFinishAnalyze : Bool //解析に成功したか
    var successNum : Int //解析に成功した枚数
    
    init(sutehaiCandidateList : SutehaiCandidate[],tehaiShantenNum : Int,tehai : Pai[],isFinishAnalyze : Bool,successNum : Int){
>>>>>>> f984585add9706747e77859a0c96fefe2c034026
        self.sutehaiCandidateList = sutehaiCandidateList
        self.tehaiShantenNum = tehaiShantenNum
        self.tehai = tehai
        self.isFinishAnalyze = isFinishAnalyze
        self.successNum = successNum
        
    }
    func getSutehaiCandidateList() -> SutehaiCandidate[]{return self.sutehaiCandidateList}
    func getTehaiShantenNum() -> Int{return self.tehaiShantenNum}
    func getTehai() -> Pai[]{return self.tehai}
    func getSuccessNum() -> Int{return self.successNum}
    
}