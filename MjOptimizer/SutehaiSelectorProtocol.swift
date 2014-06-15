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
}