//
//  TehaiProtocol.swift
//  MjOptimizer
//
//  Created by fetaro on 2014/06/21.
//  Copyright (c) 2014年 Shoken Fujisaki. All rights reserved.
//

import Foundation

protocol TehaiProtocol{
    // TODO: 実装
    func isAgari() -> Int
    func getShantenNum() -> Int
    func getShantenNumAsNormal() -> Int
    func getShantenNumAsChitoitsu() -> Int
    func getShantenNumAsKokushimuso() -> Int
    func getTatsuList() -> Tatsu[]
    func getToitsuList() -> Toitsu[]
    func getSingleList() -> Pai[]
}