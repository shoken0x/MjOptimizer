//
//  UkeirePai.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/15.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

public class UkeirePai: Equatable {
    
    var pai: Pai
    var remainNum: Int
    
    public init(pai: Pai,remainNum: Int){
        self.pai = pai
        self.remainNum = remainNum
    }
    public func getPai() -> Pai{return self.pai}
    public func getRemainNum() -> Int{return self.remainNum}

}

public func == (lhs: UkeirePai, rhs: UkeirePai) -> Bool {
    return lhs.pai == rhs.pai
}