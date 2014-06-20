//
//  SutehaiSelectResult.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class SutehaiSelectResult {
    var sutehaiCandidateList : SutehaiCandidate[]
    var tehaiShantenNum : Int
    
    init(sutehaiCandidateList : SutehaiCandidate[],tehaiShantenNum : Int){
        self.sutehaiCandidateList = sutehaiCandidateList
        self.tehaiShantenNum = tehaiShantenNum
    }
    func getSutehaiCandidateList() -> SutehaiCandidate[]{return self.sutehaiCandidateList}
    func getTehaiShantenNum() -> Int{return self.tehaiShantenNum}
}