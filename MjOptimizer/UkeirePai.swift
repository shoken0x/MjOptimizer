//
//  UkeirePai.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

class UkeirePai: Equatable {
    
    var pai: Pai
    var remainNum: Int
    
    init(pai: Pai,remainNum: Int){
        self.pai = pai
        self.remainNum = remainNum
    }
    func getPai() -> Pai{return self.pai}
    func getRemainNum() -> Int{return self.remainNum}

}

func == (lhs: UkeirePai, rhs: UkeirePai) -> Bool {
    return lhs.pai == rhs.pai
}